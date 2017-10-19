//
//  NSNumber+NMX.h
//  ios-objc-foundation-nmxcore
//
//  Created by Adriano Segalada on 10/06/16.
//  Copyright © 2016 Adriano Segalada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (NMX)

/**
*  true, if object > 0
*
*  - Author:
*  Adriano Segalada
*
*  - Version
*  1.0
*/
@property (readonly) BOOL isPositive;

/**
 *  true, if object >= 0
 *
 *  - Author:
 *  Adriano Segalada
 *
 *  - Version
 *  1.0
 */
@property (readonly) BOOL isPositiveOrZero;

@end
