//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCCore.h>


@interface TBCMonetaryValueTests : XCTestCase
@end

@implementation TBCMonetaryValueTests

- (void)testSimpleCreation {
    TBCMonetaryValue * const v1 = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.one];
    XCTAssertNil(v1.currencyCode);
    XCTAssertEqualObjects(v1.amount, NSDecimalNumber.one);

    TBCMonetaryValue * const v2 = [TBCMonetaryValue monetaryValueWithCurrencyCode:nil amount:NSDecimalNumber.one];
    XCTAssertNil(v2.currencyCode);
    XCTAssertEqualObjects(v2.amount, NSDecimalNumber.one);

    TBCMonetaryValue * const v3 = [[TBCMonetaryValue alloc] initWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.one];
    XCTAssertNil(v3.currencyCode);
    XCTAssertEqualObjects(v3.amount, NSDecimalNumber.one);

    TBCMonetaryValue * const v4 = [[TBCMonetaryValue alloc] initWithCurrencyCode:nil amount:NSDecimalNumber.one];
    XCTAssertNil(v4.currencyCode);
    XCTAssertEqualObjects(v4.amount, NSDecimalNumber.one);

    XCTAssertEqualObjects(v1, v2);
    XCTAssertEqualObjects(v2, v3);
    XCTAssertEqualObjects(v3, v4);

    TBCMonetaryValue * const v5 = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"AUD" amount:NSDecimalNumber.zero];
    XCTAssertEqualObjects(v5.currencyCode, @"AUD");

    TBCMonetaryValue * const v6 = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"AUD" amount:NSDecimalNumber.one];
    XCTAssertEqualObjects(v6.currencyCode, @"AUD");

    TBCMonetaryValue * const v7 = [[TBCMonetaryValue alloc] initWithCurrencyCode:@"AUD" amount:NSDecimalNumber.one];
    XCTAssertEqualObjects(v7.currencyCode, @"AUD");

    XCTAssertEqualObjects(v5.currencyCode, v6.currencyCode);
    XCTAssertNotEqualObjects(v5, v6);
    XCTAssertNotEqualObjects(v5.amount, v6.amount);

    XCTAssertEqualObjects(v6, v7);
}

- (void)testAddition {
    NSDecimalNumber * const two = [NSDecimalNumber decimalNumberWithString:@"2"];

    TBCMonetaryValue * const unspecifiedZero = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.zero];
    TBCMonetaryValue * const unspecifiedOne = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.one];
    TBCMonetaryValue * const unspecifiedTwo = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:two];

    TBCMonetaryValue * const audOne = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"AUD" amount:NSDecimalNumber.one];
    TBCMonetaryValue * const audOnePointFive = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"AUD" amount:[NSDecimalNumber decimalNumberWithString:@"1.5" locale:nil]];

    TBCMonetaryValue * const usdOne = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"USD" amount:NSDecimalNumber.one];

    {
        TBCMonetaryValue * const r = [unspecifiedZero monetaryValueByAdding:unspecifiedZero];
        XCTAssertEqualObjects(r, unspecifiedZero);
    }
    {
        TBCMonetaryValue * const r = [unspecifiedZero monetaryValueByAdding:unspecifiedOne];
        XCTAssertEqualObjects(r, unspecifiedOne);
    }
    {
        TBCMonetaryValue * const r = [unspecifiedOne monetaryValueByAdding:unspecifiedOne];
        XCTAssertNil(r.currencyCode);
        XCTAssertEqualObjects(r.amount, two);
        XCTAssertEqualObjects(unspecifiedTwo, r);
    }
    {
        TBCMonetaryValue * const r = [unspecifiedZero monetaryValueByAdding:audOne];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, NSDecimalNumber.one);
        XCTAssertEqualObjects(r, audOne);
    }
    {
        TBCMonetaryValue * const r = [[unspecifiedZero monetaryValueByAdding:audOne] monetaryValueByAdding:unspecifiedOne];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, two);
    }
    {
        TBCMonetaryValue * const r = [[unspecifiedZero monetaryValueByAdding:audOne] monetaryValueByAdding:audOne];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, two);
    }
    {
        XCTAssertThrows([audOne monetaryValueByAdding:usdOne]);
    }
    {
        NSDecimalNumberHandler * const behavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        TBCMonetaryValue * const r = [unspecifiedZero monetaryValueByAdding:audOnePointFive withBehavior:behavior];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, NSDecimalNumber.one);
        XCTAssertEqualObjects(r, audOne);
    }
}

- (void)testSubtraction {
    NSDecimalNumber * const two = [NSDecimalNumber decimalNumberWithString:@"2"];

    TBCMonetaryValue * const unspecifiedZero = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.zero];
    TBCMonetaryValue * const unspecifiedOne = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.one];
    TBCMonetaryValue * const unspecifiedTwo = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:two];

    TBCMonetaryValue * const audOne = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"AUD" amount:NSDecimalNumber.one];
    TBCMonetaryValue * const usdOne = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"USD" amount:NSDecimalNumber.one];

    {
        TBCMonetaryValue * const r = [unspecifiedOne monetaryValueBySubtracting:unspecifiedZero];
        XCTAssertEqualObjects(r, unspecifiedOne);
    }
    {
        TBCMonetaryValue * const r = [unspecifiedOne monetaryValueBySubtracting:unspecifiedOne];
        XCTAssertEqualObjects(r, unspecifiedZero);
    }
    {
        TBCMonetaryValue * const r = [unspecifiedTwo monetaryValueBySubtracting:unspecifiedOne];
        XCTAssertEqualObjects(r, unspecifiedOne);
    }
    {
        TBCMonetaryValue * const r = [[unspecifiedTwo monetaryValueBySubtracting:unspecifiedOne] monetaryValueBySubtracting:unspecifiedOne];
        XCTAssertEqualObjects(r, unspecifiedZero);
    }
    {
        TBCMonetaryValue * const r = [unspecifiedOne monetaryValueBySubtracting:audOne];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, NSDecimalNumber.zero);
    }
    {
        TBCMonetaryValue * const r = [[unspecifiedTwo monetaryValueBySubtracting:audOne] monetaryValueBySubtracting:unspecifiedOne];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, NSDecimalNumber.zero);
    }
    {
        TBCMonetaryValue * const r = [unspecifiedTwo monetaryValueBySubtracting:audOne];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, NSDecimalNumber.one);
        XCTAssertEqualObjects(r, audOne);
    }
    {
        XCTAssertThrows([audOne monetaryValueBySubtracting:usdOne]);
    }
}

