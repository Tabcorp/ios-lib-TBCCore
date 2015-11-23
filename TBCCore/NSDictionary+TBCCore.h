//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <TBCCore/TBCCoreTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary(TBCCore)

- (NSDictionary *)tbc_map:(TBCCoreMapKeyAndObjectToObjectBlock)block;

- (NSDictionary *)tbc_dictionaryByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block;
- (NSMutableDictionary *)tbc_mutableDictionaryByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block;
- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block;
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block;
- (NSSet *)tbc_setByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block;
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block;
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreMapKeyAndObjectToObjectBlock)block;

@end

NS_ASSUME_NONNULL_END
