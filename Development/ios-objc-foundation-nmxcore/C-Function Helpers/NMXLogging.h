//
//  NMXLogging.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 16.10.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Example enum description
 *
 *  - None: Will not set a prefix and only be visible in Debug builds
 *  - Debug: Will use "DEBUG" prefix and only be visible in Debug builds
 *  - Release: Will use "RELEASE" prefix and only visible in Release builds
 *  - All: Will use "All" prefix and is visible in any builds
 */
typedef NS_ENUM(NSInteger, NMXLogLevelType) {
    none,
    debug,
    release,
    all
};
extern NSString * _Nonnull const NMXLogLevelTypeDescription[];

void NMXLogWithPrefixAndArguments(NMXLogLevelType logLevel, NSString* _Nullable logPrefix, NSString* _Nonnull format, va_list arguments);

/**
 *  Wrapper function to support Logging-Functionality. You could also define a NMXLogLevel, if you want the log also being logged with a specific
 *
 *  - Author:
 *  Tobias Baube
 *
 *  - Version
 *  1.0
 *
 *  - See
 *  https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
 *
 *  @param format the string formatted message with parameters that shall be logged. Common String format specifiers are being used: https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
 */
__attribute__((overloadable)) void NMXLog(NSString* _Nonnull format, ...);

/**
 *  Wrapper function to support Logging-Functionality. You could also define a NMXLogLevel, if you want the log also being logged with a specific
 *
 *  - Author:
 *  Tobias Baube
 *
 *  - Version
 *  1.0
 *
 *  - See
 *  https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
 *
 *  @param logLevel optional parameters, which provides the visiblity range of the log function. Default parameter, if nil is provided, is "NMXLogLevels.None". E.g. "Only visible in Debug builds". If you want to provide a custom logging for a build type defined on your own (e.g. "AdHoc"), please use the "NMXLogLevels.All" logLevel inside of your own predefined precompiler macro if statement
 *  @param format the string formatted message with parameters that shall be logged. Common String format specifiers are being used: https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
 */
__attribute__((overloadable)) void NMXLog(NMXLogLevelType logLevel, NSString* _Nonnull format, ...);

/**
 *  Wrapper function to support Logging-Functionality. You could also define a NMXLogLevel, if you want the log also being logged with a specific
 *
 *  - Author:
 *  Tobias Baube
 *
 *  - Version
 *  1.0
 *
 *  - See
 *  https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
 *
 *  @param logLevel optional parameters, which provides the visiblity range of the log function. Default parameter, if nil is provided, is "NMXLogLevels.None". E.g. "Only visible in Debug builds". If you want to provide a custom logging for a build type defined on your own (e.g. "AdHoc"), please use the "NMXLogLevels.All" logLevel inside of your own predefined precompiler macro if statement
 *  @param logPrefix by default (when you set the logPrefix to nil) the log prefixes are defined by the provided loglevel (NMXLogLevels). If you want them to differ from the default ones, you can set these explicitely.
 *  @param format the string formatted message with parameters that shall be logged. Common String format specifiers are being used: https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html
 */
__attribute__((overloadable)) void NMXLogWithPrefix(NMXLogLevelType logLevel, NSString* _Nullable logPrefix, NSString* _Nonnull format, ...);
