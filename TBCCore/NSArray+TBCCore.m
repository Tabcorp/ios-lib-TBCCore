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

- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapBlock)block {
    NSParameterAssert(block);
    
    const NSUInteger count = self.count;
    __block NSUInteger i = 0;
    id __strong *temp = (id __strong *)calloc(count, sizeof(id));
    
    [self enumerateObjectsUsingBlock:^(id obj, __unused NSUInteger idx, __unused BOOL *stop) {
        id mapped = block(obj);
        if (mapped) {
            temp[i++] = mapped;
        }
    }];
    
    NSArray *result = [NSArray arrayWithObjects:temp count:i];
    while ( i > 0 ) {
        temp[--i] = nil;
    }
    free(temp);
    return result;
}

@end
