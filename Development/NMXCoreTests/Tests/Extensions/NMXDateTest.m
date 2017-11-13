//
//  NMXDateTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 08.06.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NMXCore.h"
#import "NSDate+NMXTest.h"
#import "NSNumber+NMXTest.h"
#import "NMXDate+Test.h"

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
    NSDate *resultDate = [dateToUse offsetInMonths:1 error:nil];
    NSDate *expectedDate = @"2017-09-21T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -1 month
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMonths:-1 error:nil];
    expectedDate = @"2017-07-21T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // +10 month, year wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMonths:10 error:nil];
    expectedDate = @"2018-06-21T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -10 month, year wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMonths:-10 error:nil];
    expectedDate = @"2016-10-21T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    //invalid dates
    for(NSDate *date in [NSDate testObjectTypeParamsInvalid])
    {
        XCTAssertThrows([date offsetInMonths:1 error:nil]);
    }
    
    //valid dates
    for(NSDate *date in [NSDate testObjectTypeParamsValid])
    {
        XCTAssertNoThrow([date offsetInMonths:1 error:nil]);
    }
}

- (void)testOffsetInDays
{
    // +1 day
    NSDate *dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    NSDate *resultDate = [dateToUse offsetInDays:1 error:nil];
    NSDate *expectedDate = @"2017-08-22T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -1 day
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInDays:-1 error:nil];
    expectedDate = @"2017-08-20T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // +20days, month wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInDays:20 error:nil];
    expectedDate = @"2017-09-10T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -20days
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInDays:-20 error:nil];
    expectedDate = @"2017-08-01T10:09:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    //invalid dates
    for(NSDate *date in [NSDate testObjectTypeParamsInvalid])
    {
        XCTAssertThrows([date offsetInDays:1 error:nil]);
    }
    
    //valid dates
    for(NSDate *date in [NSDate testObjectTypeParamsValid])
    {
        XCTAssertNoThrow([date offsetInDays:1 error:nil]);
    }
}

- (void)testOffsetInMinutes
{
    // +1 minute
    NSDate *dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    NSDate *resultDate = [dateToUse offsetInMinutes:1 error:nil];
    NSDate *expectedDate = @"2017-08-21T10:10:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -1 minute
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMinutes:-1 error:nil];
    expectedDate = @"2017-08-21T10:08:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // +50minutes
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMinutes:50 error:nil];
    expectedDate = @"2017-08-21T10:59:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // -50minutes, hour wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMinutes:-50 error:nil];
    expectedDate = @"2017-08-21T09:19:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    // +1450minutes, day wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInMinutes:1450 error:nil];
    expectedDate = @"2017-08-22T10:19:25+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate]);
    
    //invalid dates
    for(NSDate *date in [NSDate testObjectTypeParamsInvalid])
    {
        XCTAssertThrows([date offsetInMinutes:1 error:nil]);
    }
    
    //valid dates
    for(NSDate *date in [NSDate testObjectTypeParamsValid])
    {
        XCTAssertNoThrow([date offsetInMinutes:1 error:nil]);
    }
}

- (void)testOffsetInSeconds
{
    // +1 second
    NSDate *dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    NSDate *resultDate = [dateToUse offsetInSeconds:1 error:nil];
    NSDate *expectedDate = @"2017-08-21T10:09:26+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedDate);
    
    // -1 second
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInSeconds:-1 error:nil];
    expectedDate = @"2017-08-21T10:09:24+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedDate);
    
    // +40 seconds, minute wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    resultDate = [dateToUse offsetInSeconds:40 error:nil];
    expectedDate = @"2017-08-21T10:10:05+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedDate);
    
    // -40 seconds, minute wrap
    dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    
    resultDate = [dateToUse offsetInSeconds:-40 error:nil];
    expectedDate = @"2017-08-21T10:08:45+02:00".dateFormatISO8601;
    XCTAssertTrue([resultDate isEqualToDate:expectedDate], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedDate);
    
    //valid dates
    for(NSDate *date in [NSDate testObjectTypeParamsValid])
    {
        NSError *err;
        XCTAssertNotNil([date offsetInSeconds:1 error:&err], @"🔴🔴 Input was ialid, we expect to have a date object being returned");
        XCTAssertNil(err, @"🔴🔴 We provided valid input => NO Error should be returned!");
    }
}

