//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <dispatch/dispatch.h>

/**
 A NULL-safe version of `dispatch_retain` that also compiles to nothing under ARC + DeploymentTarget >= 6
 
 @param object the dispatch object to retain
 */
#if defined(__has_feature) && __has_feature(objc_arc) && OS_OBJECT_USE_OBJC_RETAIN_RELEASE
static inline void tbc_dispatch_retain(dispatch_object_t object) {}
#else
static inline void tbc_dispatch_retain(dispatch_object_t object) {
    struct dispatch_object_s *o = object._do;
    if (o != NULL) {
        dispatch_retain(object);
    }
}
#endif

/**
 A NULL-safe version of `dispatch_release` that also compiles to nothing under ARC + DeploymentTarget >= 6
 
 @param object the dispatch object to release
 */
#if defined(__has_feature) && __has_feature(objc_arc) && OS_OBJECT_USE_OBJC_RETAIN_RELEASE
static inline void tbc_dispatch_release(dispatch_object_t object) {}
#else
static inline void tbc_dispatch_release(dispatch_object_t object) {
    struct dispatch_object_s *o = object._do;
    if (o != NULL) {
        dispatch_release(object);
    }
}
#endif

static inline uint64_t tbc_dispatch_time_interval(NSTimeInterval timeInterval) {
    if (!isfinite(timeInterval) || timeInterval < 0 || timeInterval >= (DBL_MAX / NSEC_PER_SEC)) {
        return DISPATCH_TIME_FOREVER;
    } else {
        return timeInterval * NSEC_PER_SEC;
    }
}