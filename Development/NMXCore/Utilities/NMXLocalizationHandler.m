//
//  NMXLocalizationHandler.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 18.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NMXLocalizationHandler.h"
#import "NSDictionary+NMX.h"

static id instance;
NSString * const _Nonnull NMXDefaultLocalizationFilePrefix = @"default_";

@interface NMXLocalizationHandler()
@property (nonatomic) NSBundle * _Nullable bundle; // Don't see a reason to change this bundle yet, but maybe in the future. - Private Property requires being public in tests: NMXLocalizationHandlerTest,  if null, default is MainBundle
@property (nonatomic) NSString *lastLocalizedPlistFilename; // used to not load all the time a plist, in case the former plist was just the same
@property (nonatomic) NSDictionary<NSString *, NSString *> *lastLocalizedPlist; // used to not load all the time a plist, in case the former plist was just the same
@end

@implementation NMXLocalizationHandler
@synthesize bundle = _bundle;
@synthesize availableLanguages = _availableLanguages;
@synthesize language = _language;
@synthesize fallbackLanguage = _fallbackLanguage;
@synthesize localizationFilePrefix = _localizationFilePrefix;

#pragma mark - Private Getter & Setter
- (void)setBundle:(NSBundle *)bundle
{
    if (bundle && ![bundle isKindOfClass:[NSBundle class]])
    {
        bundle = nil; // invalid input
    }
    _bundle = bundle;
    _availableLanguages = nil; // if bundle changes, we need to make sure, we will reload the related bundle's languages
}

- (NSBundle *)bundle
{
    if (!_bundle)
    {
        _bundle = [NSBundle mainBundle];
    }
    return _bundle;
}

#pragma mark - Public Getter & Setter
- (NSArray<NSString *> *)availableLanguages
{
    // Have to remove the "Base" Language code from Apple, for whatever reason they added this language...
    if (!_availableLanguages)
    {
        NSMutableArray<NSString *> *localizations = [[NSMutableArray alloc] initWithArray:self.bundle.localizations];
        _availableLanguages = localizations;
    }
    
    // for some reason there is the language code "Base" in old xCode Versions included... we don't need this - removed in newer xCode versions
    NSString *baseString = @"Base";
    if ([_availableLanguages containsObject:baseString])
    {
        NSMutableArray<NSString *> *localizations = [[NSMutableArray alloc] initWithArray:_availableLanguages];
        [localizations removeObject:baseString];
        _availableLanguages = localizations;
    }
    
    return _availableLanguages;
}

- (void)setAvailableLanguages:(NSArray<NSString *> *)availableLanguages
{
    if (availableLanguages && [availableLanguages isKindOfClass:[NSArray<NSString *> class]])
    {
        _availableLanguages = availableLanguages;
        
        // Update the default language, in case the default language was not in the available Languages any longer
        self.language = self.language;
    }
}

- (NSString *)fallbackLanguage
{
    if (!_fallbackLanguage)
    {
        _fallbackLanguage = [NSLocale preferredLanguages].firstObject;
    }
    return _fallbackLanguage;
}

- (void)setFallbackLanguage:(NSString *)fallbackLanguage
{
    // object is neither of type NSString or nil
    if (fallbackLanguage && ![fallbackLanguage isKindOfClass:[NSString class]])
    {
        fallbackLanguage = nil;
    }
    
    // value changed, update current default language
    if (!fallbackLanguage || ![_fallbackLanguage isEqualToString:fallbackLanguage])
    {
        _fallbackLanguage = fallbackLanguage;
        self.language = self.language;
    }    
}

- (NSString *)language
{
    // there is no default language selected yet, retrieve it from apps' settings and users' locales
    NSString *language = _language;
    if (!language || ![language isKindOfClass:[NSString class]])
    {
        language = self.fallbackLanguage;
        _language = language;
    }
    return _language;
}

- (void)setLanguage:(NSString *)language
{
    NSString *newValidLanguage = [self bestMatchingLanguage:language];
    if (!newValidLanguage)
    {
        newValidLanguage = self.fallbackLanguage;
    }
    _language = newValidLanguage;
}

