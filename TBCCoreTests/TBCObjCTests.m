//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/TBCObjC.h>


@interface TBCObjCTests : XCTestCase
@end

@implementation TBCObjCTests

- (void)testObjectsAreDifferent {
    XCTAssertFalse(TBCObjectsAreDifferent(nil, nil));
    XCTAssertFalse(TBCObjectsAreDifferent(@YES, @YES));
    XCTAssert(TBCObjectsAreDifferent(@0, nil));
    XCTAssert(TBCObjectsAreDifferent(nil, @0));
    XCTAssert(TBCObjectsAreDifferent(@0, @1));
}

@end
