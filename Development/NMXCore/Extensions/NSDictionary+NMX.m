//
//  NSDictionary+NMXNSDictionary.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

//#import "NSDictionary+NMX.h"
#import "NMXNSBundleFileHandling.h"

@implementation NSDictionary (NMX)

+ (instancetype __nullable)dictionaryWithPlistFile:(NSString * __nonnull)fileName bundle:(NSBundle * __nullable)bundle
{
    NSString *filePath = filePathForFile(fileName, @"plist", bundle);
    if (!filePath)
    {
        #ifdef NMXCoreStatic
        #ifndef TEST
            NSLog(@"NMXLibrary: Couldn't retrieve a file with filename: [ \"%@\" ] in Bundle: [ \"%@\" ]. Will return nil",fileName, bundle);
        #endif
        #endif
        return nil;
    }

    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return plistDictionary;
}

+ (instancetype __nullable)dictionaryWithJSONFile:(NSString * __nonnull)fileName bundle:(NSBundle * __nullable)bundle
{
    NSString *filePath = filePathForFile(fileName, @"json", bundle);
    if (!filePath)
    {
        #ifdef NMXCoreStatic
        #ifndef TEST
            NSLog(@"NMXLibrary: Couldn't retrieve a file with filename: [ \"%@\" ] in Bundle: [ \"%@\" ]. Will return nil",fileName, bundle);
        #endif
        #endif
        return nil;
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    if (!jsonData || jsonData.length == 0)
    {
        return nil;
    }
    
    NSError *error = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if(error)
    {
        NSLog(@"No JSON Data loaded \"%s\"", __PRETTY_FUNCTION__);
    }
    return jsonDictionary;
}

@end
