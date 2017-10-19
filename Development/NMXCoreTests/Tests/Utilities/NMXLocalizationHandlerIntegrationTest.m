//
//  NMXLocalizationHandlerIntegrationTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 21.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NMXUtilities.h"
#import "NMXLocalizationHandler+Test.h"
#import "NSDictionary+NMX.h"

@interface NMXLocalizationHandlerIntegrationTest : XCTestCase
@property (nonatomic) NSString *languageKey;
@property (nonatomic) NSDictionary<NSString *, NSArray *> *filePrefixes;
@property (nonatomic) NSArray<NSArray<NSString *> *> *tests;
@end

@implementation NMXLocalizationHandlerIntegrationTest

- (void)setUp
{
    [super setUp];
    NMXLocalizationHandler *localizationHandler = [NMXLocalizationHandler sharedInstance];
    
    // Call this here, because it is pretty hard to have the language being nil - for singleton instance, this only happens at the very beginning!
    XCTAssertTrue([localizationHandler.language isEqualToString:localizationHandler.fallbackLanguage]);
    
    
    self.languageKey = @"language";
    self.filePrefixes = @{
                          @"default_":@[@"en", @"de"],
                          @"default-2_":@[@"en", @"de", @"en-GB", @"fr"],
                          };
    self.tests = @[
                   @[@"en",      @"default_",         @"en"],
                   @[@"de",      @"default-2_",       @"de"],
                   @[@"en-GB",   @"default_",         @"en"],
                   @[@"en",      @"default-2_",       @"en"],
                   @[@"de",      @"default_",         @"de"],
                   @[@"en-GB",   @"default-2_",       @"en-GB"],
                   @[@"fr",      @"default-2_",       @"fr"],
                   @[@"fr",      @"default-2_",       @"fr"],
                   @[@"zh",      @"default-2_",       @"en"],
                   ];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCorrectRetrievalOfLocalizationDict
{
    [NMXLocalizationHandler sharedInstance].bundle = [NSBundle bundleForClass:[self class]];
    [NMXLocalizationHandler sharedInstance].fallbackLanguage = @"en";
    NSBundle *bundle = [NMXLocalizationHandler sharedInstance].bundle;
    for (NSArray *test in self.tests)
    {
        // Sequence is important! First set availableLanguages, THEN change the default Language.
        NSArray *availableLanguages = self.filePrefixes[test[1]];
        [NMXLocalizationHandler sharedInstance].availableLanguages = availableLanguages;
        
        NSString *language = test[0];
        [NMXLocalizationHandler sharedInstance].language = language;
        
        NSString *filename = [test[1] stringByAppendingString:test[2]];
        [NMXLocalizationHandler sharedInstance].localizationFilePrefix = test[1];
        
        NSDictionary *localizationDict = [NMXLocalizationHandler localizedLabelsFromBundleFile];
        
        NSString *dictPath = [bundle pathForResource:filename ofType:@"plist"];
        NSDictionary *comparisonDict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
        XCTAssertTrue([comparisonDict isEqualToDictionary:localizationDict]);
        XCTAssertTrue([test[2] isEqualToString:[NMXLocalizationHandler sharedInstance].language]);
    }
}

- (void)testSetupLocalizationWithFilePrefixAndPreferredLanguage
{
    // setup
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *fallbackLanguage = @"en";
    NSString *filePrefix = @"default-2_";
    NSString *language = @"fr";
    NSArray *availableLanguages = @[@"en", @"de", @"en-GB", @"fr"];
    [NMXLocalizationHandler sharedInstance].bundle = bundle;
    
    [NMXLocalizationHandler sharedInstance].localizationFilePrefix = filePrefix;
    [NMXLocalizationHandler sharedInstance].availableLanguages = availableLanguages;
    [NMXLocalizationHandler sharedInstance].fallbackLanguage = fallbackLanguage;
    [NMXLocalizationHandler sharedInstance].language = language;
    
    NSDictionary *localizationDict = [NMXLocalizationHandler localizedLabelsFromBundleFile];
    NSString *filename = [filePrefix stringByAppendingString:language];
    NSDictionary *comparisonDict = [NSDictionary dictionaryWithPlistFile:filename bundle:bundle];
    XCTAssertTrue([comparisonDict isEqualToDictionary:localizationDict]);
    XCTAssertTrue([language isEqualToString:[NMXLocalizationHandler sharedInstance].language]);
    
    NSString *newFilePrefix = @"default_";
    NSString *newExpectedLanguage = @"en";
    NSArray *newAvailableLanguages = @[@"en", @"de"];
    [NMXLocalizationHandler setupLocalizationWithFilePrefix:newFilePrefix availableLanguages:newAvailableLanguages preferredLanguage:newExpectedLanguage];
    localizationDict = [NMXLocalizationHandler localizedLabelsFromBundleFile];
    filename = [newFilePrefix stringByAppendingString:newExpectedLanguage];
    comparisonDict = [NSDictionary dictionaryWithPlistFile:filename bundle:bundle];
    XCTAssertTrue([comparisonDict isEqualToDictionary:localizationDict]);
    XCTAssertTrue([newExpectedLanguage isEqualToString:[NMXLocalizationHandler sharedInstance].language]);
    
    [NMXLocalizationHandler setupLocalizationWithFilePrefix:newFilePrefix availableLanguages:newAvailableLanguages preferredLanguage:@"de"];
    localizationDict = [NMXLocalizationHandler localizedLabelsFromBundleFile];
    filename = [newFilePrefix stringByAppendingString:@"de"];
    comparisonDict = [NSDictionary dictionaryWithPlistFile:filename bundle:bundle];
    XCTAssertTrue([comparisonDict isEqualToDictionary:localizationDict]);
    XCTAssertTrue([@"de" isEqualToString:[NMXLocalizationHandler sharedInstance].language]);
    
    
//    [NMXLocalizationHandler setupLocalizationWithFilePrefix:<#(NSString *)#> preferredLanguage:<#(NSString *)#>];
//    
//    
//    
//    [NMXLocalizationHandler sharedInstance].bundle = [NSBundle bundleForClass:[self class]];
//    [NMXLocalizationHandler sharedInstance].fallbackLanguage = @"en";
//    NSBundle *bundle = [NMXLocalizationHandler sharedInstance].bundle;
//    for (NSArray *test in self.tests)
//    {
//        // Sequence is important! First set availableLanguages, THEN change the default Language.
//        NSArray *availableLanguages = self.filePrexises[test[1]];
//        [NMXLocalizationHandler sharedInstance].availableLanguages = availableLanguages;
//        
//        NSString *language = test[0];
//        [NMXLocalizationHandler sharedInstance].language = language;
//        
//        NSString *filename = [test[1] stringByAppendingString:test[2]];
//        [NMXLocalizationHandler sharedInstance].localizationFilePrefix = test[1];
//        
//        NSDictionary *localizationDict = [NMXLocalizationHandler localizedLabelsFromBundleFile];
//        
//        NSString *dictPath = [bundle pathForResource:filename ofType:@"plist"];
//        NSDictionary *comparisonDict = [NSDictionary dictionaryWithContentsOfFile:dictPath];
//        XCTAssertTrue([comparisonDict isEqualToDictionary:localizationDict]);
//        XCTAssertTrue([test[2] isEqualToString:[NMXLocalizationHandler sharedInstance].language]);
//    }
}

@end
