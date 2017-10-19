//
//  NSNumber+NMXTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NSNumber+NMXTest.h"
#import "NMXTestDataSource.h"

@implementation NSNumber (NMXTest)

+ (NSArray *)testObjectTypeParamsValid
{
    return @[
             @(0),
             @(YES),
             @(INT_MIN),
             @(INT_MAX),
             @(LONG_MIN),
             @(LONG_MAX),
             @(LONG_LONG_MIN),
             @(LONG_LONG_MAX),
             ];
}

+ (NSArray *)testObjectTypeParamsInvalid
{
    NSPredicate *p = [NSPredicate predicateWithFormat:@"(self != nil) AND !(self isKindOfClass: %@)", self.class];
    NSArray *filtered = [[NMXTestDataSource testObjectTypes] filteredArrayUsingPredicate:p];
    return filtered;
}

@end
