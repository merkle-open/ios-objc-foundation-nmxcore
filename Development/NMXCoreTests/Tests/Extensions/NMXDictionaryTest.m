//
//  NMXDictionaryTest.m
//  Namics Library
//
//  Created by Tobias Baube on 29/06/16.
//  Copyright © 2016 Tobias Baube. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NMXCore.h"
#import "NSBundle+NMXTest.h"
#import "NSDictionary+NMXTest.h"
#import "NSString+NMXTest.h"

@interface NMXDictionaryTest : XCTestCase

@end

@implementation NMXDictionaryTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDictionaryWithPlistFileInvalid
{
    XCTAssertNil([NSDictionary dictionaryWithPlistFile:@"trackings_valid_1.json" bundle:[NSBundle bundleForClass:self.class]]);
    XCTAssertNil([NSDictionary dictionaryWithPlistFile:@"empty.json" bundle:[NSBundle bundleForClass:self.class]]);
    XCTAssertNil([NSDictionary dictionaryWithPlistFile:@"empty" bundle:[NSBundle bundleForClass:self.class]]);
    XCTAssertNil([NSDictionary dictionaryWithPlistFile:@"image.PNG" bundle:[NSBundle bundleForClass:self.class]]);
    
    // 1st Parameter invalid
    for (NSString *fileName in [NSString testObjectTypeParamsInvalid])
    {
        // 2nd Parameter invalid
        for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
        {
            XCTAssertNil([NSDictionary dictionaryWithPlistFile:fileName bundle:bundle]);
            // Dont want to see "Warning: Null passed to a callee that requires a non-null argument" - this is intended for testing
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
            XCTAssertNil([NSDictionary dictionaryWithPlistFile:(NSString *)nil bundle:bundle]);
#pragma clang diagnostic pop
            
        }
        XCTAssertNil([NSDictionary dictionaryWithJSONFile:fileName bundle:nil]);
    }
    
    // 1st Parameter invalid
    for (NSString *fileName in [NSString testObjectTypeParamsInvalid])
    {
        // 2nd Parameter valid
        for (NSBundle *bundle in [NSBundle testObjectTypeParamsValid])
        {
            XCTAssertNil([NSDictionary dictionaryWithJSONFile:fileName bundle:bundle]);
            
            // Dont want to see "Warning: Null passed to a callee that requires a non-null argument" - this is intended for testing
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
            XCTAssertNil([NSDictionary dictionaryWithPlistFile:(NSString *)nil bundle:bundle]);
#pragma clang diagnostic pop
            
        }
        XCTAssertNil([NSDictionary dictionaryWithPlistFile:fileName bundle:nil]);
    }
    
    // 1st Parameter valid
    for (NSString *fileName in [NSString testObjectTypeParamsValid])
    {
        // 2nd Parameter invalid
        for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
        {
            XCTAssertNil([NSDictionary dictionaryWithPlistFile:fileName bundle:bundle]);
        }
        XCTAssertNil([NSDictionary dictionaryWithPlistFile:fileName bundle:nil]);
    }
}

- (void)testDictionaryWithPlistFileValidFormat
{
    NSString *bundleRoot = [[NSBundle bundleForClass:[self class]] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    
    NSString *predicate = [NSString stringWithFormat:@"self ENDSWITH 'plist'"];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:predicate];
    NSArray *jsonFilesForTesting = [dirContents filteredArrayUsingPredicate:fltr];
    for (NSString *fileName in jsonFilesForTesting)
    {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        XCTAssertNotNil([NSDictionary dictionaryWithPlistFile:fileName bundle:bundle]);
        XCTAssertNotNil([NSDictionary dictionaryWithPlistFile:[fileName stringByDeletingPathExtension] bundle:bundle]);
    }
}


- (void)testDictionaryWithJSONFileInvalid
{
    XCTAssertNil([NSDictionary dictionaryWithJSONFile:@"Info.plist" bundle:[NSBundle bundleForClass:self.class]]);
    XCTAssertNil([NSDictionary dictionaryWithJSONFile:@"empty.json" bundle:[NSBundle bundleForClass:self.class]]);
    XCTAssertNil([NSDictionary dictionaryWithJSONFile:@"empty" bundle:[NSBundle bundleForClass:self.class]]);
    XCTAssertNil([NSDictionary dictionaryWithJSONFile:@"image.PNG" bundle:[NSBundle bundleForClass:self.class]]);
    
    // 1st Parameter invalid
    for (NSString *fileName in [NSString testObjectTypeParamsInvalid])
    {
        // 2nd Parameter invalid
        for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
        {
            XCTAssertNil([NSDictionary dictionaryWithJSONFile:fileName bundle:bundle]);
            // Dont want to see "Warning: Null passed to a callee that requires a non-null argument" - this is intended for testing
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
            XCTAssertNil([NSDictionary dictionaryWithJSONFile:(NSString *)nil bundle:bundle]);
#pragma clang diagnostic pop
            
        }
        XCTAssertNil([NSDictionary dictionaryWithJSONFile:fileName bundle:nil]);
    }
    
    // 1st Parameter invalid
    for (NSString *fileName in [NSString testObjectTypeParamsInvalid])
    {
        // 2nd Parameter valid
        for (NSBundle *bundle in [NSBundle testObjectTypeParamsValid])
        {
            XCTAssertNil([NSDictionary dictionaryWithJSONFile:fileName bundle:bundle]);
            
// Dont want to see "Warning: Null passed to a callee that requires a non-null argument" - this is intended for testing
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
            XCTAssertNil([NSDictionary dictionaryWithJSONFile:(NSString *)nil bundle:bundle]);
#pragma clang diagnostic pop
            
        }
        XCTAssertNil([NSDictionary dictionaryWithJSONFile:fileName bundle:nil]);
    }
    
    // 1st Parameter valid
    for (NSString *fileName in [NSString testObjectTypeParamsValid])
    {
        // 2nd Parameter invalid
        for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
        {
            XCTAssertNil([NSDictionary dictionaryWithJSONFile:fileName bundle:bundle]);
        }
        XCTAssertNil([NSDictionary dictionaryWithJSONFile:fileName bundle:nil]);
    }
}

- (void)testDictionaryWithJSONFileValidFormat
{
    NSString *bundleRoot = [[NSBundle bundleForClass:[self class]] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    
    NSString *predicate = [NSString stringWithFormat:@"self BEGINSWITH 'trackings_valid'"];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:predicate];
    NSArray *jsonFilesForTesting = [dirContents filteredArrayUsingPredicate:fltr];
    for (NSString *fileName in jsonFilesForTesting)
    {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        XCTAssertNotNil([NSDictionary dictionaryWithJSONFile:fileName bundle:bundle]);
        XCTAssertNotNil([NSDictionary dictionaryWithJSONFile:[fileName stringByDeletingPathExtension] bundle:bundle]);
    }
}

@end
