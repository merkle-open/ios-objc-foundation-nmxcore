//
//  NSNumber+NMX.m
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 10/06/16.
//  Copyright © 2016 Adriano Segalada. All rights reserved.
//

#import "NSNumber+NMX.h"

@implementation NSNumber (NMX)

- (BOOL)isPositive
{
    return [self integerValue] > 0;
}

- (BOOL)isPositiveOrZero
{
    return [self integerValue] >= 0;
}

@end
