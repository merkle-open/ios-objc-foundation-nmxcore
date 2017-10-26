//
//  NMXDateTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 08.06.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NMXCore.h"

@interface NMXDateTest : XCTestCase

@end

@implementation NMXDateTest

static NSDateFormatter *dateFormatISO8601;

+ (void)setUp
{
    dateFormatISO8601 = [NSDateFormatter new];
    [dateFormatISO8601 setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOffsetInMonths
{
    // +1 month
    NSDate *dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    NSDate *resultDate = [dateToUse offsetInMonths:1];
    NSDate *expectedDate = @"2017-09-21T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -1 month
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMonths:-1];
    expectedDate = @"2017-07-21T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // +10 month, year wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMonths:10];
    expectedDate = @"2018-06-21T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -10 month, year wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMonths:-10];
    expectedDate = @"2016-10-21T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
}

- (void)testOffsetInDays
{
    // +1 day
    NSDate *dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    NSDate *resultDate = [dateToUse offsetInDays:1];
    NSDate *expectedDate = @"2017-08-22T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -1 day
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInDays:-1];
    expectedDate = @"2017-08-20T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // +20days, month wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInDays:20];
    expectedDate = @"2017-09-10T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -20days
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInDays:-20];
    expectedDate = @"2017-08-01T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
}

- (void)testOffsetInMinutes
{
    // +1 minute
    NSDate *dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    NSDate *resultDate = [dateToUse offsetInMinutes:1];
    NSDate *expectedDate = @"2017-08-21T10:10:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -1 minute
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMinutes:-1];
    expectedDate = @"2017-08-21T10:08:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // +50minutes
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMinutes:50];
    expectedDate = @"2017-08-21T10:59:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -50minutes, hour wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMinutes:-50];
    expectedDate = @"2017-08-21T09:19:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // +1450minutes, day wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMinutes:1450];
    expectedDate = @"2017-08-22T10:19:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
}

- (void)testOffsetInSeconds
{
    // +1 second
    NSDate *dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    NSDate *resultDate = [dateToUse offsetInSeconds:1];
    NSDate *expectedDate = @"2017-08-21T10:09:26+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -1 second
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInSeconds:-1];
    expectedDate = @"2017-08-21T10:09:24+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // +40 seconds, minute wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInSeconds:40];
    expectedDate = @"2017-08-21T10:10:05+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -40 seconds, minute wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInSeconds:-40];
    expectedDate = @"2017-08-21T10:08:45+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
}

- (void)testOneSecondBeforeEndOfDate
{
    //if some of these tests fail in the future, then it's most probably of the changed summer/wintertime because we use "current calendar".
    
    //
    //summertime
    //
    NSString *dateToUse = @"2017-06-08T14:31:25+02:00";
    NSString *expectedResult = @"2017-06-08T23:59:59+02:00";
    NSDate *resultDate = dateToUse.dateFormatISO8601.oneSecondBeforeEndOfDate;
    XCTAssertTrue([resultDate isEqualToDate:expectedResult.dateFormatISO8601], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedResult);
    //
    //end summertime
    //
    
    
    //
    //start wintertime
    //
    dateToUse = @"2017-02-02T10:05:25+02:00";
    //one hour less because of summer/winter time
    expectedResult = @"2017-02-03T00:59:59+02:00";
    resultDate = dateToUse.dateFormatISO8601.oneSecondBeforeEndOfDate;
    XCTAssertTrue([resultDate isEqualToDate:expectedResult.dateFormatISO8601], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedResult);
    
    dateToUse = @"2017-01-01T10:05:25+02:00";
    expectedResult = @"2017-01-02T00:59:59+02:00";
    resultDate = dateToUse.dateFormatISO8601.oneSecondBeforeEndOfDate;
    XCTAssertTrue([resultDate isEqualToDate:expectedResult.dateFormatISO8601], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedResult);
    
    dateToUse = @"2016-12-31T10:05:25+02:00";
    expectedResult = @"2017-01-01T00:59:59+02:00";
    resultDate = dateToUse.dateFormatISO8601.oneSecondBeforeEndOfDate;
    XCTAssertTrue([resultDate isEqualToDate:expectedResult.dateFormatISO8601], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedResult);
    //
    //end wintertime
    //
}


@end
