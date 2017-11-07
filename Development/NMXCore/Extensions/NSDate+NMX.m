//
//  NSDate+NMX.m
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 27/07/16.
//  Copyright © 2016 Tobias Baube. All rights reserved.
//

#import "NSDate+NMX.h"

@implementation NSDate(NMX)

NSString *const NMXErrorDomainNSDate = @"NMXCore.NSDate";

    
- (NSDate *)oneSecondBeforeEndOfDay
{
    NSDate *date = [[NSCalendar currentCalendar] startOfDayForDate:self];
    NSError *error = nil;
    date = [date dateWithOffset:1 specifiedBySelector:@selector(setDay:) error:&error];
    if (!error)
    {
        date = [date dateWithOffset:-1 specifiedBySelector:@selector(setSecond:) error:&error];
        if (!error)
        {
            return date;
        }
    }
    return nil;
}
    
- (NSDate *)dateWithOffset:(NSInteger )offset specifiedBySelector:(SEL)selector error:(NSError **)error
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
        NSString *errorDescription = [NSString stringWithFormat:@"Offset (%ld) too small or too large to create a valid NSDate", (long)offset];
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: errorDescription
                                   };
        NSError *invalidError = [NSError errorWithDomain:NMXErrorDomainNSDate code:-1 userInfo:userInfo];
        *error = invalidError;
        return nil;
    }
    
    return nextDate;
}

- (NSDate *)offsetInMonths:(NSInteger)offsetInMonths error:(NSError **)error
{
    return [self dateWithOffset:offsetInMonths specifiedBySelector:@selector(setMonth:) error:error];
}

- (NSDate *)offsetInDays:(NSInteger)offsetInDays error:(NSError **)error
{
    return [self dateWithOffset:offsetInDays specifiedBySelector:@selector(setDay:) error:error];
}

- (NSDate *)offsetInMinutes:(NSInteger)offsetInMinutes error:(NSError **)error
{
    return [self dateWithOffset:offsetInMinutes specifiedBySelector:@selector(setMinute:) error:error];
}

- (NSDate *)offsetInSeconds:(NSInteger)offsetInSeconds error:(NSError **)error
{
    return [self dateWithOffset:offsetInSeconds specifiedBySelector:@selector(setSecond:) error:error];
}


@end
