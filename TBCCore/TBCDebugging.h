//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


#if defined(DEBUG) && DEBUG != 0

@protocol TBCKVODebuggingSink <NSObject>
- (void)object:(NSObject *)object willChangeValueForKey:(NSString *)key;
- (void)object:(NSObject *)object didChangeValueForKey:(NSString *)key;
@end

@interface TBCKVODebuggingDefaultNSLogSink : NSObject<TBCKVODebuggingSink>
- (void)object:(NSObject *)object willChangeValueForKey:(NSString *)key;
- (void)object:(NSObject *)object didChangeValueForKey:(NSString *)key;
- (BOOL)shouldLogChangeForObject:(NSObject *)object key:(NSString *)key;
@end

@protocol TBCKVODebugger <NSObject>
@end

@interface TBCKVODebugging : NSObject
+ (id<TBCKVODebugger>)debuggerWithSink:(id<TBCKVODebuggingSink>)sink;
@end

/**
 Declares an expectation that the object will be deallocated shortly

 Call this method immediately prior to performing an operation that you expect should result in the deallocation
 of the passed object. Should the object not be deallocated after 100ms, an assertion will be fired.
 
 For example:
 
 TBCExpectDealloc(self);
 [self.navigationController popViewControllerAnimated:NO];

 @param object The object that you expect to be deallocated
 
 */
void _TBCExpectDealloc(id object, char *file, int line, dispatch_block_t expectationFailedBlock);
void _TBCExpectDeallocFailed(void);
#define TBCExpectDealloc(object) (_TBCExpectDealloc((object),__FILE__,__LINE__,^{_TBCExpectDeallocFailed();}))

#else

#define TBCExpectDealloc(object)

#endif
