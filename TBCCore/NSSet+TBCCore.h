//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <TBCCore/TBCCoreTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSSet<__covariant ObjectType> (TBCCore)

- (NSSet *)tbc_map:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;

- (NSSet *)tbc_setByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;

- (NSSet<ObjectType> *)tbc_filter:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;

- (NSSet<ObjectType> *)tbc_setByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSMutableSet<ObjectType> *)tbc_mutableSetByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSCountedSet<ObjectType> *)tbc_countedSetByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSArray<ObjectType> *)tbc_arrayByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSMutableArray<ObjectType> *)tbc_mutableArrayByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;

- (ObjectType __nullable)tbc_anyElementMatching:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock concurrent:(BOOL)concurrent;
- (ObjectType __nullable)tbc_anyElementMatching:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;

@end

NS_ASSUME_NONNULL_END
