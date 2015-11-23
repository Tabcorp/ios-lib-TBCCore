//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <TBCCore/TBCCoreTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSSet(TBCCore)

- (NSSet *)tbc_map:(TBCCoreMapObjectToObjectBlock)block;

- (NSSet *)tbc_setByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;

- (NSSet *)tbc_filter:(TBCObjectPredicateBlock)predicateBlock;

- (NSSet *)tbc_setByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSMutableSet *)tbc_mutableSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSCountedSet *)tbc_countedSetByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSArray *)tbc_arrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;
- (NSMutableArray *)tbc_mutableArrayByFilteringWithPredicateBlock:(TBCObjectPredicateBlock)predicateBlock;

- (id __nullable)tbc_anyElementMatching:(TBCObjectPredicateBlock)predicateBlock concurrent:(BOOL)concurrent;
- (id __nullable)tbc_anyElementMatching:(TBCObjectPredicateBlock)predicateBlock;

@end

NS_ASSUME_NONNULL_END
