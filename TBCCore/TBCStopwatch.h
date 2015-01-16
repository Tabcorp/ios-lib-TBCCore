//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

typedef void (^TBCStopwatchBlock)(NSTimeInterval interval);

@interface TBCStopwatch : NSObject

@property (nonatomic,assign) BOOL firesOnDealloc;

- (instancetype)initWithBlock:(TBCStopwatchBlock)block;
- (instancetype)initWithQueue:(dispatch_queue_t)queue block:(TBCStopwatchBlock)block __attribute__((objc_designated_initializer));

- (void)start;
- (void)pause;
- (void)resume;
- (void)stop;

- (void)cancel;

@end
