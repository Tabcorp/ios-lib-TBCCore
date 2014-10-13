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

#endif
