//
//  NSString+NMXTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NSString+NMXTest.h"
#import "NMXTestDataSource.h"

@implementation NSString (NMXTest)

+ (NSArray *)testObjectTypeParamsValid
{
    return @[
             @"alphaString",
             @"012345",
             @"alphaNumeric1234",
             @"🎨 ☃ 英 Special Char",
             @"Filename.json",
             @"\EscapeMe",
             @"\nLineBreak",
             @"\t",
             @"Path/File.json",
             @"%20Whitespaces.json",
             @"%%20Whitespaces.json",
             ];
}

+ (NSArray *)testObjectTypeParamsInvalid
{
    NSPredicate *p = [NSPredicate predicateWithFormat:@"(self != nil) AND !(self isKindOfClass: %@)", self.class];
    NSArray *filtered = [[NMXTestDataSource testObjectTypes] filteredArrayUsingPredicate:p];
    return filtered;
}

@end
