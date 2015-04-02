//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import "NSString+TBCCore.h"

#import <objc/runtime.h>


typedef BOOL (*TBCNSString_containsString__f)(id self, SEL _cmd, NSString *string);
static BOOL TBCNSString_containsString_(NSString * const self, SEL _cmd, NSString *string) {
    NSRange const range = [self rangeOfString:string];
    return range.location != NSNotFound;
}


__attribute__((constructor))
static void TBCHackeryInit(void) {
    Class const NSStringClass = NSString.class;

    {
        char NSString_containsString__types[4] = "c@:@";
        NSString_containsString__types[0] = @encode(BOOL)[0];
        Method const NSString_containsString__m = class_getInstanceMethod(NSStringClass, @selector(containsString:));
        if (!NSString_containsString__m) {
            class_addMethod(NSStringClass, @selector(containsString:), (IMP)TBCNSString_containsString_, NSString_containsString__types);
        }
    }
}


// this @implementation is required for the linker to leave TBCHackeryInit alone
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation NSString (TBCCore)
@end
#pragma clang diagnostic pop
