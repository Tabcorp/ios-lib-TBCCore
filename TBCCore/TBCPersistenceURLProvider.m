//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCPersistenceURLProvider.h"


@interface TBCPersistenceURLRootProvider : NSObject<TBCPersistenceURLProvider>
- (instancetype)initWithAppGroupIdentifier:(NSString *)appGroupIdentifier;
@end

@interface TBCPersistenceURLSubprovider : NSObject<TBCPersistenceURLProvider>
- (instancetype)initWithProvider:(id<TBCPersistenceURLProvider>)provider pathComponents:(NSArray *)pathComponents;
@end


@implementation TBCPersistenceURLProvider

- (instancetype)init {
    return [self initWithPathComponent:nil];
}
- (instancetype)initWithPathComponent:(NSString *)pathComponent {
    id<TBCPersistenceURLProvider> const provider = [[TBCPersistenceURLRootProvider alloc] init];
    if (pathComponent) {
        return [provider subproviderWithPathComponent:pathComponent];
    }
    return provider;
}
- (instancetype)initWithPathComponents:(NSArray *)pathComponents {
    id<TBCPersistenceURLProvider> const provider = [[TBCPersistenceURLRootProvider alloc] init];
    if (pathComponents) {
        return [provider subproviderWithPathComponents:pathComponents];
    }
    return provider;

}

- (instancetype)initWithAppGroupIdentifier:(NSString *)appGroupIdentifier pathComponent:(NSString *)pathComponent {
    id<TBCPersistenceURLProvider> const provider = [[TBCPersistenceURLRootProvider alloc] initWithAppGroupIdentifier:appGroupIdentifier];
    if (pathComponent) {
        return [provider subproviderWithPathComponent:pathComponent];
    }
    return provider;
}

- (NSURL *)applicationGroupURL {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSURL *)cachesURL {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSURL *)documentsURL {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id<TBCPersistenceURLProvider>)subproviderWithPathComponent:(NSString *)pathComponent {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id<TBCPersistenceURLProvider>)subproviderWithPathComponents:(NSArray *)pathComponents {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end


@implementation TBCPersistenceURLRootProvider {
@private
    NSFileManager *_fm;
    NSURL *_applicationGroupURL;
    NSURL *_cachesURL;
    NSURL *_documentsURL;
}

- (instancetype)initWithAppGroupIdentifier:(NSString *)appGroupIdentifier {
    if ((self = [super init])) {
        _fm = [[NSFileManager alloc] init];
        if (appGroupIdentifier) {
            _applicationGroupURL = [_fm containerURLForSecurityApplicationGroupIdentifier:appGroupIdentifier];
        }
    }
    return self;
}

- (instancetype)init {
    return [self initWithAppGroupIdentifier:nil];
}

- (NSURL *)applicationGroupURL {
    return _applicationGroupURL ?: [self documentsURL];
}

- (NSURL *)cachesURL {
    if (!_cachesURL) {
        NSURL * const url = [_fm URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:NULL];
        _cachesURL = url.copy;
    }
    return _cachesURL;
}

- (NSURL *)documentsURL {
    if (!_documentsURL) {
        NSURL * const url = [_fm URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:NULL];
        _documentsURL = url;
    }
    return _documentsURL;
}

- (id<TBCPersistenceURLProvider>)subproviderWithPathComponent:(NSString *)pathComponent {
    NSParameterAssert(pathComponent);
    if (!pathComponent) {
        return nil;
    }
    return [[TBCPersistenceURLSubprovider alloc] initWithProvider:self pathComponents:@[ pathComponent ]];
}

- (id<TBCPersistenceURLProvider>)subproviderWithPathComponents:(NSArray *)pathComponents {
    NSParameterAssert(pathComponents);
    if (!pathComponents) {
        return nil;
    }
    return [[TBCPersistenceURLSubprovider alloc] initWithProvider:self pathComponents:pathComponents];
}

@end


@implementation TBCPersistenceURLSubprovider {
@private
    id<TBCPersistenceURLProvider> _provider;
    NSArray *_pathComponents;
    NSURL *_applicationGroupURL;
    NSURL *_cachesURL;
    NSURL *_documentsURL;
}

- (instancetype)init {
    return [self initWithProvider:nil pathComponents:nil];
}

- (instancetype)initWithProvider:(id<TBCPersistenceURLProvider>)provider pathComponents:(NSArray *)pathComponents {
    NSParameterAssert(provider);
    if (!provider) {
        return nil;
    }
    NSParameterAssert(pathComponents);
    if (!pathComponents) {
        return nil;
    }
    if ((self = [super init])) {
        _provider = provider;
        _pathComponents = [[NSArray alloc] initWithArray:pathComponents copyItems:YES];
    }
    return self;
}

- (NSURL *)applicationGroupURL {
    if (!_applicationGroupURL) {
        NSURL *applicationGroupURL = _provider.applicationGroupURL;
        for (NSString *pathComponent in _pathComponents) {
            applicationGroupURL = [applicationGroupURL URLByAppendingPathComponent:pathComponent isDirectory:YES];
        }
        _applicationGroupURL = applicationGroupURL;
    }
    return _applicationGroupURL;
}

- (NSURL *)cachesURL {
    if (!_cachesURL) {
        NSURL *cachesURL = _provider.cachesURL;
        for (NSString *pathComponent in _pathComponents) {
            cachesURL = [cachesURL URLByAppendingPathComponent:pathComponent isDirectory:YES];
        }
        _cachesURL = cachesURL;
    }
    return _cachesURL;
}

- (NSURL *)documentsURL {
    if (!_documentsURL) {
        NSURL *documentsURL = _provider.documentsURL;
        for (NSString *pathComponent in _pathComponents) {
            documentsURL = [documentsURL URLByAppendingPathComponent:pathComponent isDirectory:YES];
        }
        _documentsURL = documentsURL;
    }
    return _documentsURL;
}

- (id<TBCPersistenceURLProvider>)subproviderWithPathComponent:(NSString *)pathComponent {
    NSParameterAssert(pathComponent);
    if (!pathComponent) {
        return nil;
    }
    return [[TBCPersistenceURLSubprovider alloc] initWithProvider:self pathComponents:@[ pathComponent ]];
}

- (id<TBCPersistenceURLProvider>)subproviderWithPathComponents:(NSArray *)pathComponents {
    NSParameterAssert(pathComponents);
    if (!pathComponents) {
        return nil;
    }
    return [[TBCPersistenceURLSubprovider alloc] initWithProvider:self pathComponents:pathComponents];
}

@end
