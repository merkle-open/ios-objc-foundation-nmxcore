//
//  NSDate+NMXTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 01.05.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NSDate+NMXTest.h"
#import "NMXTestDataSource.h"

@implementation NSDate (NMXTest)

+ (NSArray *)testObjectTypeParamsValid;
{
    NSMutableArray *dates = [[NSMutableArray alloc] initWithArray:@[
                                                                    [NSDate date],
                                                                    ]];
    return dates;
}

+ (NSArray *)testObjectTypeParamsInvalid
{
    NSPredicate *p = [NSPredicate predicateWithFormat:@"(self != nil) AND !(self isKindOfClass: %@)", self.class];
    NSArray *filtered = [[NMXTestDataSource testObjectTypes] filteredArrayUsingPredicate:p];
    return filtered;
}

@end
