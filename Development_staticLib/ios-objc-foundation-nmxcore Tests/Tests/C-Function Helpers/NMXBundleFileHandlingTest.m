//
//  NMXBundleFileHandlingTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 13.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+NMXTest.h"
#import "NSBundle+NMXTest.h"
#import "NMXNSBundleFileHandling.h"

@interface NMXBundleFileHandlingTest : XCTestCase

@end

@implementation NMXBundleFileHandlingTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// __attribute__((overloadable)) NSString* _Nullable filePathForFile(NSString* _Nonnull fileName, NSString* _Nullable fileExtension, NSBundle* _Nullable bundle)
- (void)testPathForFilenameExtensionBundle_invalid
{
    BOOL avoidExtensiveLooping = YES;
    
    // 1st Parameter invalid
    for (NSString *fileName in [NSString testObjectTypeParamsInvalid])
    {
        // 2nd Parameter invalid
        for (NSString *fileExtension in [NSString testObjectTypeParamsInvalid])
        {
            // 3rd Parameter invalid
            for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
            {
                XCTAssertNoThrow(filePathForFile(fileName, fileExtension, bundle));
                XCTAssertNoThrow(filePathForFile(fileName, nil, bundle));
                XCTAssertNoThrow(filePathForFile(nil, fileExtension, bundle));
                if (avoidExtensiveLooping) break;
            }
            
            // 3rd Parameter valid
            for (NSBundle *bundle in [NSBundle testObjectTypeParamsValid])
            {
                XCTAssertNoThrow(filePathForFile(fileName, fileExtension, bundle));
                XCTAssertNoThrow(filePathForFile(fileName, nil, bundle));
                XCTAssertNoThrow(filePathForFile(nil, fileExtension, bundle));
                if (avoidExtensiveLooping) break;
            }
            XCTAssertNoThrow(filePathForFile(fileName, fileExtension, nil));
            XCTAssertNoThrow(filePathForFile(nil, fileExtension, nil));
            if (avoidExtensiveLooping) break;
        }
        
        
        // 2nd Parameter valid
        for (NSString *fileExtension in [NSString testObjectTypeParamsValid])
        {
            // 3rd Parameter invalid
            for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
            {
                XCTAssertNoThrow(filePathForFile(fileName, fileExtension, bundle));
                XCTAssertNoThrow(filePathForFile(fileName, nil, bundle));
                XCTAssertNoThrow(filePathForFile(nil, fileExtension, bundle));
                if (avoidExtensiveLooping) break;
            }
            
            // 3rd Parameter valid
            for (NSBundle *bundle in [NSBundle testObjectTypeParamsValid])
            {
                XCTAssertNoThrow(filePathForFile(fileName, fileExtension, bundle));
                XCTAssertNoThrow(filePathForFile(fileName, nil, bundle));
                XCTAssertNoThrow(filePathForFile(nil, fileExtension, bundle));
                if (avoidExtensiveLooping) break;
            }
            XCTAssertNoThrow(filePathForFile(fileName, fileExtension, nil));
            XCTAssertNoThrow(filePathForFile(nil, fileExtension, nil));
            if (avoidExtensiveLooping) break;
        }
        
        XCTAssertNoThrow(filePathForFile(fileName, nil, nil));
        if (avoidExtensiveLooping) break;
    }
    
    // 1st Parameter valid
    for (NSString *fileName in [NSString testObjectTypeParamsValid])
    {
        // 2nd Parameter invalid
        for (NSString *fileExtension in [NSString testObjectTypeParamsInvalid])
        {
            // 3rd Parameter invalid
            for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
            {
                XCTAssertNoThrow(filePathForFile(fileName, fileExtension, bundle));
                XCTAssertNoThrow(filePathForFile(fileName, nil, bundle));
                XCTAssertNoThrow(filePathForFile(nil, fileExtension, bundle));
                if (avoidExtensiveLooping) break;
            }
            
            // 3rd Parameter valid
            for (NSBundle *bundle in [NSBundle testObjectTypeParamsValid])
            {
                XCTAssertNoThrow(filePathForFile(fileName, fileExtension, bundle));
                XCTAssertNoThrow(filePathForFile(fileName, nil, bundle));
                XCTAssertNoThrow(filePathForFile(nil, fileExtension, bundle));
                if (avoidExtensiveLooping) break;
            }
            XCTAssertNoThrow(filePathForFile(fileName, fileExtension, nil));
            XCTAssertNoThrow(filePathForFile(nil, fileExtension, nil));
            if (avoidExtensiveLooping) break;
        }
        
        
        // 2nd Parameter valid
        for (NSString *fileExtension in [NSString testObjectTypeParamsValid])
        {
            // 3rd Parameter invalid
            for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
            {
                XCTAssertNoThrow(filePathForFile(fileName, fileExtension, bundle));
                XCTAssertNoThrow(filePathForFile(fileName, nil, bundle));
                XCTAssertNoThrow(filePathForFile(nil, fileExtension, bundle));
                if (avoidExtensiveLooping) break;
            }
            
            // 3rd Parameter valid
            for (NSBundle *bundle in [NSBundle testObjectTypeParamsValid])
            {
                XCTAssertNoThrow(filePathForFile(fileName, fileExtension, bundle));
                XCTAssertNoThrow(filePathForFile(fileName, nil, bundle));
                XCTAssertNoThrow(filePathForFile(nil, fileExtension, bundle));
                if (avoidExtensiveLooping) break;
            }
            XCTAssertNoThrow(filePathForFile(fileName, fileExtension, nil));
            XCTAssertNoThrow(filePathForFile(nil, fileExtension, nil));
            if (avoidExtensiveLooping) break;
        }
        
        XCTAssertNoThrow(filePathForFile(fileName, nil, nil));
        if (avoidExtensiveLooping) break;
    }
    
    XCTAssertNil(filePathForFile(nil, nil, nil));
}
    
