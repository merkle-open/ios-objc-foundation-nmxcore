//
//  NMXLocalizationHandler+Test.h
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 18.04.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NMXLocalizationHandler.h"

@interface NMXLocalizationHandler (Test)
@property (nonatomic) NSBundle * _Nullable bundle; // if null, default is MainBundle

- (NSString * _Nullable)bestMatchingLanguage:(NSString * _Nullable )desiredLanguage;
@end