- (NSString *)localizationFilePrefix
{
    return _localizationFilePrefix;
}

- (void)setLocalizationFilePrefix:(NSString *)localizationFilePrefix
{
    if (!localizationFilePrefix || ![localizationFilePrefix isKindOfClass:[NSString class]])
    {
        localizationFilePrefix = NMXDefaultLocalizationFilePrefix;
    }
    _localizationFilePrefix = localizationFilePrefix;
}

#pragma mark - Public Constructors

- (instancetype)initWithLocalizationFilePrefix:(NSString *)localizationFilePrefix
{
    if (self = [super init])
    {
        if (localizationFilePrefix && [localizationFilePrefix isKindOfClass:[NSString class]])
        {
            self.localizationFilePrefix = localizationFilePrefix;
        }
        else
        {
            self.localizationFilePrefix = NMXDefaultLocalizationFilePrefix;
        }
        instance = self;
    }
    return self;
}

#pragma mark - Private Constructors

- (instancetype)init
{
    return [self initWithLocalizationFilePrefix:NMXDefaultLocalizationFilePrefix];
}

#pragma mark - Public static methods

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (NSDictionary<NSString *, NSString *> * _Nullable)localizedLabelsFromBundleFile
{
    NSString *filePrefix = [NMXLocalizationHandler sharedInstance].localizationFilePrefix;
    NSString *fileLanguage = [NMXLocalizationHandler sharedInstance].language;
    NSBundle *bundle = [NMXLocalizationHandler sharedInstance].bundle;
    NSString *localizationFilename = [NSString stringWithFormat:@"%@%@.plist",filePrefix,fileLanguage];
    
    NSString *lastLocalizationFilename = [NMXLocalizationHandler sharedInstance].lastLocalizedPlistFilename;
    
    // Last language file differed from the new filename, so fetch a new language plist
    if (![localizationFilename isEqualToString:lastLocalizationFilename])
    {
        NSDictionary *localizationDictionary = [NSDictionary dictionaryWithPlistFile:localizationFilename bundle:bundle];
        [NMXLocalizationHandler sharedInstance].lastLocalizedPlist = localizationDictionary;
        [NMXLocalizationHandler sharedInstance].lastLocalizedPlistFilename = localizationFilename;
    }
    NSDictionary *localizationDictionary = [NMXLocalizationHandler sharedInstance].lastLocalizedPlist;
    return localizationDictionary;
}

+ (void)setupLocalizationWithFilePrefix:(NSString * _Nullable)filePrefix availableLanguages:(NSArray * _Nullable)availableLanguages preferredLanguage:(NSString * _Nullable)language
{
    NMXLocalizationHandler *localizationHandler = [NMXLocalizationHandler sharedInstance];
    localizationHandler.localizationFilePrefix = filePrefix;
    localizationHandler.availableLanguages = availableLanguages;
    localizationHandler.language = language;
}

#pragma mark - Public methods
- (NSString * _Nullable )bestMatchingLanguage:(NSString * _Nullable )desiredLanguage
{
    if (!desiredLanguage || ![desiredLanguage isKindOfClass:[NSString class]])
    {
        return nil;
    }
    
    NSArray<NSString *> *availableLanguages = self.availableLanguages;
    
    // if the desired language of a user is supported by the app, return it
    if ([availableLanguages containsObject:desiredLanguage])
    {
        return desiredLanguage;
    }
    
    // The exact same language code was not found, maybe there is one with same language from different country provided.
    // (e.g. en_GB not found, but en_US available)
    // Because some codes do not have a "_" - use substringToIndex 2
    if (desiredLanguage.length >= 2)
    {
        NSString *bestLanguageCode = [desiredLanguage substringToIndex:2];
        for (NSString *availableLanguage in availableLanguages)
        {
            if ([availableLanguage hasPrefix:bestLanguageCode])
            {
                return availableLanguage;
            }
        }
    }
    
    // None of the available Languages maps to the desiredLanguage, thus we will return nil
    // could also map the bestMatch to the preferredLocaliation now... ?
    // Whatever is used as fallback: the library embedding applicaiton has to decide.
    
    return nil;
}

#pragma mark - private functions

@end