- (void)testPathForFilenameExtensionBundle_valid
{
    XCTAssertNotNil(filePathForFile(@"NoPathExtension", nil, [NSBundle bundleForClass:self.class]));
    XCTAssertNil(filePathForFile(@"NoPathExtension", nil, nil));
    XCTAssertNotNil(filePathForFile(@"Info.plist", [NSBundle bundleForClass:self.class]));
}
    
// __attribute__((overloadable)) NSString* _Nullable filePathForFile(NSString* _Nonnull fileName, NSBundle* _Nullable bundle)
- (void)testPathForFilenameBundle_invalid
{
    // 1st Parameter invalid
    for (NSString *fileName in [NSString testObjectTypeParamsInvalid])
    {
        // 2nd Parameter invalid
        for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
        {
            XCTAssertNoThrow(filePathForFile(fileName, bundle));
        }
        XCTAssertNoThrow(filePathForFile(fileName, nil));
    }
    
    // 1st Parameter invalid
    for (NSString *fileName in [NSString testObjectTypeParamsInvalid])
    {
        // 2nd Parameter valid
        for (NSBundle *bundle in [NSBundle testObjectTypeParamsValid])
        {
            XCTAssertNoThrow(filePathForFile(fileName, bundle));
            XCTAssertNoThrow(filePathForFile(nil, bundle));
        }
    }
    
    // 1st Parameter valid
    for (NSString *fileName in [NSString testObjectTypeParamsValid])
    {
        // 2nd Parameter invalid
        for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
        {
            XCTAssertNoThrow(filePathForFile(fileName, bundle));
        }
        XCTAssertNoThrow(filePathForFile(fileName, nil));
    }
    
    XCTAssertNil(filePathForFile(@"abc/Info.plist", [NSBundle bundleForClass:self.class]));
    XCTAssertNil(filePathForFile(@"Info", [NSBundle bundleForClass:self.class]));
    XCTAssertNil(filePathForFile(@".plist", [NSBundle bundleForClass:self.class]));
    XCTAssertNil(filePathForFile(@"\nInfo.plist", [NSBundle bundleForClass:self.class]));
}

- (void)testPathForFilenameBundle_valid
{
    XCTAssertNotNil(filePathForFile(@"Info.plist", [NSBundle bundleForClass:self.class]));
}
    
// __attribute__((overloadable)) NSString* _Nullable filePathForFile(NSString* _Nonnull fileName)
- (void)testPathForFileName_invalid
{
    // Parameter 1 invalid
    for (NSString *fileName in [NSString testObjectTypeParamsInvalid])
    {
        XCTAssertNil(filePathForFile(fileName));
    }
    XCTAssertNil(filePathForFile(nil));
}

- (void)testPathForFileName_valid
{
    // XCTRunner.app should exist in the mainbundle
    // If not, have a look whats around:
    // NSLog(@"%@",[[NSBundle mainBundle] bundlePath]);
    XCTAssertNotNil(filePathForFile(@"XCTRunner.app"));
}

@end
