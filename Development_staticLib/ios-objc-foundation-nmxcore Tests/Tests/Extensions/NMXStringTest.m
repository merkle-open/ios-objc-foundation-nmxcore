//
//  NMXStringTest.m
//  Namics Library
//
//  Created by Tobias Baube on 29/06/16.
//  Copyright © 2016 Tobias Baube. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NMXCore.h"

@interface NMXStringTest : XCTestCase

@end

@implementation NMXStringTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsUrlFormat
{
    XCTAssertTrue(@"http://google.com".isUrlFormat);
    XCTAssertTrue(@"https://google.com".isUrlFormat);
    XCTAssertTrue(@"customScheme://google.com".isUrlFormat);
    XCTAssertTrue(@"customScheme://google".isUrlFormat);
    XCTAssertTrue(@"customScheme://google?param=test&welcome=always".isUrlFormat);
    XCTAssertFalse(@"http:/google.com".isUrlFormat);
    XCTAssertFalse(@"http//google.com".isUrlFormat);
    XCTAssertFalse(@"google.com".isUrlFormat);
    XCTAssertFalse(@"".isUrlFormat);
}

- (void)testUrlEncoded
{
    XCTAssertTrue([@"!".urlEncoded isEqualToString:@"%21"]);
    XCTAssertTrue([@"*".urlEncoded isEqualToString:@"%2A"]);
    XCTAssertTrue([@"'".urlEncoded isEqualToString:@"%27"]);
    XCTAssertTrue([@"(".urlEncoded isEqualToString:@"%28"]);
    XCTAssertTrue([@")".urlEncoded isEqualToString:@"%29"]);
    XCTAssertTrue([@";".urlEncoded isEqualToString:@"%3B"]);
    XCTAssertTrue([@":".urlEncoded isEqualToString:@"%3A"]);
    XCTAssertTrue([@"@".urlEncoded isEqualToString:@"%40"]);
    XCTAssertTrue([@"&".urlEncoded isEqualToString:@"%26"]);
    XCTAssertTrue([@"=".urlEncoded isEqualToString:@"%3D"]);
    XCTAssertTrue([@"+".urlEncoded isEqualToString:@"%2B"]);
    XCTAssertTrue([@"$".urlEncoded isEqualToString:@"%24"]);
    XCTAssertTrue([@",".urlEncoded isEqualToString:@"%2C"]);
    XCTAssertTrue([@"/".urlEncoded isEqualToString:@"%2F"]);
    XCTAssertTrue([@"?".urlEncoded isEqualToString:@"%3F"]);
    XCTAssertTrue([@"%".urlEncoded isEqualToString:@"%25"]);
    XCTAssertTrue([@"#".urlEncoded isEqualToString:@"%23"]);
    XCTAssertTrue([@"[".urlEncoded isEqualToString:@"%5B"]);
    XCTAssertTrue([@"]".urlEncoded isEqualToString:@"%5D"]);
    XCTAssertTrue([@"\"".urlEncoded isEqualToString:@"%22"]);
    XCTAssertTrue([@" ".urlEncoded isEqualToString:@"%20"]);
}

- (void)testISO8601DateFormat
{
    XCTAssertNotNil(@"2010-01-01T12:00:00Z".dateFormatISO8601);
    XCTAssertNotNil(@"2010-01-01T12:00:00+0000".dateFormatISO8601);
    XCTAssertNotNil(@"2010-01-01T12:00:00+00:00".dateFormatISO8601);
    XCTAssertNotNil(@"2010-01-01T12:00:00z".dateFormatISO8601);
    
    XCTAssertNil(@"".dateFormatISO8601);
    XCTAssertNil(@"http://google.com".dateFormatISO8601);
    XCTAssertNil(@"2010-01-0112:00:00Z".dateFormatISO8601);
    XCTAssertNil(@"2010-01-01T12:00:00.1Z".dateFormatISO8601);
    XCTAssertNil(@"2010-01-01T12:00:00,1Z".dateFormatISO8601);
    XCTAssertNil(@"2010-01-32T12:00:00Z".dateFormatISO8601);
    XCTAssertNil(@"2010-13-01T12:00:00Z".dateFormatISO8601);
    XCTAssertNil(@"2010-01-01T24:00:00Z".dateFormatISO8601);
    XCTAssertNil(@"2010-01-01T12:60:00Z".dateFormatISO8601);
    XCTAssertNil(@"2010-01-01T12:00:60Z".dateFormatISO8601);
}

