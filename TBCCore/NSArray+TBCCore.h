//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

typedef id (^TBCCoreMapBlock)(id object);

@interface NSArray(TBCCore)

- (NSArray *)tbc_map:(TBCCoreMapBlock)block;

- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapBlock)block;
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreMapBlock)block;
- (NSSet *)tbc_setByApplyingMap:(TBCCoreMapBlock)block;
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreMapBlock)block;
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreMapBlock)block;

@end
