//
//  NMXNSBundleFileHandling.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NMXNSBundleFileHandling.h"

__attribute__((overloadable)) NSString* _Nullable filePathForFile(NSString* _Nonnull fileName, NSString* _Nullable fileExtension, NSBundle* _Nullable bundle)
{
    if (!fileName || ![fileName isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    // fileExtension may be nil, but if it was not, we expect it to be a NSString
    if (fileExtension && ![fileExtension isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    if (fileExtension && ![fileName.pathExtension.lowercaseString isEqualToString:fileExtension.lowercaseString])
    {
        fileName = [fileName stringByAppendingFormat:@".%@",fileExtension];
    }
    
    return filePathForFile(fileName, bundle);
}

__attribute__((overloadable)) NSString* _Nullable filePathForFile(NSString* _Nonnull fileName, NSBundle* _Nullable bundle)
{
    if (!fileName || ![fileName isKindOfClass:[NSString class]])
    {
        return nil;
    }
    if (!bundle || ![bundle isKindOfClass:[NSBundle class]])
    {
        bundle = [NSBundle mainBundle];
    }
    NSString *fileNameWithoutExtension = [fileName stringByDeletingPathExtension];
    NSString *fileType = [fileName pathExtension];
    NSString *filePath = [bundle pathForResource:fileNameWithoutExtension ofType:fileType];
    if (!filePath)
    {
        //NSLog(@"🔵🔵 file Path could not be read: %@",fileName);
    }
    return filePath;

}

__attribute__((overloadable)) NSString* _Nullable filePathForFile(NSString* _Nonnull fileName)
{
    return filePathForFile(fileName, nil);
}
