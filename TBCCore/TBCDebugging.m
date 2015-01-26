//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCDebugging.h"


#if defined(DEBUG) && DEBUG != 0

#import <objc/runtime.h>
#import <sys/sysctl.h>


static NSArray *TBCKVODebuggingDefaultNSLogSinkIngoredClassPrefixes = nil;

@implementation TBCKVODebuggingDefaultNSLogSink
+ (void)initialize {
    if (self == [TBCKVODebuggingDefaultNSLogSink class]) {
        TBCKVODebuggingDefaultNSLogSinkIngoredClassPrefixes = @[
            @"CA",
            @"_CA",
            @"UI",
            @"_UI",
            @"_NS",
        ];
    }
}
- (instancetype)init {
    if ((self = [super init])) {
    }
    return self;
}
- (BOOL)shouldLogChangeForObject:(NSObject *)object key:(NSString *)key {
    NSString * const className = NSStringFromClass(object.class);
    for (NSString *prefix in TBCKVODebuggingDefaultNSLogSinkIngoredClassPrefixes) {
        if ([className hasPrefix:prefix]) {
            return NO;
        }
    }
    return YES;
}
- (void)object:(NSObject *)object willChangeValueForKey:(NSString *)key {
    if ([self shouldLogChangeForObject:object key:key]) {
        NSObject * const value = [object valueForKey:key];
        NSLog(@"TBCKVODebugging object:<%@:%p> willChangeValueForKey:%@ (<%@:%p>)", NSStringFromClass(object.class), object, key, NSStringFromClass(value.class), value);
    }
}
- (void)object:(NSObject *)object didChangeValueForKey:(NSString *)key {
    if ([self shouldLogChangeForObject:object key:key]) {
        NSObject * const value = [object valueForKey:key];
        NSLog(@"TBCKVODebugging object:<%@:%p> didChangeValueForKey:%@ (<%@:%p>)", NSStringFromClass(object.class), object, key, NSStringFromClass(value.class), value);
    }
}
@end


static NSPointerArray *TBCKVODebuggers = nil;

@interface TBCKVODebugger : NSObject<TBCKVODebugger>
@end
@implementation TBCKVODebugger {
@private
    id<TBCKVODebuggingSink> _sink;
}
- (instancetype)init {
    return [self initWithSink:nil];
}
- (instancetype)initWithSink:(id<TBCKVODebuggingSink>)sink {
    if ((self = [super init])) {
        _sink = sink;
        [TBCKVODebuggers addPointer:(__bridge void *)(self)];
        [TBCKVODebuggers compact];
    }
    return self;
}
- (void)object:(NSObject *)object willChangeValueForKey:(NSString *)key {
    [_sink object:object willChangeValueForKey:key];
}
- (void)object:(NSObject *)object didChangeValueForKey:(NSString *)key {
    [_sink object:object didChangeValueForKey:key];
}
@end


typedef void (*TBCKVODebuggingNSObject_willChangeValueForKey__f)(NSObject *self, SEL _sel, NSString *key);
typedef void (*TBCKVODebuggingNSObject_didChangeValueForKey__f)(NSObject *self, SEL _sel, NSString *key);

static TBCKVODebuggingNSObject_willChangeValueForKey__f NSObject_willChangeValueForKey_ = NULL;
static TBCKVODebuggingNSObject_didChangeValueForKey__f NSObject_didChangeValueForKey_ = NULL;

static void TBCKVODebuggingNSObject_willChangeValueForKey_(NSObject *self, SEL _sel, NSString *key) {
    for (TBCKVODebugger *d in TBCKVODebuggers) {
        [d object:self willChangeValueForKey:key];
    }
    NSObject_willChangeValueForKey_(self, _sel, key);
}

static void TBCKVODebuggingNSObject_didChangeValueForKey_(NSObject *self, SEL _sel, NSString *key) {
    NSObject_didChangeValueForKey_(self, _sel, key);
    for (TBCKVODebugger *d in TBCKVODebuggers) {
        [d object:self didChangeValueForKey:key];
    }
}


@implementation TBCKVODebugging

+ (void)initialize {
    if (self == [TBCKVODebugging class]) {
        TBCKVODebuggers = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsObjectPersonality|NSPointerFunctionsWeakMemory];
        Class const NSObjectClass = NSObject.class;
        NSObject_willChangeValueForKey_ = (TBCKVODebuggingNSObject_willChangeValueForKey__f)class_replaceMethod(NSObjectClass, @selector(willChangeValueForKey:), (IMP)TBCKVODebuggingNSObject_willChangeValueForKey_, "v@:@");
        NSObject_didChangeValueForKey_ = (TBCKVODebuggingNSObject_didChangeValueForKey__f)class_replaceMethod(NSObjectClass, @selector(didChangeValueForKey:), (IMP)TBCKVODebuggingNSObject_didChangeValueForKey_, "v@:@");
    }
}

+ (id<TBCKVODebugger>)debuggerWithSink:(id<TBCKVODebuggingSink>)sink {
    return [[TBCKVODebugger alloc] initWithSink:sink];
}

@end

void _TBCExpectDealloc(id object, char *file, int line, dispatch_block_t expectationFailedBlock) {
    __weak id wObject = object;
    NSArray * const callStackSymbols = [NSThread callStackSymbols];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        id sObject = wObject;
        if (sObject) {
            NSLog(@"%@ object at %p failed to be deallocated when expected", [sObject class], sObject);
            NSLog(@"at %s:%d", file, line);
            NSLog(@"Call Stack:\n%@", [callStackSymbols componentsJoinedByString:@"\n"]);
            expectationFailedBlock();
        }
    });
}

void _TBCExpectDeallocFailed(void) {
    TBCDebugger();
}



BOOL TBCIsBeingDebugged(void) {
    int mib[4] = {
        CTL_KERN,
        KERN_PROC,
        KERN_PROC_PID,
        getpid(),
    };
    
    struct kinfo_proc info;
    info.kp_proc.p_flag = 0; // init the field we'll read
    
    size_t infoSize = sizeof(info);
    if (!sysctl(mib, sizeof(mib)/sizeof(*mib), &info, &infoSize, NULL, 0)) {
        return !!(info.kp_proc.p_flag & P_TRACED);
    }
    
    return NO;
}

void TBCDebugger() {
    if (TBCIsBeingDebugged()) {
#if defined(__x86_64__) && __x86_64__ != 0
        asm("int3");
#elif defined(__i386__) && __i386__ != 0
        asm("int3");
#else
        __builtin_trap();
#endif
    }
}

#endif
