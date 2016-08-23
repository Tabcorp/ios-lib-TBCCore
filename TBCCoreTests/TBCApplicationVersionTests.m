//  Copyright © 2016 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCCore.h>


@interface TBCApplicationVersionTests : XCTestCase
@end

@implementation TBCApplicationVersionTests

- (void)testParsingTrivial {
    XCTAssertFalse(TBCApplicationVersionFromString((id __nonnull)nil, NULL));
    XCTAssertFalse(TBCApplicationVersionFromString(@"", NULL));
}

- (void)testParsingMajor {
    TBCApplicationVersion v;
    TBCApplicationVersion const e = (TBCApplicationVersion){ .major = 1 };
    XCTAssert(TBCApplicationVersionFromString(@"1", &v));
    XCTAssert(TBCApplicationVersionEqualToVersion(v, e), @"%@", TBCApplicationVersionToString(v));
}

- (void)testParsingMajorMinor {
    TBCApplicationVersion v;
    TBCApplicationVersion const e = (TBCApplicationVersion){ .major = 2, .minor = 1 };
    XCTAssert(TBCApplicationVersionFromString(@"2.1", &v));
    XCTAssert(TBCApplicationVersionEqualToVersion(v, e), @"%@", TBCApplicationVersionToString(v));
}

- (void)testParsingMajorMinorPatch {
    TBCApplicationVersion v;
    TBCApplicationVersion const e = (TBCApplicationVersion){ .major = 3, .minor = 2, .patch = 1 };
    XCTAssert(TBCApplicationVersionFromString(@"3.2.1", &v));
    XCTAssert(TBCApplicationVersionEqualToVersion(v, e), @"%@", TBCApplicationVersionToString(v));
}

- (void)testParsingMajorMinorPatchTrailing {
    TBCApplicationVersion v;
    TBCApplicationVersion const e = (TBCApplicationVersion){ .major = 4, .minor = 3, .patch = 2 };
    XCTAssert(TBCApplicationVersionFromString(@"4.3.2.1", &v));
    XCTAssert(TBCApplicationVersionEqualToVersion(v, e), @"%@", TBCApplicationVersionToString(v));
}


- (void)testStringingNull {
    TBCApplicationVersion const v = (TBCApplicationVersion){ };
    XCTAssertEqualObjects(TBCApplicationVersionToString(v), @"0.0.0");
}

- (void)testStringingMajor {
    TBCApplicationVersion const v = (TBCApplicationVersion){ .major = 1 };
    XCTAssertEqualObjects(TBCApplicationVersionToString(v), @"1.0.0");
}

- (void)testStringingMajorMinor {
    TBCApplicationVersion const v = (TBCApplicationVersion){ .major = 2, .minor = 1 };
    XCTAssertEqualObjects(TBCApplicationVersionToString(v), @"2.1.0");
}

- (void)testStringingMajorMinorPatch {
    TBCApplicationVersion const v = (TBCApplicationVersion){ .major = 3, .minor = 2, .patch = 1 };
    XCTAssertEqualObjects(TBCApplicationVersionToString(v), @"3.2.1");
}


- (void)testComparison {
    TBCApplicationVersion const v = (TBCApplicationVersion){ .major = 4, .minor = 5, .patch = 6 };

    XCTAssert(TBCApplicationVersionEqualToVersion(v, (TBCApplicationVersion){ .major = 4, .minor = 5, .patch = 6 }));

    XCTAssert(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 3 }));
    XCTAssert(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 4 }));
    XCTAssertFalse(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 5 }));

    XCTAssert(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 3, .minor = 4 }));
    XCTAssert(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 4, .minor = 4 }));
    XCTAssert(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 4, .minor = 5 }));
    XCTAssertFalse(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 4, .minor = 6 }));
    XCTAssertFalse(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 5, .minor = 6 }));

    XCTAssert(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 4, .minor = 5, .patch = 5 }));
    XCTAssert(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 4, .minor = 5, .patch = 6 }));
    XCTAssertFalse(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 4, .minor = 5, .patch = 7 }));
    XCTAssertFalse(TBCApplicationVersionIsAtLeast(v, (TBCApplicationVersion){ .major = 4, .minor = 6, .patch = 7 }));
}

@end
