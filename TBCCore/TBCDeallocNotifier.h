//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


typedef void(^TBCDeallocNotificationBlock)(void);
@protocol TBCDeallocNotifier <NSObject>
- (void)invalidate;
@end

NS_RETURNS_RETAINED
extern id<TBCDeallocNotifier> __nonnull TBCAttachDeallocNotifier(NSObject * __nonnull object, TBCDeallocNotificationBlock __nonnull block);
