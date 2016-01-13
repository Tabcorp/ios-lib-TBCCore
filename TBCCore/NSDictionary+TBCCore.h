//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <TBCCore/TBCCoreTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (TBCCore)

- (NSDictionary *)tbc_map:(TBCCoreGenericMapKeyAndObjectToObjectBlock(KeyType, ObjectType, id))block;

- (NSDictionary *)tbc_dictionaryByApplyingMap:(TBCCoreGenericMapKeyAndObjectToObjectBlock(KeyType, ObjectType, id))block;
- (NSMutableDictionary *)tbc_mutableDictionaryByApplyingMap:(TBCCoreGenericMapKeyAndObjectToObjectBlock(KeyType, ObjectType, id))block;
- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreGenericMapKeyAndObjectToObjectBlock(KeyType, ObjectType, id))block;
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreGenericMapKeyAndObjectToObjectBlock(KeyType, ObjectType, id))block;
- (NSSet *)tbc_setByApplyingMap:(TBCCoreGenericMapKeyAndObjectToObjectBlock(KeyType, ObjectType, id))block;
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreGenericMapKeyAndObjectToObjectBlock(KeyType, ObjectType, id))block;
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreGenericMapKeyAndObjectToObjectBlock(KeyType, ObjectType, id))block;

@end

NS_ASSUME_NONNULL_END
