//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

@interface TBCCurrencyFormatter : NSObject

+ (NSNumberFormatter *)formatterForAustralianCurrency;
+ (NSNumberFormatter *)formatterForAustralianCurrencyWholeDollars;

@end
