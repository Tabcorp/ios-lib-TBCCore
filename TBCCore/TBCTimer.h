//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <dispatch/dispatch.h>

extern NSTimeInterval const TBCTimerIntervalForever;

/**
 A block-based timer that doesn't encourage creating a retain cycle (like NSTimer)
 
 You must keep a strong reference to this object for as long as you'd like the timer to fire.
 */
@interface TBCTimer : NSObject

/**
 Initializes a timer to fire the given block on the given queue at an initial fire time, and repeated at an interval
 
 @param fireDate The date to call the block the first time
 @param interval The time interval between repeated calls. Specify TBCTimerIntervalForever to disable repeated calls.
 @param leeway The time interval that the system can defer the timer (for improved system performance and power consumption)
 @param block The block to call
 @param queue The queue on which to call the block. Specifying nil will use the main queue.
 */
- (id)initWithFireDate:(NSDate *)fireDate interval:(NSTimeInterval)interval leeway:(NSTimeInterval)leeway queue:(dispatch_queue_t)queue block:(dispatch_block_t)block __attribute((objc_designated_initializer));

/**
 Initializes a timer to fire the given block on the main queue at the given time
 
 @param fireDate The date to call the block
 @param leeway The time interval that the system can defer the timer (for improved system performance and power consumption)
 @param block The block to call
 */
- (id)initWithFireDate:(NSDate *)fireDate leeway:(NSTimeInterval)leeway block:(dispatch_block_t)block;

/**
 Initializes a timer to fire the given block on the given queue at the given time
 
 @param fireDate The date to call the block
 @param leeway The time interval that the system can defer the timer (for improved system performance and power consumption)
 @param block The block to call
 @param queue The queue on which to call the block. Specifying nil will use the main queue.
 */
- (id)initWithFireDate:(NSDate *)fireDate leeway:(NSTimeInterval)leeway queue:(dispatch_queue_t)queue block:(dispatch_block_t)block;

/**
 Initializes a timer to fire the given block on the main queue at an initial fire time, and repeated at an interval
 
 @param fireDate The date to call the block the first time
 @param interval The time interval between repeated calls. Specify TBCTimerIntervalForever to disable repeated calls.
 @param leeway The time interval that the system can defer the timer (for improved system performance and power consumption)
 @param block The block to call
 */
- (id)initWithFireDate:(NSDate *)fireDate interval:(NSTimeInterval)interval leeway:(NSTimeInterval)leeway block:(dispatch_block_t)block;

/**
 Invalidates the timer, such that the block will no longer be called
 */
- (void)invalidate;

@end
