//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <dispatch/dispatch.h>


extern NSTimeInterval const TBCDelayedDispatcherDelayForever;


/**
 A resettable timer with optional minimum and maximum delay periods

 The minimum delay period can be used to coalesce repeated armings into a single block execution.
 The maximum delay period can be used to set an upper bound on the length of time that may pass between the first arming and block execution.
 */
@interface TBCDelayedDispatcher : NSObject

/**
 Initializes a `TBCDelayedDispatcher` on the main queue

 @param delay The minimum delay
 @param maximumDelay The maximum delay
 @param block The block to execute on timer firing
 */
- (instancetype)initWithDelay:(NSTimeInterval)delay maximumDelay:(NSTimeInterval)maximumDelay block:(dispatch_block_t)block;

/**
 Initializes a `TBCDelayedDispatcher` on a specific queue

 @param delay The minimum delay
 @param maximumDelay The maximum delay
 @param queue The dispatch queue to schedule timers on and dispatch `block` to
 @param block The block to execute on timer firing
 */
- (instancetype)initWithDelay:(NSTimeInterval)delay maximumDelay:(NSTimeInterval)maximumDelay queue:(dispatch_queue_t)queue block:(dispatch_block_t)block;

- (void)arm;
- (void)disarm;

- (void)fireIfArmed;

@end
