//
//  NMXLocalizationHandler.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 18.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMXLocalizationHandler : NSObject

/**
 *  By default all available languages of the project are being used as available language for localization options. (Project Settings -> Project -> Info -> Localizations)
 *
 *  Nevertheless, it might occur that the languages change, due to config files or something (during runtime). If so, you can use this property to change the amount of available languages. Please update the localization afterwards, to ensure no deprecated language is displayed to the user.
 *
 *  if you set the availabeLanguages, the current language will be updated. In case it was no longer in the provided availableLanguages array, it will be changed to a new best fitting value!
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 */
@property (strong, nonatomic, null_resettable) NSArray<NSString *> *availableLanguages;

/**
 *  set this value, in case you don't want the user's preferred Languages to be fallback, if the desiredLanguage is NOT provided in the availabe language file. If this property is set to "nil", the default fallback will be a user's preferred Language Setting `[NSLocale preferredLanguages].firstObject`. If you want to force the LocalizationHandler to provide one of YOUR languages, set this value.
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 */
@property (strong, nonatomic, null_resettable) NSString *fallbackLanguage;

/**
 *  User's default selected language (and dialect), if you set this property, it will be matched with availableLanguages. If language was NOT included in availableLanguages, the language will be the fallbackLanguage!
 *
 *  Please make sure that you added several Languages to your xCode's project settings! Herefore
 *
 *  `select xCode project --> Info --> Localizations --> Add Languages`
 *
 *  In case you require a custom list of languages, because they are loaded dynamically into the application from a server, set availableLanguages to the specific array.
 *
 *  Array of all possibly preferred Languages: ["en", "fr", "de", "zh-Hans", "zh-Hant", "ja", "nl", "it", "es", "es-MX", "ko", "pt", "pt-PT", "da", "fi", "nb", "sv", "ru", "pl", "tr", "uk", "ar", "hr", "cs", "el", "he", "ro", "sk", "th", "id", "ms", "en-GB", "en-AU", "ca", "hu", "vi", "hi"]
 *
 *  Apple documentation: Internationalizing the User Interface https://developer.apple.com/library/ios/documentation/MacOSX/Conceptual/BPInternational/InternationalizingYourUserInterface/InternationalizingYourUserInterface.html
 *
 *  List of all language codes http://quivi.sourceforge.net/languagecodes.html
 *
 *  The value is NOT stored somewhere. In case you want to persist it throughout multiple runtimes of your app, make sure to store it somewhere and then SET this property on app start
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 */
@property (strong, nonatomic, null_resettable) NSString *language;

/**
 *  We expect all localization files having the same prefix. You can set this prefix to your specific needs. By default it is: NMXDefaultLocalizationFilePrefix = @"default_";
 *
 *  Different Localization files could look the following:
 *  * default_en.plist
 *  * default_en-GB.plist
 *  * default_de.plist
 *  
 *  After setting this property, make sure to update your current localization
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 */
@property (strong, nonatomic, null_resettable) NSString *localizationFilePrefix;

/**
 *  returns an instance of NMXLocalizationHandler with a specified localizationFilePrefix;
 *
 *  In case there was already an instance (as NMXLocaliationHandler implements the Singleton-Pattern), the existing instance will be used and its localizationFilePrefix updated.
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @param localizationFilePrefix defines the prefix for localized files. E.g. "language_" for "language_en.plist". If `localizationFilePrefix` was "nil", the default prefix is used: NMXDefaultLocalizationFilePrefix = @"default_";
 *  @return After setting this property, make sure to update your current localization
 */
- (instancetype _Nonnull)initWithLocalizationFilePrefix:(NSString * _Nullable)localizationFilePrefix;

/**
 *  - Attention
 *  init not available, use [NMXLocalizationHandler sharedInstance] or [[NMXLOcalizationHandler alloc] initWithLocalizationFilePrefix] instead
 */
- (instancetype _Nonnull)init __attribute__((unavailable("init not available, use [NMXLocalizationHandler sharedInstance] or [[NMXLOcalizationHandler alloc] initWithLocalizationFilePrefix] instead")));

/**
 *  - Attention
 *  new not available not available, use [NMXLocalizationHandler sharedInstance] instead
 */
+ (instancetype _Nonnull)new __attribute__((unavailable("new not available not available, use [NMXLocalizationHandler sharedInstance] instead")));

/**
 *  returns a shared instance of NMXLocalizationHandler
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @return shared NMXLocalizationHandler
 */
+ (instancetype _Nonnull)sharedInstance;

/**
 *  returns a dictionary with localized keys and the mapped localized value for the current language
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @return returns a dictionary with localized keys and the mapped localized value for the current language
 */
+ (NSDictionary<NSString *, NSString *> * _Nullable)localizedLabelsFromBundleFile;

/**
 *  The functions maps the given input to the available Localizations based on the current bundle (readonly and by default NSBundle.mainBundle).
 *
 *  Will return null, if the array "self.bundle.localizations" is empty - to extend these localizations, go to your project settings -> Project -> Info -> Localizations
 *
 *  Will return null, if the desired language was not mapped to available languages
 *
 *  In case the Language AND Dialect do not fit to a specific Localization (e.g. en-GB is not en-US), the function maps en-GB to en-US, as only the language ("en") (not the dialect "GB" vs. "US") will be considered in that case.
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @return NSString that maps to the best Locale from the Main Bundle. In case the Language AND Dialect do not fit to a specific Localization (e.g. en-GB is not en-US), the function maps en-GB to en-US, as only the language (not the dialect) will be considered in that case.
 *
 *  @param desiredLanguage is a Language code (optionally with Dialect suffix) in the format of the following language code list http://quivi.sourceforge.net/languagecodes.html
 */
- (NSString * _Nullable )bestMatchingLanguage:(NSString * _Nullable )desiredLanguage;

/**
 *  This function shall be used to setup/reset the entire NMXLocalizationHandler instance. You can set all required properties in one and don't have to set each property on its own.
 *
 *  - Author: Tobias Baube
 *
 *  - Version: 1.0
 *
 *  @param filePrefix nullable, we expect localization files having a file prefix. If you got none, set this parameter to an empty string "". Providing nil will reset the filePrefix to its default: NMXDefaultLocalizationFilePrefix = @"default_";
 *  @param availableLanguages nullable, List of languages, one does want to support
 *  @param language nullable, you can set the default language, which shall be used when there was no match with avilable Languages and a new desired Languages. Make sure it is included in the availableLanguages Array. If it is not included OR set to nil, your language setting will have no effect, so it will be reset to the returning value of NMXLocalizationHandler.bestMatchingLanguage:
 */
+ (void)setupLocalizationWithFilePrefix:(NSString * _Nullable)filePrefix availableLanguages:(NSArray * _Nullable)availableLanguages preferredLanguage:(NSString * _Nullable)language;

@end
