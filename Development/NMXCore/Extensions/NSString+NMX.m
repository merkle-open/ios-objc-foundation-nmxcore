//
//  NSString+NMXNSString.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 10/06/16.
//  Copyright © 2016 Adriano Segalada. All rights reserved.
//

#import "NSString+NMX.h"

@implementation NSString (NMX)
@dynamic isUrlFormat;

- (BOOL)isUrlFormat
{
    if (![NSURL URLWithString:self] ||
        self.length == 0 ||
        [self rangeOfString:@"://"].location == NSNotFound
        )
    {
        return NO;
    }
    return YES;
}

static id _urlEncodedCharacterSet;
- (NSString *)urlEncoded
{
    if (!_urlEncodedCharacterSet)
    {
        NSCharacterSet * queryKVSet = [NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]\" "].invertedSet;
        _urlEncodedCharacterSet = queryKVSet;
    }
    NSString *urlEncodedString = [self stringByAddingPercentEncodingWithAllowedCharacters:_urlEncodedCharacterSet];
    return urlEncodedString;
}

/*
 ***********************************
 *  @"yyyy-MM-dd'T'HH:mm:ssZZZZZ"  *
 ***********************************
 */
static NSDateFormatter *dateFormatterISO8601;
- (NSDate *)dateFormatISO8601
{
    if (!dateFormatterISO8601) {
        NSDateFormatter *dateFormatISO8601 = [NSDateFormatter new];
        
        //Overwriting the locale is a very ugly hack, to fix Apple's non-brilliant idea to overwrite the "HH" internally with "hh" in case the user has chosen the 12h time format in the device settings.
        //Apple tells us to do so... https://developer.apple.com/library/content/qa/qa1480/_index.html#//apple_ref/doc/uid/DTS40009878
        // https://stackoverflow.com/questions/2135267/nsdateformatter-with-24-hour-times
        // https://stackoverflow.com/questions/11062280/nsdateformatter-in-12-hour-mode
        [dateFormatISO8601 setLocale:[NSLocale localeWithLocaleIdentifier:@"de_CH"]];
        
        [dateFormatISO8601 setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
        dateFormatterISO8601 = dateFormatISO8601;
    }
    NSDate *date = [dateFormatterISO8601 dateFromString:self];
    
    return date;
}

- (BOOL)isDateFormatISO8601
{
    return self.dateFormatISO8601 != nil;
}

/*
 ***********************************
 *          @"yyyy-MM-dd"          *
 ***********************************
 */
static NSDateFormatter *dateFormatterFourDigitYearMonthDay;
- (NSDate *)dateFormatFourDigitYearMonthDay
{
    if (!dateFormatterFourDigitYearMonthDay) {
        NSDateFormatter *dateFormatFourDigitYearMonthDay = [NSDateFormatter new];
        [dateFormatFourDigitYearMonthDay setDateFormat:@"yyyy-MM-dd"];
        dateFormatterFourDigitYearMonthDay = dateFormatFourDigitYearMonthDay;
    }
    NSDate *date = [dateFormatterFourDigitYearMonthDay dateFromString:self];
    
    return date;
}

- (BOOL)isDateFormatFourDigitYearMonthDay
{
    return self.dateFormatFourDigitYearMonthDay != nil;
}

/*
 ***********************************
 *           @"HH:mm:ss"           *
 ***********************************
 */
static NSDateFormatter *dateFormatterLeadingZeroHoursMinutesSeconds;
- (NSDate *)dateFormatLeadingZeroHoursMinutesSeconds
{
    if (!dateFormatterLeadingZeroHoursMinutesSeconds) {
        NSDateFormatter *dateFormatHoursMinsSecs = [NSDateFormatter new];
        [dateFormatHoursMinsSecs setDateFormat:@"HH:mm:ss"];
        dateFormatterLeadingZeroHoursMinutesSeconds = dateFormatHoursMinsSecs;
    }
    NSDate *date = [dateFormatterLeadingZeroHoursMinutesSeconds dateFromString:self];
    
    // For some reason the DateFormatter does recognize similar patterns to the "real" pattern as valid
    // Setting dateFormatter.lenient to true does NOT help
    // http://stackoverflow.com/questions/43365371/nsdateformatter-returns-date-object-from-invalid-input?noredirect=1#comment73793203_43365371
    if (date)
    {
        NSString *stringFromFormattedDate = [dateFormatterLeadingZeroHoursMinutesSeconds stringFromDate:date];
        if (![stringFromFormattedDate isEqualToString:self])
        {
            return nil;
        }
    }
    return date;
}

- (BOOL)isDateFormatLeadingZeroHoursMinutesSeconds
{
    return self.dateFormatLeadingZeroHoursMinutesSeconds != nil;
}

- (NSString *)stripNonAlphanumericChars
{
    NSCharacterSet *nonAsciiCharacterSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:nonAsciiCharacterSet] componentsJoinedByString:@""];
}

static id _asciiCharactersSet;
- (NSString *)stripNonAsciiChars
{
    if (!_asciiCharactersSet)
    {
        NSMutableString *asciiCharacters = [NSMutableString string];
        for (NSInteger i = 32; i < 127; i++)  {
            [asciiCharacters appendFormat:@"%c", (char)i];
        }
        NSCharacterSet *nonAsciiCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:asciiCharacters] invertedSet];
        _asciiCharactersSet = nonAsciiCharacterSet;
    }
    
    return [[self componentsSeparatedByCharactersInSet:_asciiCharactersSet] componentsJoinedByString:@""];
}

@end
