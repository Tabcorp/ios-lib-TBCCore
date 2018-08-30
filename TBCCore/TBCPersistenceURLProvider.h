//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


/**
 `TBCPersistenceURLProvider` provides simple access to namespaced local URLs for persistence
 */
@protocol TBCPersistenceURLProvider <NSObject>

/**
 Creates a URL provider relative to this one with extra namespacing path compoents

 @param pathComponent a path component for namespacing
 */
- (id<TBCPersistenceURLProvider>)subproviderWithPathComponent:(NSString *)pathComponent;

/**
 Creates a URL provider relative to this one with extra namespacing path compoents

 @param pathComponents a list of path components for namespacing
 */
- (id<TBCPersistenceURLProvider>)subproviderWithPathComponents:(NSArray *)pathComponents;

/**
 Provides a namespaced URL within the app group, falling back to documentsURL if no app group is specified
 */
@property (nonatomic,copy,readonly) NSURL *applicationGroupURL;

/**
 Provides a namespaced URL under `NSCachesDirectory`
 */
@property (nonatomic,copy,readonly) NSURL *cachesURL;

/**
 Provides a namespaced URL under `NSDocumentDirectory`
 */
@property (nonatomic,copy,readonly) NSURL *documentsURL;

@end


/**
 `TBCPersistenceURLProvider` provides simple access to namespaced local URLs for persistence

 Path components given here are passed to -[NSURL URLByAppendingPathComponent:]
 */
@interface TBCPersistenceURLProvider : NSObject<TBCPersistenceURLProvider>

/**
 Initializes a URL provider with optional namespacing path compoents

 @param pathComponent a path component for namespacing
 */
- (instancetype)initWithPathComponent:(NSString *)pathComponent;

/**
 Initializes a URL provider with optional namespacing path compoents

 @param pathComponents an array of path components for namespacing
 */
- (instancetype)initWithPathComponents:(NSArray *)pathComponents;

/**
 Initializes a URL provider with app group identifier and optional namespacing path component

 @param appGroupIdentifier an app group identifier
 @param pathComponent a path component for namespacing
 */
- (instancetype)initWithAppGroupIdentifier:(NSString *)appGroupIdentifier pathComponent:(NSString *)pathComponent;

@end