- (void)testOneSecondBeforeEndOfDate
{
    //if some of these tests fail in the future, then it's most probably of the changed summer/wintertime because we use "current calendar".
    
    //
    //summertime
    //
    NSString *dateToUse = @"2017-06-08T14:31:25+02:00";
    NSDate *resultDate = dateToUse.dateFormatISO8601.oneSecondBeforeEndOfDay;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateToUse.dateFormatISO8601];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    [components setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *expectedResultDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    XCTAssertTrue([resultDate isEqualToDate:expectedResultDate], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedResultDate);
    //
    //end summertime
    //

    //
    //start wintertime
    //
    
    dateToUse = @"2017-01-01T10:05:25+02:00";
    //one hour less because of summer/winter time
    resultDate = dateToUse.dateFormatISO8601.oneSecondBeforeEndOfDay;
    components = [[NSCalendar currentCalendar] components: NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateToUse.dateFormatISO8601];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    [components setTimeZone:[NSTimeZone localTimeZone]];
    expectedResultDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    XCTAssertTrue([resultDate isEqualToDate:expectedResultDate], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedResultDate);
    
    dateToUse = @"2016-12-31T10:05:25+02:00";
    //one hour less because of summer/winter time
    resultDate = dateToUse.dateFormatISO8601.oneSecondBeforeEndOfDay;
    components = [[NSCalendar currentCalendar] components: NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:dateToUse.dateFormatISO8601];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    [components setTimeZone:[NSTimeZone localTimeZone]];
    expectedResultDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    XCTAssertTrue([resultDate isEqualToDate:expectedResultDate], @"🔴🔴 Result was %@, expected result is %@", resultDate, expectedResultDate);
}

- (void)testValidDates
{
    for (NSDate *obj in [NSDate testObjectTypeParamsValid])
    {
        XCTAssertTrue([obj isKindOfClass:[NSDate class]]);
    }
}

- (void)testInvalidDates
{
    for (NSDate *obj in [NSDate testObjectTypeParamsInvalid])
    {
        XCTAssertFalse([obj isKindOfClass:[NSDate class]]);
    }
    NSObject *obj = nil;
    XCTAssertFalse([obj isKindOfClass:[NSDate class]]);
}

- (void)testInputParams
{
    //invalid input params
    NSDate *dateToUse = @"2017-08-21T10:09:25+02:00".dateFormatISO8601;
    NSDate *resultDate = [dateToUse offsetInSeconds:(NSInteger)nil error:nil];
    XCTAssertTrue([resultDate isEqualToDate:dateToUse], @"🔴🔴 Result was %@, expected the input date %@", resultDate, dateToUse);
    
    //valid input params
    const SEL selectors[] = {@selector(setMonth:), @selector(setDay:), @selector(setMinute:), @selector(setSecond:)};
    for (int i = 0; i < sizeof(selectors)/sizeof(selectors[0]); i++)
    {
        for (NSNumber *number in [NSNumber testObjectTypeParamsValid])
        {
            NSError *err;
            resultDate = [dateToUse offsetInSeconds:[number integerValue] error:&err];
            if (!resultDate)
            {
                XCTAssertTrue([err.domain isEqualToString:NMXErrorDomainNSDate], @"🔴🔴 Input could not be used to generate the requested date object, thus the error domain is expected to be %@, but it was %@",NMXErrorDomainNSDate, err.domain);
            }
            
            if ([number integerValue] == 0)
            {
                XCTAssertTrue([resultDate isEqualToDate:dateToUse], @"🔴🔴 Result was %@, should not be different from the dateToUse which was %@. Offset was %ld", resultDate, dateToUse, (long)[number integerValue]);
                XCTAssertNil(err, @"🔴🔴 No error expected if offset == 0, but the error is %@", err);
            }
            else if (!err)
            {
                XCTAssertFalse([resultDate isEqualToDate:dateToUse], @"🔴🔴 Result was %@, should be different from the dateToUse which was %@. Offset was %ld", resultDate, dateToUse, (long)[number integerValue]);
            }
        }
    }
}

@end
