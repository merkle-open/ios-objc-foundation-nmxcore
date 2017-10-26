//
//  NSDictionary+NMXNSDictionary.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NMX)

/**
 *  Constructs an NSDictionary from a given json filename in the given bundle
 *
 *  - Precondition: fileName may not be nil
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @param fileName - make sure this filename exists in the provided bundle (filename can also be provided without extension: "filename.plist" and "filename". If provided without extension, "plist" will be appended for the initialization. If this parameter is nil, nil will be returned
 *  @param bundle - specifies the bundle, in which the lookup is being performed. If this value is nil, the default bundle [NSBundle mainBundle] is used
 *  @return returns a NSDictionary instance from a given plist-file. If the file was not found or input parameters are invalid, nil is being returned
 */
+ (instancetype __nullable)dictionaryWithPlistFile:(NSString * __nonnull)fileName bundle:(NSBundle * __nullable)bundle;

/**
 *  Constructs an NSDictionary from a given json filename in the given bundle
 *
 *  - Precondition: fileName may not be nil
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @param fileName - make sure this filename exists in the provided bundle (filename can also be provided without extension: "filename.json" and "filename". If provided without extension, "json" will be appended for the initialization. If this parameter is nil, nil will be returned
 *  @param bundle - specifies the bundle, in which the lookup is being performed. If this value is nil, the default bundle [NSBundle mainBundle] is used
 *  @return returns a NSDictionary instance from a given json-file. If the file was not found or input parameters are invalid, nil is being returned
 */

+ (instancetype __nullable)dictionaryWithJSONFile:(NSString * __nonnull)fileName bundle:(NSBundle * __nullable)bundle;

@end
