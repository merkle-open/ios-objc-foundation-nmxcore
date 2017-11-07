//
//  NMXDate+Test.h
//  NMXCore
//
//  Created by Adriano Segalada on 07.11.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NSDate+NMX.h"

@interface NSDate (Test)

- (NSDate *)dateWithOffset:(NSInteger )offset specifiedBySelector:(SEL)selector;

@end

