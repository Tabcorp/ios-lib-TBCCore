//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

@protocol TBCCancellable <NSObject>
@property (nonatomic,assign,getter=shouldCancelOnDeallocation) BOOL cancelOnDeallocation;
@property (nonatomic,assign,getter=isCancelled) BOOL cancelled;
- (void)cancel;
@end

@interface TBCCancellableAggregator : NSObject<TBCCancellable>
- (void)addCancellable:(id<TBCCancellable>)cancellable;
- (void)removeCancellable:(id<TBCCancellable>)cancellable;
@end