- (void)testIsISO8601DateFormat
{
    XCTAssertTrue(@"2010-01-01T12:00:00Z".isDateFormatISO8601);
    XCTAssertTrue(@"2010-01-01T12:00:00+0000".isDateFormatISO8601);
    XCTAssertTrue(@"2010-01-01T12:00:00+00:00".isDateFormatISO8601);
    XCTAssertTrue(@"2010-01-01T12:00:00z".isDateFormatISO8601);
    
    XCTAssertFalse(@"".isDateFormatISO8601);
    XCTAssertFalse(@"http://google.com".isDateFormatISO8601);
    XCTAssertFalse(@"2010-01-0112:00:00Z".isDateFormatISO8601);
    XCTAssertFalse(@"2010-01-01T12:00:00.1Z".isDateFormatISO8601);
    XCTAssertFalse(@"2010-01-01T12:00:00,1Z".isDateFormatISO8601);
    XCTAssertFalse(@"2010-01-32T12:00:00Z".isDateFormatISO8601);
    XCTAssertFalse(@"2010-13-01T12:00:00Z".isDateFormatISO8601);
    XCTAssertFalse(@"2010-01-01T24:00:00Z".isDateFormatISO8601);
    XCTAssertFalse(@"2010-01-01T12:60:00Z".isDateFormatISO8601);
    XCTAssertFalse(@"2010-01-01T12:00:60Z".isDateFormatISO8601);
}

