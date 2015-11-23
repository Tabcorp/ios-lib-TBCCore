//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


static inline BOOL TBCObjectsAreDifferent(id<NSObject> __nullable a, id<NSObject> __nullable b) {
    if (a == b) {
        return NO;
    }
    if (a == NULL || b == NULL) {
        return YES;
    }
    return ![a isEqual:b];
}
