//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import "TBCCoreTypes.h"


@interface NSMapTable (TBCCore)

- (void)tbc_setObjectsFromArray:(NSArray *)array forKeysGeneratedByApplyingMap:(TBCCoreMapObjectToObjectBlock)block;

@end