- (void)testFourDigitYearMonthDayDateFormat
{
    XCTAssertNil(@"2010-01-01T12:00:00Z".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-01T12:00:00+0000".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-01T12:00:00+00:00".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-01T12:00:00z".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"http://google.com".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-0112:00:00Z".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-01T12:00:00.1Z".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-01T12:00:00,1Z".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-32T12:00:00Z".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-13-01T12:00:00Z".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-01T24:00:00Z".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-01T12:60:00Z".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"2010-01-01T12:00:60Z".dateFormatFourDigitYearMonthDay);
    
    XCTAssertNotNil(@"2010-01-01".dateFormatFourDigitYearMonthDay);
    XCTAssertNotNil(@"2010-1-01".dateFormatFourDigitYearMonthDay);
    XCTAssertNotNil(@"2010-01-31".dateFormatFourDigitYearMonthDay);
    
    XCTAssertNil(@"2010-31-01".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"10-31-01".dateFormatFourDigitYearMonthDay);
    XCTAssertNil(@"10-31-2010".dateFormatFourDigitYearMonthDay);
}

- (void)testIsFourDigitYearMonthDayDateFormat
{
    XCTAssertFalse(@"2010-01-01T12:00:00Z".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-01T12:00:00+0000".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-01T12:00:00+00:00".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-01T12:00:00z".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"http://google.com".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-0112:00:00Z".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-01T12:00:00.1Z".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-01T12:00:00,1Z".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-32T12:00:00Z".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-13-01T12:00:00Z".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-01T24:00:00Z".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-01T12:60:00Z".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"2010-01-01T12:00:60Z".isDateFormatFourDigitYearMonthDay);
    
    XCTAssertTrue(@"2010-01-01".isDateFormatFourDigitYearMonthDay);
    XCTAssertTrue(@"2010-1-01".isDateFormatFourDigitYearMonthDay);
    XCTAssertTrue(@"2010-01-31".isDateFormatFourDigitYearMonthDay);
    
    XCTAssertFalse(@"2010-31-01".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"10-31-01".isDateFormatFourDigitYearMonthDay);
    XCTAssertFalse(@"10-31-2010".isDateFormatFourDigitYearMonthDay);
}

- (void)testDateFormatLeadingZeroHoursMinutesSeconds
{
    XCTAssertNil(@"2010-01-01T12:00:00Z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-01T12:00:00+0000".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-01T12:00:00+00:00".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-01T12:00:00z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"http://google.com".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-0112:00:00Z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-01T12:00:00.1Z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-01T12:00:00,1Z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-32T12:00:00Z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-13-01T12:00:00Z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-01T24:00:00Z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-01T12:60:00Z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-01T12:00:60Z".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-01".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-1-01".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-01-31".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"2010-31-01".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"10-31-01".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"10-31-2010".dateFormatLeadingZeroHoursMinutesSeconds);
    
    XCTAssertNil(@"25:59:59".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"23-59-59".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"23:59-59".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"23-59:59".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"23:59:61".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNil(@"3:59:61".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNotNil(@"23:59:59".dateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertNotNil(@"03:09:09".dateFormatLeadingZeroHoursMinutesSeconds);
}

- (void)testIsDateFormatLeadingZeroHoursMinutesSeconds
{
    XCTAssertFalse(@"2010-01-01T12:00:00Z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-01T12:00:00+0000".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-01T12:00:00+00:00".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-01T12:00:00z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"http://google.com".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-0112:00:00Z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-01T12:00:00.1Z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-01T12:00:00,1Z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-32T12:00:00Z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-13-01T12:00:00Z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-01T24:00:00Z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-01T12:60:00Z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-01T12:00:60Z".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-01".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-1-01".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-01-31".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"2010-31-01".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"10-31-01".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"10-31-2010".isDateFormatLeadingZeroHoursMinutesSeconds);
    
    XCTAssertFalse(@"25:59:59".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"23-59-59".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"23:59-59".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"23-59:59".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"3:59:61".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertFalse(@"23:59:61".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertTrue(@"23:59:59".isDateFormatLeadingZeroHoursMinutesSeconds);
    XCTAssertTrue(@"03:09:09".isDateFormatLeadingZeroHoursMinutesSeconds);
}

- (void)testStripNonAlphanumericChars
{
    XCTAssertTrue([@"A" isEqualToString:@"A".stripNonAlphanumericChars]);
    XCTAssertTrue([@"é" isEqualToString:@"é".stripNonAlphanumericChars]);
    XCTAssertTrue([@"û" isEqualToString:@"û".stripNonAlphanumericChars]);
    XCTAssertTrue([@"ä" isEqualToString:@"ä".stripNonAlphanumericChars]);
    XCTAssertTrue([@"Ü" isEqualToString:@"Ü".stripNonAlphanumericChars]);
    XCTAssertTrue([@"œ" isEqualToString:@"œ".stripNonAlphanumericChars]);
    XCTAssertTrue([@"ō" isEqualToString:@"ō".stripNonAlphanumericChars]);
    XCTAssertTrue([@"Õ" isEqualToString:@"Õ".stripNonAlphanumericChars]);
    XCTAssertTrue([@"2" isEqualToString:@"2".stripNonAlphanumericChars]);
    XCTAssertTrue([@"stripNonAlphanumericChars" isEqualToString:@"stripNonAlphanumericChars".stripNonAlphanumericChars]);
    XCTAssertTrue([@"e\u0301" isEqualToString:@"e\u0301".stripNonAlphanumericChars]);
    XCTAssertTrue([@"英" isEqualToString:@"英".stripNonAlphanumericChars]);
    
    XCTAssertFalse([@"." isEqualToString:@".".stripNonAlphanumericChars]);
    XCTAssertFalse([@"," isEqualToString:@",".stripNonAlphanumericChars]);
    XCTAssertFalse([@":" isEqualToString:@":".stripNonAlphanumericChars]);
    XCTAssertFalse([@"-" isEqualToString:@"-".stripNonAlphanumericChars]);
    XCTAssertFalse([@"☢️" isEqualToString:@"☢️".stripNonAlphanumericChars]);
    XCTAssertFalse([@"☃" isEqualToString:@"☃".stripNonAlphanumericChars]);
}

- (void)testStripNonAsciiChars
{
    // Test whether all control characters ([0, 31] and 127) and extended ASCII codes are stripped (http://www.asciitable.com/)
    NSMutableString *printableAsciiCharacters = [NSMutableString string];
    for (NSUInteger i = 32; i < 127; ++i)
    {
        [printableAsciiCharacters appendFormat:@"%c", (char)i];
    }
    
    NSMutableString *allAsciCharacters = [NSMutableString string];
    for (NSUInteger i = 0; i < 255; ++i)
    {
        [allAsciCharacters appendFormat:@"%c", (char)i];
    }
    
    XCTAssertTrue([printableAsciiCharacters isEqualToString:allAsciCharacters.stripNonAsciiChars], "Result should not containt ASCII Characters in Range [0, 31] and 127");
    
    
    // Additional test cases
    XCTAssertTrue([@"" isEqualToString:@"☢️英".stripNonAsciiChars], "Should strip unicode character");
    XCTAssertTrue([@"" isEqualToString:@"".stripNonAsciiChars], "Empty string should stay empty");
}

@end
