//
//  NSNumber+NMXTest.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (NMXTest)

/**
 * @discussion static array with valid NSNumber objects, which shall be used for all possible test cases
 * @warning also returns min and max values for int, long and longlong. If you have a certain range of valid numbers, this array might contain invalid numbers for you
 * @return NSarray containing kinds of valid NSNumbers
 */
+ (NSArray *)testObjectTypeParamsValid;

/**
 * @discussion static array with invalid NSNumber objects, which shall be used for all possible test cases
 * @warning Only returns subclasses of NSObject. If you want a 100% test coverage, also consider testing for primitive data types with cast to NSNumber, if compiler does not complain
 * @warning Also test for "nil" as passed variable, this cannot be returned in an array ;-)
 * @return NSarray containing all kinds of complex data objects, which are for sure no NSNumber object
 */
+ (NSArray *)testObjectTypeParamsInvalid;

@end