- (void)testMultiplication {
    NSDecimalNumber * const oneOverSix = [NSDecimalNumber.one decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"6" locale:nil]];
    NSDecimalNumber * const two = [NSDecimalNumber decimalNumberWithString:@"2"];

    TBCMonetaryValue * const unspecifiedZero = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.zero];
    TBCMonetaryValue * const unspecifiedOne = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.one];

    TBCMonetaryValue * const audOne = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"AUD" amount:NSDecimalNumber.one];

    {
        TBCMonetaryValue * const r = [unspecifiedOne monetaryValueByMultiplyingBy:NSDecimalNumber.zero];
        XCTAssertEqualObjects(r, unspecifiedZero);
    }
    {
        TBCMonetaryValue * const r = [unspecifiedOne monetaryValueByMultiplyingBy:NSDecimalNumber.one];
        XCTAssertEqualObjects(r, unspecifiedOne);
    }
    {
        TBCMonetaryValue * const r = [audOne monetaryValueByMultiplyingBy:two];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, two);
    }
    {
        TBCMonetaryValue * const r = [audOne monetaryValueByMultiplyingBy:oneOverSix];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, oneOverSix);
    }
    {
        NSDecimalNumberHandler * const roundDownTo2dp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        TBCMonetaryValue * const r = [audOne monetaryValueByMultiplyingBy:oneOverSix withBehavior:roundDownTo2dp];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, [NSDecimalNumber decimalNumberWithString:@".16" locale:nil]);
    }
    {
        NSDecimalNumberHandler * const roundDownTo4dp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:4 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        TBCMonetaryValue * const r = [audOne monetaryValueByMultiplyingBy:oneOverSix withBehavior:roundDownTo4dp];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, [NSDecimalNumber decimalNumberWithString:@".1666" locale:nil]);
    }
}

- (void)testDivision {
    NSDecimalNumber * const oneOverSix = [NSDecimalNumber.one decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"6" locale:nil]];
    NSDecimalNumber * const two = [NSDecimalNumber decimalNumberWithString:@"2"];
    NSDecimalNumber * const six = [NSDecimalNumber decimalNumberWithString:@"6"];

    TBCMonetaryValue * const unspecifiedZero = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.zero];
    TBCMonetaryValue * const unspecifiedOne = [TBCMonetaryValue monetaryValueWithUnspecifiedCurrencyCodeAndAmount:NSDecimalNumber.one];

    TBCMonetaryValue * const audOne = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"AUD" amount:NSDecimalNumber.one];

    {
        TBCMonetaryValue * const r = [unspecifiedZero monetaryValueByDividingBy:NSDecimalNumber.one];
        XCTAssertEqualObjects(r, unspecifiedZero);
    }
    {
        TBCMonetaryValue * const r = [unspecifiedOne monetaryValueByDividingBy:NSDecimalNumber.one];
        XCTAssertEqualObjects(r, unspecifiedOne);
    }
    {
        TBCMonetaryValue * const r = [audOne monetaryValueByDividingBy:two];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, [NSDecimalNumber decimalNumberWithString:@".5" locale:nil]);
    }
    {
        TBCMonetaryValue * const r = [audOne monetaryValueByDividingBy:six];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, oneOverSix);
    }
    {
        NSDecimalNumberHandler * const roundDownTo2dp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        TBCMonetaryValue * const r = [audOne monetaryValueByDividingBy:six withBehavior:roundDownTo2dp];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, [NSDecimalNumber decimalNumberWithString:@".16" locale:nil]);
    }
    {
        NSDecimalNumberHandler * const roundDownTo4dp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:4 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        TBCMonetaryValue * const r = [audOne monetaryValueByDividingBy:six withBehavior:roundDownTo4dp];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, [NSDecimalNumber decimalNumberWithString:@".1666" locale:nil]);
    }
}

- (void)testRounding {
    NSDecimalNumber * const oneOverSix = [NSDecimalNumber.one decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"6" locale:nil]];

    TBCMonetaryValue * const audOneOverSix = [TBCMonetaryValue monetaryValueWithCurrencyCode:@"AUD" amount:oneOverSix];

    {
        NSDecimalNumberHandler * const roundDownTo2dp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        TBCMonetaryValue * const r = [audOneOverSix monetaryValueByRoundingAccordingToBehavior:roundDownTo2dp];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, [NSDecimalNumber decimalNumberWithString:@".16" locale:nil]);
    }
    {
        NSDecimalNumberHandler * const roundDownTo4dp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:4 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
        TBCMonetaryValue * const r = [audOneOverSix monetaryValueByRoundingAccordingToBehavior:roundDownTo4dp];
        XCTAssertEqualObjects(r.currencyCode, @"AUD");
        XCTAssertEqualObjects(r.amount, [NSDecimalNumber decimalNumberWithString:@".1666" locale:nil]);
    }
}

@end
