//
//  NSString+NMXTest.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NMXTest)

/**
 * @discussion static array with valid NSString objects, which shall be used for all possible test cases
 * @return NSarray containing kinds of valid NSString
 */
+ (NSArray *)testObjectTypeParamsValid;

/**
 * @discussion static array with invalid NSString objects, which shall be used for all possible test cases
 * @warning Only returns subclasses of NSObject. If you want a 100% test coverage, also consider testing for primitive data types with cast to NSString, if compiler does not complain
 * @warning Also test for "nil" as passed variable, this cannot be returned in an array ;-)
 * @return NSarray containing all kinds of complex data objects, which are for sure no NSBundle object
 */
+ (NSArray *)testObjectTypeParamsInvalid;

@end
