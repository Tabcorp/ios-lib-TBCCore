//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "NSArray+TBCCore.h"

#import <objc/runtime.h>

@implementation NSArray(TBCCore)

+ (void)load {
    //This swizzling is purely to avoid trampolining through the tbc_map: implementation
    IMP mapImp = class_getMethodImplementation(self, @selector(tbc_arrayByApplyingMap:));
    class_replaceMethod(self, @selector(tbc_map:), mapImp, "@@:@");
}

- (NSArray *)tbc_map:(TBCCoreMapBlock)block {return [self tbc_arrayByApplyingMap:block];}

#define X(__retType, __initializer) \
    NSParameterAssert(block);\
    __block NSUInteger i = 0;\
    id __strong *objects = (id __strong *)calloc(self.count, sizeof(id));\
    [self enumerateObjectsUsingBlock:^(id obj, __unused NSUInteger idx, __unused BOOL *stop) {\
        id mapped = block(obj);\
        if (mapped) {\
            objects[i++] = mapped;\
        }\
    }];\
    const NSUInteger count = i;\
    __retType *result = __initializer;\
    while ( i > 0 ) {\
        objects[--i] = nil;\
    }\
    free(objects);\
    return result;


- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapBlock)block {
    X(NSArray, [NSArray arrayWithObjects:objects count:count]);
}

- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreMapBlock)block {
    X(NSMutableArray, [NSMutableArray arrayWithObjects:objects count:count]);
}

- (NSSet *)tbc_setByApplyingMap:(TBCCoreMapBlock)block {
    X(NSSet, [NSSet setWithObjects:objects count:count]);
}

- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreMapBlock)block {
    X(NSMutableSet, [NSMutableSet setWithObjects:objects count:count]);
}

- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreMapBlock)block {
    X(NSCountedSet, [NSCountedSet setWithObjects:objects count:count]);
}

#undef X

@end
