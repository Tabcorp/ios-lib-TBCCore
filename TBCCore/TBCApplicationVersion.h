//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


typedef struct TBCApplicationVersion {
    NSUInteger major;
    NSUInteger minor;
    NSUInteger patch;
} TBCApplicationVersion;


static inline BOOL TBCApplicationVersionEqualToVersion(TBCApplicationVersion a, TBCApplicationVersion b) {
    if (a.major != b.major) {
        return NO;
    }
    if (a.minor != b.minor) {
        return NO;
    }
    if (a.patch != b.patch) {
        return NO;
    }
    return YES;
}

static inline BOOL TBCApplicationVersionIsNull(TBCApplicationVersion version) {
    return TBCApplicationVersionEqualToVersion(version, (TBCApplicationVersion){});
}


static inline BOOL TBCApplicationVersionIsAtLeast(TBCApplicationVersion version, TBCApplicationVersion minimumVersion) {
    if (version.major < minimumVersion.major) {
        return NO;
    }
    if (version.minor < minimumVersion.minor) {
        return NO;
    }
    if (version.patch < minimumVersion.patch) {
        return NO;
    }
    return YES;
}


extern NSString * __nonnull TBCApplicationVersionToString(TBCApplicationVersion version);
extern BOOL TBCApplicationVersionFromString(NSString * __nonnull string, TBCApplicationVersion * __nullable version);
