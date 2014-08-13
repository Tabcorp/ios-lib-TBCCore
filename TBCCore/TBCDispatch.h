//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

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
