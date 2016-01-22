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

@end
