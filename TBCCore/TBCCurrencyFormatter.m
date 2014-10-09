//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import "TBCCurrencyFormatter.h"

@implementation TBCCurrencyFormatter

+ (NSNumberFormatter *)formatterForAustralianCurrency {
    NSNumberFormatter* currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    currencyFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_AU"];
    return currencyFormatter;
}

+ (NSNumberFormatter *)formatterForAustralianCurrencyWholeDollars {
    NSNumberFormatter* currencyFormatter = [self formatterForAustralianCurrency];
    currencyFormatter.maximumFractionDigits = 0;
    return currencyFormatter;
}

@end
