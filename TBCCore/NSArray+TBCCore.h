//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import "TBCCoreTypes.h"


@interface NSArray(TBCCore)

- (NSArray *)tbc_map:(TBCCoreMapObjectToObjectBlock)block;
- (NSArray *)tbc_mapWithIndex:(TBCCoreMapObjectAndIndexToObjectBlock)block;

- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSArray *)tbc_arrayByApplyingMapWithIndex:(TBCCoreMapObjectAndIndexToObjectBlock)block;
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSSet *)tbc_setByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSMutableIndexSet *)tbc_mutableIndexSetByApplyingMap:(TBCCoreMapObjectToNSUIntegerBlock)block;

- (NSArray *)tbc_filter:(TBCObjectPredicateBlock)predicateBlock;

- (NSArray *)tbc_arrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSMutableArray *)tbc_mutableArrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSSet *)tbc_setByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSMutableSet *)tbc_mutableSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSCountedSet *)tbc_countedSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;

- (id)tbc_firstElementMatching:(TBCObjectPredicateBlock)predicate;
- (NSUInteger)tbc_indexOfFirstElementMatching:(TBCObjectPredicateBlock)predicate;
- (id)tbc_anyElementMatching:(TBCObjectPredicateBlock)predicate;
- (NSUInteger)tbc_indexOfAnyElementMatching:(TBCObjectPredicateBlock)predicate;

@end
