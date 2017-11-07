//
//  NMXTestDataSource.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NMXTestDataSource.h"

#import "NSBundle+NMXTest.h"
#import "NSNumber+NMXTest.h"
#import "NSString+NMXTest.h"
#import "NSDictionary+NMXTest.h"
#import "NSDate+NMXTest.h"

@implementation NMXTestDataSource

static id _combinationsOneCouldThinkOf;
/**
 * @discussion static array with any objects (we did implement so far), which shall be used for all possible test cases and extend NSObject (requirement for the NSArray)
 * @return NSarray containing kinds of valid NSObject derivates
 */
+ (NSArray *)testObjectTypes
{
    if (!_combinationsOneCouldThinkOf)
    {
        NSMutableArray *combinationsOneCouldThinkOf = [[NSMutableArray alloc] initWithArray:@[
                                                                                              @(0),
                                                                                              @(-1),
                                                                                              @(LONG_LONG_MAX),
                                                                                              @"String",
                                                                                              @"123",
                                                                                              [NSBundle mainBundle],
                                                                                              [NSNull null],
                                                                                              @{},
                                                                                              @[],
                                                                                              [NSValue valueWithPointer:@selector(description)],
                                                                                              ]];
        
        [combinationsOneCouldThinkOf addObjectsFromArray:[NSBundle testObjectTypeParamsValid]];
        [combinationsOneCouldThinkOf addObjectsFromArray:[NSDictionary testObjectTypeParamsValid]];
        [combinationsOneCouldThinkOf addObjectsFromArray:[NSNumber testObjectTypeParamsValid]];
        [combinationsOneCouldThinkOf addObjectsFromArray:[NSString testObjectTypeParamsValid]];
        [combinationsOneCouldThinkOf addObjectsFromArray:[NSDate testObjectTypeParamsValid]];
        _combinationsOneCouldThinkOf = [NSArray arrayWithArray:combinationsOneCouldThinkOf];
    }
    
    return _combinationsOneCouldThinkOf;
}

@end
