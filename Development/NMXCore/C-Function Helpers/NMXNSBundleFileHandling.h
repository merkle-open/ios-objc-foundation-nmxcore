//
//  NMXNSBundleFileHandling.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Provides an absolute filePath within a given bundle of a filename and its related fileExtension
 *
 *  filename: "file" and fileExtension: "txt" will lead to a lookup for "file.txt"
 *
 *  filename: "file.txt" and fileExtension: "txt" will lead to a lookup for "file.txt"
 *
 *  filename: "file.TXT" and fileExtension: "txt" will lead to a lookup for "file.TXT"
 *
 *  filename: "file" and fileExtension: "" will lead to a lookup for "file"
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @param fileName make sure this filename exists in the provided bundle. If the filename's path extension is not equal to the provided fileExtension, the fileExtension will be appended to retrieve the requested file. If this parameter is nil, nil will be returned
 *  @param fileExtension defines the type of the file that is being looked up in a provided bundle. If this parameter is nil, nil will be returned
 *  @param bundle - specifies the bundle, in which the lookup is being performed. If this value is nil, the default bundle [NSBundle mainBundle] is used
 *  @return a NSString object that represents the fullpath to a file within the provided bundle. If non was found, nil is being returned.
 */
__attribute__((overloadable)) extern NSString* _Nullable filePathForFile(NSString* _Nonnull fileName, NSString *_Nullable fileExtension, NSBundle* _Nullable bundle);

/**
 *  Provides an absolute filePath within a given bundle of a given filename
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @param fileName - make sure this filename (including its path extension) exists in the provided bundle. If this parameter is nil, nil will be returned
 *  @param bundle - specifies the bundle, in which the lookup is being performed. If this value is nil, the default bundle [NSBundle mainBundle] is used 
 *  @return a NSString object that represents the fullpath to a file within the provided bundle. If non was found, nil is being returned.
 */
__attribute__((overloadable)) extern NSString* _Nullable filePathForFile(NSString* _Nonnull fileName, NSBundle* _Nullable bundle);

/**
 *  Provides an absolute filePath within the mainBundle of a given filename
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @param fileName - make sure this filename (including its path extension) exists in the main bundle. This method will retrieve the filePath from the mainbundle for you.
 *  @return a NSString object that represents the fullpath to a file within the provided bundle. If non was found, nil is being returned.
 */
__attribute__((overloadable)) extern NSString* _Nullable filePathForFile(NSString* _Nonnull fileName);

