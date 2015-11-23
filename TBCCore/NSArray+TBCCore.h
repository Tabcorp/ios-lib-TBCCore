//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <TBCCore/TBCCoreTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSArray(TBCCore)

- (NSArray *)tbc_map:(TBCCoreMapObjectToObjectBlock)block;
- (NSArray *)tbc_mapWithIndex:(TBCCoreMapObjectAndIndexToObjectBlock)block;
- (NSArray *)tbc_flatMap:(TBCCoreMapObjectToArrayBlock)block;

- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSArray *)tbc_arrayByApplyingMapWithIndex:(TBCCoreMapObjectAndIndexToObjectBlock)block;
- (NSArray *)tbc_arrayByApplyingFlatMap:(TBCCoreMapObjectToArrayBlock)block;
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSMutableArray *)tbc_mutableArrayByApplyingFlatMap:(TBCCoreMapObjectToArrayBlock)block;
- (NSSet *)tbc_setByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSOrderedSet *)tbc_orderedSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSMutableOrderedSet *)tbc_mutableOrderedSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSMutableIndexSet *)tbc_mutableIndexSetByApplyingMap:(TBCCoreMapObjectToNSUIntegerBlock)block;

- (NSArray *)tbc_filter:(TBCObjectPredicateBlock)predicateBlock;

- (NSArray *)tbc_arrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSMutableArray *)tbc_mutableArrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSSet *)tbc_setByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSMutableSet *)tbc_mutableSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSOrderedSet *)tbc_orderedSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSMutableOrderedSet *)tbc_mutableOrderedSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSCountedSet *)tbc_countedSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;

- (id __nullable)tbc_firstElementMatching:(TBCObjectPredicateBlock)predicate;
- (NSUInteger)tbc_indexOfFirstElementMatching:(TBCObjectPredicateBlock)predicate;
- (id __nullable)tbc_anyElementMatching:(TBCObjectPredicateBlock)predicate;
- (NSUInteger)tbc_indexOfAnyElementMatching:(TBCObjectPredicateBlock)predicate;

- (NSArray *)tbc_arrayByRemovingDuplicatesWithEqualityBlock:(TBCObjectObjectPredicateBlock)equalityBlock;

@end

NS_ASSUME_NONNULL_END
