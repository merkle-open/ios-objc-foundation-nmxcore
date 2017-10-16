//
//  NSString+NMX.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 10/06/16.
//  Copyright © 2016 Adriano Segalada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NMX)

/**
 *  checks, whether the string is convertible to NSURL and/or custom scheme - anything would be valid, empty string are considered being invalid
 *
 *  - Author:
 *  Tobias Baube
 *
 *  - Version
 *  1.0
 */
@property (readonly) BOOL isUrlFormat;

/**
 *  escapes a string and its special characters like ("/" or "+" etc.), which would mess up in an url and escapes these, like a browser would do for example.
 *
 *  - Author:
 *  Tobias Baube
 *
 *  - Version
 *  1.0
 */
@property (readonly) NSString *urlEncoded;

/**
 *  if string is in the following date format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ", returns a NSDate Object
 *
 *  - Author:
 *  Adriano Segalada
 *
 *  - Version
 *  1.0
 */
@property (readonly) NSDate *dateFormatISO8601;

/**
 *  returns true, if string is in the following date format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
 *
 *  - Author:
 *  Adriano Segalada
 *
 *  - Version
 *  1.0
 */
@property (readonly) BOOL isDateFormatISO8601;

/**
 *  if string is in the following date format: "yyyy-MM-dd", returns a NSDate Object
 *
 *  - Author:
 *  Adriano Segalada
 *
 *  - Version
 *  1.0
 */
@property (readonly) NSDate *dateFormatFourDigitYearMonthDay;
    
/**
 *  returns true, if string is in the following date format: "yyyy-MM-dd"
 *
 *  - Author:
 *  Adriano Segalada
 *
 *  - Version
 *  1.0
 */
@property (readonly) BOOL isDateFormatFourDigitYearMonthDay;

/**
 *  if string is in the following date format: "HH:mm:ss", returns a NSDate Object
 *
 *  - Author:
 *  Adriano Segalada
 *
 *  - Version
 *  1.0
 */
@property (readonly) NSDate *dateFormatLeadingZeroHoursMinutesSeconds;

/**
 *  returns true, if string is in the following date format: "HH:mm:ss"
 *
 *  - Author:
 *  Adriano Segalada
 *
 *  - Version
 *  1.0
 */
@property (readonly) BOOL isDateFormatLeadingZeroHoursMinutesSeconds;

/**
 *  Returns a string without non alphanumeric characters
 *
 *  - Author:
 *  Thomas Bopst
 *
 *  - Version
 *  1.0
 */
@property (readonly) NSString *stripNonAlphanumericChars;


/**
 *  Returns a string with ASCII characters only
 *
 *  - Author:
 *  Thomas Bopst
 *
 *  - Version
 *  1.0
 */
@property (readonly) NSString *stripNonAsciiChars;

@end
