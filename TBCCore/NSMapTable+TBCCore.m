//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import "NSMapTable+TBCCore.h"


@implementation NSMapTable (TBCCore)

- (void)tbc_setObjectsFromArray:(NSArray *)array forKeysGeneratedByApplyingMap:(TBCCoreMapObjectToObjectBlock)block {
    NSParameterAssert(block);
    [self removeAllObjects];

    __block NSUInteger i = 0;
    id __strong *keys = (id __strong *)calloc(array.count, sizeof(id));
    id __strong *objects = (id __strong *)calloc(array.count, sizeof(id));
    [array enumerateObjectsUsingBlock:^(id obj, __unused NSUInteger idx, __unused BOOL *stop) {
        id const key = block(obj);
        if (key && obj) {
            keys[i] = key;
            objects[i] = obj;
            ++i;
        }
    }];

    NSUInteger const count = i;
    for (i = 0; i < count; ++i) {
        id const key = keys[i];
        id const obj = objects[i];
        [self setObject:obj forKey:key];
    }
    for (i = 0; i < count; ++i) {
        keys[i] = nil;
        objects[i] = nil;
    }
    free(keys);
    free(objects);
}

@end
