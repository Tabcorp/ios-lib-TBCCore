//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TBCNotificationCenterObservationBlock)(NSNotification * const notification);

@interface TBCNotificationCenterObservation : NSObject

+ (instancetype)observationWithNotificationName:(NSString *)name object:(NSObject * __nullable)object block:(TBCNotificationCenterObservationBlock)block;
+ (instancetype)observationWithNotificationName:(NSString *)name block:(TBCNotificationCenterObservationBlock)block;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNotificationName:(NSString *)name object:(NSObject * __nullable)object block:(TBCNotificationCenterObservationBlock)block __attribute((objc_designated_initializer));
- (instancetype)initWithNotificationName:(NSString *)name block:(TBCNotificationCenterObservationBlock)block;

- (void)removeObservation;

@end

NS_ASSUME_NONNULL_END
