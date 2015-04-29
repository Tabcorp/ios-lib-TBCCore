//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import "NSSet+TBCCore.h"

#include <libkern/OSAtomic.h>

#import <objc/runtime.h>

@implementation NSSet(TBCCore)

+ (void)load {
    //This swizzling is purely to avoid trampolining through the tbc_map: | tbc_filter: implementations
    {
        IMP imp = class_getMethodImplementation(self, @selector(tbc_setByApplyingMap:));
        class_replaceMethod(self, @selector(tbc_map:), imp, "@@:@");
    }
    
    {
        IMP imp = class_getMethodImplementation(self, @selector(tbc_setByFilteringWithPredicateBlock:));
        class_replaceMethod(self, @selector(tbc_filter:), imp, "@@:@");
    }
}

- (NSSet *)tbc_map:(TBCCoreMapObjectToObjectBlock)block {return [self tbc_setByApplyingMap:block];}

#define X(__retType, __initializer) \
    NSParameterAssert(block);\
    __block NSUInteger i = 0;\
    id __strong *objects = (id __strong *)calloc(self.count, sizeof(id));\
    [self enumerateObjectsUsingBlock:^(id obj, __unused BOOL *stop) {\
        id mapped = block(obj);\
        if (mapped) {\
            objects[i++] = mapped;\
        }\
    }];\
    const NSUInteger count = i;\
    __retType *result = __initializer;\
    while (i > 0) {\
        objects[--i] = nil;\
    }\
    free(objects);\
    return result;

- (NSSet *)tbc_setByApplyingMap:(TBCCoreMapObjectToObjectBlock)block {
    X(NSSet, [NSSet setWithObjects:objects count:count]);
}
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block {
    X(NSMutableSet, [NSMutableSet setWithObjects:objects count:count]);
}
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block {
    X(NSCountedSet, [NSCountedSet setWithObjects:objects count:count]);
}
- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapObjectToObjectBlock)block {
    X(NSArray, [NSArray arrayWithObjects:objects count:count]);
}
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreMapObjectToObjectBlock)block {
    X(NSMutableArray, [NSMutableArray arrayWithObjects:objects count:count]);
}

#undef X

- (NSSet *)tbc_filter:(TBCObjectPredicateBlock)predicateBlock {return [self tbc_setByFilteringWithPredicateBlock:predicateBlock];}

#define X(__retType, __initializer)\
    NSParameterAssert(predicateBlock);\
    __block NSUInteger i = 0;\
    id __unsafe_unretained *objects = (id __unsafe_unretained *)calloc(self.count, sizeof(id));\
    [self enumerateObjectsUsingBlock:^(id obj, __unused BOOL *stop) {\
        if (predicateBlock(obj)) {\
            objects[i++] = obj;\
        }\
    }];\
    const NSUInteger count = i;\
    __retType *result = __initializer;\
    free(objects);\
    return result;\

- (NSSet *)tbc_setByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock {
    X(NSSet, [NSSet setWithObjects:objects count:count]);
}
- (NSMutableSet *)tbc_mutableSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock {
    X(NSMutableSet, [NSMutableSet setWithObjects:objects count:count]);
}
- (NSCountedSet *)tbc_countedSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock {
    X(NSCountedSet, [NSCountedSet setWithObjects:objects count:count])
}
- (NSArray *)tbc_arrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock {
    X(NSArray, [NSArray arrayWithObjects:objects count:count]);
}
- (NSMutableArray *)tbc_mutableArrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock {
    X(NSMutableArray, [NSMutableArray arrayWithObjects:objects count:count]);
}

- (id)tbc_anyElementMatching:(TBCObjectPredicateBlock)predicateBlock concurrent:(BOOL)concurrent {
    __block id match = nil;
    __block int32_t concurrencyGuard = 0;
    NSEnumerationOptions options = concurrent ? NSEnumerationConcurrent : 0;
    [self enumerateObjectsWithOptions:options usingBlock:^(id obj, BOOL *stop) {
        if (predicateBlock(obj)) {
            *stop = YES;
            if (OSAtomicCompareAndSwap32(0, ~0, &concurrencyGuard)) {
                match = obj;
            }
        }
    }];
    return match;
}

- (id)tbc_anyElementMatching:(TBCObjectPredicateBlock)predicateBlock {
    return [self tbc_anyElementMatching:predicateBlock concurrent:NO];
}

@end
