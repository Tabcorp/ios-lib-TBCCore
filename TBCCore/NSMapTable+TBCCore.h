//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <TBCCore/TBCCoreTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSMapTable<KeyType, ObjectType> (TBCCore)

- (void)tbc_setObjectsFromArray:(NSArray *)array forKeysGeneratedByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(id, KeyType))block;

@end

NS_ASSUME_NONNULL_END
