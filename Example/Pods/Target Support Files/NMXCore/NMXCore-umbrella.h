#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NMXCFunctionHelpers.h"
#import "NMXLogging.h"
#import "NMXNSBundleFileHandling.h"
#import "NMXExtensions.h"
#import "NSDate+NMX.h"
#import "NSDictionary+NMX.h"
#import "NSNumber+NMX.h"
#import "NSString+NMX.h"
#import "NMXCore.h"
#import "NMXLocalizationHandler.h"
#import "NMXUtilities.h"

FOUNDATION_EXPORT double NMXCoreVersionNumber;
FOUNDATION_EXPORT const unsigned char NMXCoreVersionString[];

