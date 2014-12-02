//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

typedef id (^TBCCoreMapBlock)(id object);

@interface NSArray(TBCCore)

- (NSArray *)tbc_map:(TBCCoreMapBlock)block;

- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreMapBlock)block;

@end
