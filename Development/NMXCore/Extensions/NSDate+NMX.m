//
//  NSDate+NMX.m
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 27/07/16.
//  Copyright © 2016 Tobias Baube. All rights reserved.
//

#import "NSDate+NMX.h"

@implementation NSDate(NMX)

#pragma mark - returns a date with a given offset in units specified by the selector
- (NSDate *)dateWithOffset:(NSInteger )offset specifiedBySelector:(SEL)selector
{
    if (offset == 0)
    {
        return self;
    }
    NSDateComponents *components = [NSDateComponents new];
    
    IMP impl = [components methodForSelector:selector];
    void* (*func)(id, SEL, NSInteger) = (void*)impl;
    func(components, selector, offset);
    
    NSDate *nextDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self options:0];
    
    if([self isEqualToDate:nextDate] && offset != 0)
    {
        @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:@"Offset (%ld) too small or too large to create a valid NSDate", (long)offset] userInfo:nil];
    }
    
    return nextDate;
}

#pragma mark - returns a date with a given offset in months
- (NSDate *)offsetInMonths:(NSInteger)offsetInMonths
{
    return [self dateWithOffset:offsetInMonths specifiedBySelector:@selector(setMonth:)];
}

#pragma mark - returns a date with a given offset in days
- (NSDate *)offsetInDays:(NSInteger)offsetInDays
{
    return [self dateWithOffset:offsetInDays specifiedBySelector:@selector(setDay:)];
}

#pragma mark - returns a date with a given offset in minutes
- (NSDate *)offsetInMinutes:(NSInteger)offsetInMinutes
{
    return [self dateWithOffset:offsetInMinutes specifiedBySelector:@selector(setMinute:)];
}

#pragma mark - returns a date with a given offset in seconds
- (NSDate *)offsetInSeconds:(NSInteger)offsetInSeconds
{
    return [self dateWithOffset:offsetInSeconds specifiedBySelector:@selector(setSecond:)];
}

#pragma mark - returns the date that is just before the end of the day
- (NSDate *)oneSecondBeforeEndOfDate
{
    NSDate *date = [[NSCalendar currentCalendar] startOfDayForDate:self];
    date = [date dateWithOffset:1 specifiedBySelector:@selector(setDay:)];
    date = [date dateWithOffset:-1 specifiedBySelector:@selector(setSecond:)];
    return date;
}

@end
