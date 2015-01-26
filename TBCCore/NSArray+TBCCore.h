//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import "TBCPredicateBlock.h"

typedef id (^TBCCoreMapBlock)(id object);

@interface NSArray(TBCCore)

- (NSArray *)tbc_map:(TBCCoreMapBlock)block;

- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapBlock)block;
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreMapBlock)block;
- (NSSet *)tbc_setByApplyingMap:(TBCCoreMapBlock)block;
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreMapBlock)block;
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreMapBlock)block;

- (NSArray *)tbc_filter:(TBCObjectPredicateBlock)predicateBlock;

- (NSArray *)tbc_arrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSMutableArray *)tbc_mutableArrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSSet *)tbc_setByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSMutableSet *)tbc_mutableSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSCountedSet *)tbc_countedSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;

@end
