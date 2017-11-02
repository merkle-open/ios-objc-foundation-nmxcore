//
//  NSBundle+NMXTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NSBundle+NMXTest.h"
#import "NMXTestDataSource.h"

@implementation NSBundle (NMXTest)

+ (NSArray *)testObjectTypeParamsValid
{
    NSMutableArray *validBundlesArray = [NSMutableArray new];
    [validBundlesArray addObjectsFromArray:[NSBundle allFrameworks]];
    [validBundlesArray addObjectsFromArray:[NSBundle allBundles]];
    [validBundlesArray addObject:[NSBundle mainBundle]];
    return validBundlesArray;
}

+ (NSArray *)testObjectTypeParamsInvalid
{
    NSPredicate *p = [NSPredicate predicateWithFormat:@"(self != nil) AND !(self isKindOfClass: %@)", self.class];
    NSArray *filtered = [[NMXTestDataSource testObjectTypes] filteredArrayUsingPredicate:p];
    return filtered;
}

@end
