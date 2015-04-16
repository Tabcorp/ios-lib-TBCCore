//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "NSDictionary+TBCCore.h"

#import <objc/runtime.h>

@implementation NSDictionary(TBCCore)

+ (void)load {
    //This swizzling is purely to avoid trampolining through the tbc_map: implementation
    {
        IMP imp = class_getMethodImplementation(self, @selector(tbc_dictionaryByApplyingMap:));
        class_replaceMethod(self, @selector(tbc_map:), imp, "@@:@");
    }
}

- (NSDictionary *)tbc_map:(TBCCoreMapKeyAndObjectToObjectBlock)block {return [self tbc_dictionaryByApplyingMap:block];}

#define X(__retType, __initializer) \
    NSParameterAssert(block);\
    NSUInteger initialCount = self.count;\
    __block NSUInteger i = 0;\
    id __strong *objects = (id __strong *)calloc(initialCount, sizeof(id));\
    id<NSCopying> __strong *keys = (id<NSCopying> __strong *)calloc(initialCount, sizeof(id<NSCopying>));\
    [self enumerateKeysAndObjectsUsingBlock:^(id<NSCopying> key, id obj, __unused BOOL *stop) {\
        id mapped = block(key, obj);\
        if (mapped) {\
            keys[i] = key;\
            objects[i] = mapped;\
            ++i;\
        }\
    }];\
    const NSUInteger count = i;\
    __retType *result = __initializer;\
    while ( i > 0 ) {\
        --i;\
        keys[i] = nil;\
        objects[i] = nil;\
    }\
    free(keys);\
    free(objects);\
    return result;

#define X_NOKEY(__retType, __initializer) \
    NSParameterAssert(block);\
    NSUInteger initialCount = self.count;\
    __block NSUInteger i = 0;\
    id __strong *objects = (id __strong *)calloc(initialCount, sizeof(id));\
    [self enumerateKeysAndObjectsUsingBlock:^(id<NSCopying> key, id obj, __unused BOOL *stop) {\
        id mapped = block(key, obj);\
        if (mapped) {\
            objects[i] = mapped;\
            ++i;\
        }\
    }];\
    const NSUInteger count = i;\
    __retType *result = __initializer;\
    while ( i > 0 ) {\
        --i;\
        objects[i] = nil;\
    }\
    free(objects);\
    return result;


- (NSDictionary *)tbc_dictionaryByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block {
    X(NSDictionary, [NSDictionary dictionaryWithObjects:objects forKeys:keys count:count]);
}

- (NSMutableDictionary *)tbc_mutableDictionaryByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block {
    X(NSMutableDictionary, [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys count:count]);
}

- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block {
    X_NOKEY(NSArray, [NSArray arrayWithObjects:objects count:count]);
}

- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block {
    X_NOKEY(NSMutableArray, [NSMutableArray arrayWithObjects:objects count:count]);
}

- (NSSet *)tbc_setByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block {
    X_NOKEY(NSSet, [NSSet setWithObjects:objects count:count]);
}

- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block {
    X_NOKEY(NSMutableSet, [NSMutableSet setWithObjects:objects count:count]);
}

- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block {
    X_NOKEY(NSCountedSet, [NSCountedSet setWithObjects:objects count:count]);
}

#undef X
#undef X_NOKEY

@end
