//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCDeallocNotifier.h"

#import <objc/runtime.h>


@interface TBCDeallocNotifierInternal : NSObject<TBCDeallocNotifier>
- (instancetype)init NS_UNAVAILABLE;
- (instancetype __nonnull)initWithObject:(NSObject *)object block:(TBCDeallocNotificationBlock __nonnull)block NS_DESIGNATED_INITIALIZER;
@end

@implementation TBCDeallocNotifierInternal {
@private
    NSObject * __weak _object;
    TBCDeallocNotificationBlock _block;
}

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
- (instancetype)initWithObject:(NSObject *)object block:(TBCDeallocNotificationBlock)block {
    if ((self = [super init])) {
        _object = object;
        _block = [block copy];

        objc_setAssociatedObject(object, (__bridge const void *)(self), self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return self;
}

- (void)dealloc {
    if (!_object) {
        _block();
    }
}


- (void)invalidate {
    NSObject * const object = _object;
    _block = nil;

    if (!object) {
        NSAssert(object, @"");
        return;
    }

    objc_setAssociatedObject(object, (__bridge const void *)(self), NULL, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@interface TBCDeallocNotifier : NSObject<TBCDeallocNotifier>
- (instancetype)init NS_UNAVAILABLE;
- (instancetype __nonnull)initWithObject:(NSObject *)object block:(TBCDeallocNotificationBlock __nonnull)block NS_DESIGNATED_INITIALIZER;
@end

@implementation TBCDeallocNotifier {
@private
    TBCDeallocNotifierInternal * __weak _internal;
}

- (instancetype)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
- (instancetype)initWithObject:(NSObject *)object block:(TBCDeallocNotificationBlock)block {
    if ((self = [super init])) {
        TBCDeallocNotifierInternal * const internal = [[TBCDeallocNotifierInternal alloc] initWithObject:object block:block];
        _internal = internal;
    }
    return self;
}

- (void)dealloc {
    [self invalidate];
}


- (void)invalidate {
    [_internal invalidate];
}

@end


__attribute__((warn_unused_result))
id<TBCDeallocNotifier> TBCAttachDeallocNotifier(NSObject *object, TBCDeallocNotificationBlock block) {
    return [[TBCDeallocNotifier alloc] initWithObject:object block:block];
}
