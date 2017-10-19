//
//  NSDictionary+NMXTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NSDictionary+NMXTest.h"

@implementation NSDictionary (NMXNSDictionaryTest)

+ (NSArray *)testObjectTypeParamsValid;
{
    NSMutableArray *dicts = [[NSMutableArray alloc] initWithArray:@[
                                                                    @{}, // empty
                                                                    @{@"dictionaryObj":@{}},
                                                                    @{@"string":@"value"},
                                                                    @{@"number":@(0)},
                                                                    @{@"array":@[]},
                                                                    @{},
                                                                    ]];
    // Combine all single elements to one additional dict
    NSMutableDictionary *consolidatedDict = [NSMutableDictionary new];
    for (int i = 0; i < dicts.count; i++)
    {
        consolidatedDict[@(i).description] = dicts[i];
    }
    [dicts addObject:consolidatedDict];
    return dicts; 
}

@end
