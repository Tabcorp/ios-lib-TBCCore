//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <TBCCore/TBCApplicationVersion.h>


NSString * __nonnull TBCApplicationVersionToString(TBCApplicationVersion version) {
    return [NSString stringWithFormat:@"%lu.%lu.%lu", (unsigned long)version.major, (unsigned long)version.minor, (unsigned long)version.patch];
}


static NSRegularExpression *gTBCApplicationVersionRegularExpression = nil;

__attribute__((constructor))
static void TBCApplicationVersionInit(void) {
    // allow trailing non-numbers
    gTBCApplicationVersionRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"^(\\d+)(?:\\.(\\d+)(?:\\.(\\d+))?)?" options:0 error:NULL];
}


BOOL TBCApplicationVersionFromString(NSString * __nonnull string, TBCApplicationVersion * __nullable version) {
    if (!string.length) {
        return NO;
    }

    NSTextCheckingResult * const result = [gTBCApplicationVersionRegularExpression matchesInString:string options:0 range:(NSRange){ .length = string.length }].firstObject;
    if (!result) {
        return NO;
    }

    if (version) {
        version->major = version->minor = version->patch = 0;
    }

    {
        NSRange const range = [result rangeAtIndex:1];
        if (range.length > 0) {
            NSString * const text = [string substringWithRange:range];
            if (version) {
                version->major = text.integerValue;
            }
        }
    }

    {
        NSRange const range = [result rangeAtIndex:2];
        if (range.length > 0) {
            NSString * const text = [string substringWithRange:range];
            if (version) {
                version->minor = text.integerValue;
            }
        }
    }

    {
        NSRange const range = [result rangeAtIndex:3];
        if (range.length > 0) {
            NSString * const text = [string substringWithRange:range];
            if (version) {
                version->patch = text.integerValue;
            }
        }
    }

    return YES;
}
