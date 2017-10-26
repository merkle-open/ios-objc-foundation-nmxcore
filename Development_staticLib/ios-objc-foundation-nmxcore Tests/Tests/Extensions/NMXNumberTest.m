//
//  NMXNumberTest.m
//  Namics Library
//
//  Created by Tobias Baube on 29/06/16.
//  Copyright © 2016 Tobias Baube. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NMXCore.h"
#import "NSNumber+NMXTest.h"

@interface NMXNumberTest : XCTestCase

@end

@implementation NMXNumberTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsPositive
{
    XCTAssertFalse(@(0).isPositive);
    XCTAssertTrue(@(INT_MAX).isPositive);
    XCTAssertTrue(@(LONG_MAX).isPositive);
    XCTAssertTrue(@(LONG_LONG_MAX).isPositive);
    XCTAssertTrue(@(YES).isPositive);
    XCTAssertFalse(@(NO).isPositive);
    
    XCTAssertFalse(@(-1).isPositive);
    XCTAssertFalse(@(INT_MIN).isPositive);
    XCTAssertFalse(@(LONG_MIN).isPositive);
    XCTAssertFalse(@(LONG_LONG_MIN).isPositive);
}

- (void)testIsPositiveOrZero
{
    XCTAssertTrue(@(0).isPositiveOrZero);
    XCTAssertTrue(@(INT_MAX).isPositiveOrZero);
    XCTAssertTrue(@(LONG_MAX).isPositiveOrZero);
    XCTAssertTrue(@(LONG_LONG_MAX).isPositiveOrZero);
    XCTAssertTrue(@(YES).isPositiveOrZero);
    XCTAssertTrue(@(NO).isPositiveOrZero);
    
    XCTAssertFalse(@(-1).isPositiveOrZero);
    XCTAssertFalse(@(INT_MIN).isPositiveOrZero);
    XCTAssertFalse(@(LONG_MIN).isPositiveOrZero);
    XCTAssertFalse(@(LONG_LONG_MIN).isPositiveOrZero);
}

- (void)testValidNumbers
{
    for (NSNumber *obj in [NSNumber testObjectTypeParamsValid])
    {
        XCTAssertTrue([obj isKindOfClass:[NSNumber class]]);
    }
}


- (void)testInvalidNumbers
{
    for (NSNumber *obj in [NSNumber testObjectTypeParamsInvalid])
    {
        XCTAssertFalse([obj isKindOfClass:[NSNumber class]]);
    }
    NSObject *obj = nil;
    XCTAssertFalse([obj isKindOfClass:[NSNumber class]]);
}

@end
