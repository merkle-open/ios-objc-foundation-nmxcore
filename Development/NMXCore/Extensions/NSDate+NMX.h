//
//  NSDate+NMX.h
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 27/07/16.
//  Copyright © 2016 Tobias Baube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(NMX)

/**
 *  Constructs a NSDate from self with a given offset in months
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 *  @param offsetInMonths - Offset in months. Negative integers go back in time, positive numbers return dates in the future. If this parameter is nil, the same date (without offset) will be returned.
 *  @throws NSRangeException if the given offset does not allow to create a valid NSDate
 *  @return returns a NSDate instance from self with a given offset. If the offset was invalid, the same date (without offset) will be returned.
 */
- (NSDate *)offsetInMonths:(NSInteger)offsetInMonths;

/**
 *  Constructs a NSDate from self with a given offset in days
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 *  @param offsetInDays - Offset in days. Negative integers go back in time, positive numbers return dates in the future. If this parameter is nil, the same date (without offset) will be returned.
 *  @throws NSRangeException if the given offset does not allow to create a valid NSDate
 *  @return returns a NSDate instance from self with a given offset in days. If the offset was invalid, the same date (without offset) will be returned.
 */
- (NSDate *)offsetInDays:(NSInteger)offsetInDays;

/**
 *  Constructs a NSDate from self with a given offset in minutes
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 *  @param offsetInMinutes - Offset in minutes. Negative integers go back in time, positive numbers return dates in the future. If this parameter is nil, the same date (without offset) will be returned.
 *  @throws NSRangeException if the given offset does not allow to create a valid NSDate
 *  @return returns a NSDate instance from self with a given offset in minutes. If the offset was invalid, the same date (without offset) will be returned.
 */
- (NSDate *)offsetInMinutes:(NSInteger)offsetInMinutes;

/**
 *  Constructs a NSDate from self with a given offset in seconds
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 *  @param offsetInSeconds - Offset in seconds. Negative integers go back in time, positive numbers return dates in the future. If this parameter is nil, the same date (without offset) will be returned.
 *  @throws NSRangeException if the given offset does not allow to create a valid NSDate
 *  @return returns a NSDate instance from self with a given offset in seconds. If the offset was invalid, the same date (without offset) will be returned.
 */
- (NSDate *)offsetInSeconds:(NSInteger)offsetInSeconds;

/**
 *  Returns the same day, but the time is altered and is 23h 59min 59s. One second before midnight)
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 */
@property (readonly) NSDate *oneSecondBeforeEndOfDate;

@end
