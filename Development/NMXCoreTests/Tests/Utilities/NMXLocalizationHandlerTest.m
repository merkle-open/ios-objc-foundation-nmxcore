//
//  NMXLocalizationHandlerTest.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 18.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NMXUtilities.h"
#import "NMXLocalizationHandler+Test.h"
#import "NSBundle+NMXTest.h"
#import "NSString+NMXTest.h"

@interface NMXLocalizationHandlerTest : XCTestCase

@end

@implementation NMXLocalizationHandlerTest

- (void)setUp {
    [super setUp];
    NMXLocalizationHandler *localizationHandler = [NMXLocalizationHandler sharedInstance];
    
    localizationHandler.language = nil;
    localizationHandler.fallbackLanguage = nil;
    localizationHandler.localizationFilePrefix = nil;
    localizationHandler.availableLanguages = [NSBundle bundleForClass:self.class].localizations;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Private Properties
- (void)testBundle
{
    NMXLocalizationHandler *localizationHandler = [NMXLocalizationHandler sharedInstance];
    localizationHandler.bundle = nil;
    XCTAssertTrue(localizationHandler.bundle == [NSBundle mainBundle]); // Default = MainBundle
    
    for (NSBundle *bundle in [NSBundle testObjectTypeParamsValid])
    {
        localizationHandler.bundle = bundle;
        XCTAssertTrue(localizationHandler.bundle == bundle);
    }
    localizationHandler.bundle = [NSBundle bundleForClass:[self class]];
    XCTAssertTrue(localizationHandler.bundle == [NSBundle bundleForClass:[self class]]);
    
    for (NSBundle *bundle in [NSBundle testObjectTypeParamsInvalid])
    {
        localizationHandler.bundle = bundle;
        XCTAssertTrue(localizationHandler.bundle == [NSBundle mainBundle]);
    }
    
    localizationHandler.bundle = nil;
    XCTAssertTrue(localizationHandler.bundle == [NSBundle mainBundle]);
}

#pragma mark - Public Properties
- (void)testAvailableLanguages
{
    NMXLocalizationHandler *localizationHandler = [NMXLocalizationHandler sharedInstance];
    NSMutableArray<NSString *> *languages;
    localizationHandler.bundle = [NSBundle mainBundle];
    NSBundle *bundle = localizationHandler.bundle;
    NSUInteger currentBundlesLocalizationCount = bundle.localizations.count;
    XCTAssertTrue(localizationHandler.availableLanguages.count == currentBundlesLocalizationCount);
    
    // Update languages with own languages (for testing, we just add a new languages
    languages = [[NSMutableArray alloc] initWithArray:localizationHandler.availableLanguages];
    [languages addObject:@"NewLanguagesWhatever"];
    localizationHandler.availableLanguages = languages;
    XCTAssertTrue(localizationHandler.availableLanguages.count == currentBundlesLocalizationCount+1);
    
    // This language setting was once default for iOS and is now optional. Anyway, this is no valid language code, thus we do remove it and the counter should not be increased
    [languages addObject:@"Base"];
    localizationHandler.availableLanguages = languages;
    XCTAssertTrue(localizationHandler.availableLanguages.count == currentBundlesLocalizationCount+1);
    XCTAssertFalse([localizationHandler.availableLanguages containsObject:@"Base"]);
    
    localizationHandler.bundle = [NSBundle bundleForClass:[self class]];
    bundle = localizationHandler.bundle;
    currentBundlesLocalizationCount = bundle.localizations.count;
    XCTAssertTrue(localizationHandler.availableLanguages.count == currentBundlesLocalizationCount);
}

- (void)testFallbackLanguage
{
    NMXLocalizationHandler *localizationHandler = [NMXLocalizationHandler sharedInstance];
    NSString *preferredLanguage = [NSLocale preferredLanguages].firstObject;
    
    // Default Fallback is [NSLocale preferredLanguages].firstObject;
    XCTAssertTrue([localizationHandler.fallbackLanguage isEqualToString:preferredLanguage]);
    
    for (NSString *string in [NSString testObjectTypeParamsInvalid])
    {
        localizationHandler.fallbackLanguage = string;
        XCTAssertTrue([localizationHandler.fallbackLanguage isEqualToString:preferredLanguage]);
    }
    
    localizationHandler.fallbackLanguage = nil;
    XCTAssertTrue([localizationHandler.fallbackLanguage isEqualToString:preferredLanguage]);
    
    for (NSString *string in [NSString testObjectTypeParamsValid])
    {
        localizationHandler.fallbackLanguage = string;
        XCTAssertTrue([localizationHandler.fallbackLanguage isEqualToString:string]);
    }
    
    NSString *fallbackLanguage = @"__abc";
    localizationHandler.availableLanguages = @[];
    localizationHandler.fallbackLanguage = nil; // not set => Fallback will be preferredLanguage
    XCTAssertTrue([localizationHandler.language isEqualToString:preferredLanguage]);
    
    localizationHandler.fallbackLanguage = fallbackLanguage; // not set => Fallback will be preferredLanguage
    XCTAssertTrue([localizationHandler.language isEqualToString:fallbackLanguage]);
    
    localizationHandler.fallbackLanguage = nil; // not set => Fallback will be preferredLanguage
    XCTAssertTrue([localizationHandler.language isEqualToString:preferredLanguage]);
}

- (void)testLanguage
{
    NMXLocalizationHandler *localizationHandler = [NMXLocalizationHandler sharedInstance];
    NSMutableArray<NSString *> *languages;
    NSString *preferredLanguage = localizationHandler.fallbackLanguage;
    
    // new available Languages dont have current default Language anymore, the new default language should be in the provided array!
    NSString *currentLanguage = localizationHandler.language;
    languages = [[NSMutableArray alloc] initWithArray:localizationHandler.availableLanguages];
    [languages addObject:[preferredLanguage stringByAppendingString:@"-whatever"]]; // just make sure we got at least one string with same prefix in there!
    [languages removeObject:currentLanguage];
    localizationHandler.availableLanguages = languages;
    XCTAssertTrue([localizationHandler.language hasPrefix:preferredLanguage]);
    
    // array with values, that do not fit to our preferredLanguage!
    languages = [NSMutableArray arrayWithObject:@"__SomeStrangeIdentifier"];
    localizationHandler.availableLanguages = languages;
    // If we didnt find a match, return preferredLanguage, as "fallbackLanguage" was not set
    XCTAssertTrue([localizationHandler.language isEqualToString:preferredLanguage]);
}

#pragma mark - Private Constructors
- (void)testSharedInstance
{
    NMXLocalizationHandler *localizationHandler = [NMXLocalizationHandler sharedInstance];
    XCTAssertNotNil(localizationHandler);
    localizationHandler.localizationFilePrefix = nil;
    XCTAssertTrue([localizationHandler.localizationFilePrefix isEqualToString:@"default_"]);
}

#pragma mark - Public Constructors
- (void)testInitWithLocalizationFilePrefix
{
    NMXLocalizationHandler *localizationHandler;
    localizationHandler = [[NMXLocalizationHandler alloc] initWithLocalizationFilePrefix:nil];
    XCTAssertTrue([localizationHandler.localizationFilePrefix isEqualToString:@"default_"]);
    for (NSString *string in [NSString testObjectTypeParamsInvalid])
    {
        localizationHandler = [[NMXLocalizationHandler alloc] initWithLocalizationFilePrefix:string];
        XCTAssertTrue([localizationHandler.localizationFilePrefix isEqualToString:@"default_"]);
    }
    
    XCTAssertTrue(![localizationHandler.localizationFilePrefix isEqualToString:@"New Prefix"]);
    
    localizationHandler = [[NMXLocalizationHandler alloc] initWithLocalizationFilePrefix:@"New Prefix"];
    XCTAssertTrue([localizationHandler.localizationFilePrefix isEqualToString:@"New Prefix"]);
    
    localizationHandler = [[NMXLocalizationHandler alloc] initWithLocalizationFilePrefix:@"default_"];
    XCTAssertTrue([localizationHandler.localizationFilePrefix isEqualToString:@"default_"]);
    
    localizationHandler = [[NMXLocalizationHandler alloc] initWithLocalizationFilePrefix:@"OtherPrefix"];
    XCTAssertTrue([localizationHandler.localizationFilePrefix isEqualToString:@"OtherPrefix"]);
}

#pragma mark - Static Public Functions


#pragma mark - Static Private Functions


#pragma mark - Public Functions


#pragma mark - Private Functions
- (void)testBestMatchingLanguage {
    NMXLocalizationHandler *localizationHandler = [NMXLocalizationHandler sharedInstance];
    
    // Main Bundle does not have Localizations here (Library build) - by default, it is main bundle
    XCTAssertTrue([[NSBundle mainBundle] localizations].count == 0);
    
    // Thus we will switch to our test bundle ;-)
    localizationHandler.bundle = [NSBundle bundleForClass:[self class]];
    
    /*
     *  Available Languages in the test are the following
     *  de
     *  en-ER
     *  en-GB
     *  en
     *  es-MX
     *  fr
     *
     *  If you want to provide additional ones, head to the project settings -> project target -> Info -> Localizations
     */
    XCTAssertTrue([[localizationHandler bestMatchingLanguage:@"en"] isEqualToString:@"en"]);
    XCTAssertTrue([[localizationHandler bestMatchingLanguage:@"en-GB"] isEqualToString:@"en-GB"]);
    XCTAssertTrue([[localizationHandler bestMatchingLanguage:@"es"] isEqualToString:@"es-MX"]);
    XCTAssertNil([localizationHandler bestMatchingLanguage:@"pl"]);
    XCTAssertTrue([[localizationHandler bestMatchingLanguage:@"en-ER"] isEqualToString:@"en-ER"]);
    
    for (NSString *string in [NSString testObjectTypeParamsInvalid])
    {
        XCTAssertNil([localizationHandler bestMatchingLanguage:string]);
    }
    XCTAssertNil([localizationHandler bestMatchingLanguage:nil]);
}

@end
