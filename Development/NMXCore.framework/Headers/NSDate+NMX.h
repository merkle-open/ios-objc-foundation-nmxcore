//
//  NSDate+NMX.h
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 27/07/16.
//  Copyright © 2016 Tobias Baube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(NMX)

extern NSString *_Nonnull const NMXErrorDomainNSDate;
    
/**
 *  Returns the same day, but the time is altered and is 23h 59min 59s. One second before midnight (Uses NSCalendar.currentCalendar)
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 *  @return returns the same day, but the time is altered and will be 23:59:59. One second before midnight (Uses NSCalendar.currentCalendar). Will return "nil" on error or if unspecified
 */
@property (readonly, null_unspecified) NSDate *oneSecondBeforeEndOfDay;
    
/**
 *  Constructs a NSDate from self with a given offset in months
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 *  @param offsetInMonths - Offset in months. Negative integers go back in time, positive numbers return dates in the future. If this parameter is nil, the same date (without offset) will be returned.
 *  @param error - if the given offset does not allow to create a valid NSDate, a NSError with ErrorDomain `NMXCore.NSDate` is assigned
 *  @return returns a NSDate instance from self with a given offset. If the offset was invalid, the same date (without offset) will be returned.
 */
- (NSDate *_Nullable)offsetInMonths:(NSInteger)offsetInMonths error:(NSError *_Nullable *_Nullable)error;

/**
 *  Constructs a NSDate from self with a given offset in days
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 *  @param offsetInDays - Offset in days. Negative integers go back in time, positive numbers return dates in the future. If this parameter is nil, the same date (without offset) will be returned.
 *  @param error - if the given offset does not allow to create a valid NSDate, a NSError with ErrorDomain `NMXCore.NSDate` is assigned
 *  @return returns a NSDate instance from self with a given offset in days. If the offset was invalid, the same date (without offset) will be returned.
 */
- (NSDate *_Nullable)offsetInDays:(NSInteger)offsetInDays error:(NSError *_Nullable *_Nullable)error;

/**
 *  Constructs a NSDate from self with a given offset in minutes
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 *  @param offsetInMinutes - Offset in minutes. Negative integers go back in time, positive numbers return dates in the future. If this parameter is nil, the same date (without offset) will be returned.
 *  @param error - if the given offset does not allow to create a valid NSDate, a NSError with ErrorDomain `NMXCore.NSDate` is assigned
 *  @return returns a NSDate instance from self with a given offset in minutes. If the offset was invalid, the same date (without offset) will be returned.
 */
- (NSDate *_Nullable)offsetInMinutes:(NSInteger)offsetInMinutes error:(NSError *_Nullable *_Nullable)error;

/**
 *  Constructs a NSDate from self with a given offset in seconds
 *
 *  - Author: Adriano Segalada
 *
 *  - Version: 1.0
 *
 *  @param offsetInSeconds - Offset in seconds. Negative integers go back in time, positive numbers return dates in the future. If this parameter is nil, the same date (without offset) will be returned.
 *  @param error - if the given offset does not allow to create a valid NSDate, a NSError with ErrorDomain `NMXCore.NSDate` is assigned
 *  @return returns a NSDate instance from self with a given offset in seconds. If the offset was invalid, the same date (without offset) will be returned.
 */
- (NSDate *_Nullable)offsetInSeconds:(NSInteger)offsetInSeconds error:(NSError *_Nullable *_Nullable)error;

@end
