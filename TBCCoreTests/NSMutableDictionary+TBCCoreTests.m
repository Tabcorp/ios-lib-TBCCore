//  Copyright (c) 2015 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>
#import <TBCCore/NSMutableDictionary+TBCCore.h>
#import <TBCCore/TBCTypeSafety.h>

@interface NSMutableDictionary_TBCCoreTests : XCTestCase

@end

@implementation NSMutableDictionary_TBCCoreTests

- (void)testExtractObjectMissAllowed {
    NSMutableDictionary *d = [@{} mutableCopy];
    XCTAssertNil([d tbc_extractObjectIfExistsForKey:@"notThere"]);
}

- (void)testExtractObjectMissNotAllowed {
    NSMutableDictionary *d = [@{} mutableCopy];
    XCTAssertThrows([d tbc_extractObjectForKey:@"notThere"]);
}

- (void)testExtractObject {
    NSMutableDictionary *d = [@{@"a": @1} mutableCopy];
    XCTAssertEqualObjects([d tbc_extractObjectForKey:@"a"], @1);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractNull {
    NSMutableDictionary *d = [@{@"a": [NSNull null]} mutableCopy];
    XCTAssertThrows([d tbc_extractObjectForKey:@"a"]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractNullMissAllowed {
    NSMutableDictionary *d = [@{@"a": [NSNull null]} mutableCopy];
    XCTAssertNil([d tbc_extractObjectIfExistsForKey:@"a"]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractNullMissAllowedDoesntCallBlock {
    NSMutableDictionary *d = [@{@"a": [NSNull null]} mutableCopy];
    XCTAssertNil([d tbc_extractObjectIfExistsForKey:@"a" withTransformationBlock:^id(id object) {
        XCTFail(@"block called for null");
        return nil;
    }]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractBlockReturnsNilThrows {
    NSMutableDictionary *d = [@{@"a": @1} mutableCopy];
    XCTAssertThrows([d tbc_extractObjectIfExistsForKey:@"a" withTransformationBlock:^id(id object) {
        return nil;
    }]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractIntegerMissAllowed {
    NSMutableDictionary *d = [@{} mutableCopy];
    XCTAssertEqual([d tbc_extractIntegerIfExistsForKey:@"notThere"], 0);
}

- (void)testExtractIntegerMissNotAllowed {
    NSMutableDictionary *d = [@{} mutableCopy];
    XCTAssertThrows([d tbc_extractIntegerForKey:@"notThere"]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractStringAsInteger {
    NSMutableDictionary *d = [@{@"a": @"1"} mutableCopy];
    XCTAssertThrows([d tbc_extractIntegerForKey:@"a"]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractIntegerFromString {
    NSMutableDictionary *d = [@{@"a": @"1"} mutableCopy];
    XCTAssertEqual([d tbc_extractIntegerForKey:@"a" withTransformationBlock:^NSInteger(id object) {
        NSString *numberString = TBCAssertNSString(object);
        return [numberString integerValue];
    }], 1);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractIntegerFromStringMiss {
    NSMutableDictionary *d = [@{} mutableCopy];
    XCTAssertEqual([d tbc_extractIntegerIfExistsForKey:@"notThere" withTransformationBlock:^NSInteger(id object) {
        XCTFail(@"block called for missing key");
        return 0;
    }], 0);
}

- (void)testExtractInteger {
    NSMutableDictionary *d = [@{@"a": @1} mutableCopy];
    XCTAssertEqual([d tbc_extractIntegerForKey:@"a"], 1);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractString {
    NSMutableDictionary *d = [@{@"a": @"1"} mutableCopy];
    XCTAssertEqualObjects([d tbc_extractStringForKey:@"a"], @"1");
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractStringAllowMiss {
    NSMutableDictionary *d = [@{} mutableCopy];
    XCTAssertNil([d tbc_extractStringIfExistsForKey:@"notThere"]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractStringFromNumber {
    NSMutableDictionary *d = [@{@"a": @1} mutableCopy];
    XCTAssertThrows([d tbc_extractStringForKey:@"a"]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractStringFromNumberAllowMiss {
    NSMutableDictionary *d = [@{@"a": @1} mutableCopy];
    XCTAssertThrows([d tbc_extractStringIfExistsForKey:@"a"]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractNumber {
    NSMutableDictionary *d = [@{@"a": @1} mutableCopy];
    XCTAssertEqualObjects([d tbc_extractNumberForKey:@"a"], @1);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractMissingNumber {
    NSMutableDictionary *d = [@{@"a": @1} mutableCopy];
    XCTAssertThrows([d tbc_extractNumberForKey:@"b"]);
    XCTAssertEqual([d count], (NSUInteger)1);
}

- (void)testExtractNumberFromString {
    NSMutableDictionary *d = [@{@"a": @"false"} mutableCopy];
    XCTAssertThrows([d tbc_extractNumberForKey:@"a"]);
    XCTAssertEqual([d count], (NSUInteger)0);
}

- (void)testExtractNumberAllowMiss {
    NSMutableDictionary *d = [@{} mutableCopy];
    XCTAssertNil([d tbc_extractNumberIfExistsForKey:@"a"]);
    XCTAssertEqual([d count], (NSUInteger)0);
}


@end
