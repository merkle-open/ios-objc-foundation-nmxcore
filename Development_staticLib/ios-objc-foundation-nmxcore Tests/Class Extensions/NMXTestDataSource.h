//
//  NMXTestDataSource.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMXTestDataSource : NSObject

/**
 * @discussion static array with any objects (we did implement so far), which shall be used for all possible test cases and extend NSObject (requirement for the NSArray)
 * @return NSarray containing kinds of valid NSObject derivates
 */
+ (NSArray *)testObjectTypes;

@end
