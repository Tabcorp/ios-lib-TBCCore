//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <TBCCore/TBCCoreTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSMapTable (TBCCore)

- (void)tbc_setObjectsFromArray:(NSArray *)array forKeysGeneratedByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;

@end

NS_ASSUME_NONNULL_END
