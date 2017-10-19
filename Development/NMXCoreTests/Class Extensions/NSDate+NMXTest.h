//
//  NSDate+NMXTest.h
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 01.05.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NMXTest)

/**
 * @discussion static array with valid NSDate objects, which shall be used for all possible test cases
 * @return NSarray containing kinds of valid NSDates
 */
+ (NSArray *)testObjectTypeParamsValid;

/**
@discussion static array with invalid NSDate objects, which shall be used for all possible test cases
 * @warning Only returns subclasses of NSObject. If you want a 100% test coverage, also consider testing for primitive data types with cast to NSNumber, if compiler does not complain
 * @warning Also test for "nil" as passed variable, this cannot be returned in an array ;-)
 * @return NSarray containing all kinds of complex data objects, which are for sure no NSDate objects
 */
+ (NSArray *)testObjectTypeParamsInvalid;

@end
