//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


static inline BOOL TBCObjectsAreDifferent(id<NSObject> a, id<NSObject> b) {
    if (a == b) {
        return NO;
    }
    if (a == NULL || b == NULL) {
        return YES;
    }
    return ![a isEqual:b];
}
