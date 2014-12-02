//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <XCTest/XCTest.h>

#import <TBCCore/NSArray+TBCCore.h>

@interface NSArray_TBCCoreTests : XCTestCase

@end

@implementation NSArray_TBCCoreTests

- (void)testSimpleMap {
    NSArray *array = @[@(1),@(2),@(3)];
    NSArray *mappedArray = [array tbc_arrayByApplyingMap:^NSString *(NSNumber *number) {
        return [NSString stringWithFormat:@"%ld", (long)number.integerValue];
    }];
    
    NSArray *expectedOutput = @[@"1",@"2",@"3"];
    
    XCTAssertEqualObjects(mappedArray, expectedOutput);
}

- (void)testSimpleMapThroughAlias {
    NSArray *array = @[@(1),@(2),@(3)];
    NSArray *mappedArray = [array tbc_map:^NSString *(NSNumber *number) {
        return [NSString stringWithFormat:@"%ld", (long)number.integerValue];
    }];
    
    NSArray *expectedOutput = @[@"1",@"2",@"3"];
    
    XCTAssertEqualObjects(mappedArray, expectedOutput);
}

@end
