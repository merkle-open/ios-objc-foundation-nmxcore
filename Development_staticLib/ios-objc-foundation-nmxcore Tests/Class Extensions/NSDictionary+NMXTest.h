//
//  NSDictionary+NMXTest.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NMXTest)

/**
 * @discussion static array with valid NSDictionary objects, which shall be used for all possible test cases
 * @return NSarray containing kinds of valid NSDictionaries
 */
+ (NSArray *)testObjectTypeParamsValid;

@end
