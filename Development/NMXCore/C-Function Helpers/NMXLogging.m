//
//  NMXLogging.m
//  ios-objc-foundation-nmxcore
//
//  Created by Tobias Baube on 16.10.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import "NMXLogging.h"

NSString* const NMXLogLevelTypeDescription[] =
{
    [none] = @"",
    [debug] = @"[DEBUG] - ",
    [release] = @"[RELEASE] - ",
    [all] = @"[DEBUG/RELEASE] - ",
};

// regex for all string escapes in c
// https://stackoverflow.com/questions/11875331/how-to-check-if-nsstring-format-contains-the-same-number-of-specifiers-as-there
static NSString *const kStringFromatSpecifiers =
@"%(?:\\d+\\$)?[+-]?(?:[lh]{0,2})(?:[qLztj])?(?:[ 0]|'.{1})?\\d*(?:\\.\\d+)?[@dDiuUxXoOfeEgGcCsSpaAFn]";

void NMXLogWithPrefixAndArguments(NMXLogLevelType logLevel, NSString* _Nullable logPrefix, __strong NSString* _Nonnull format, va_list _Nullable arguments)
{
    // Evaluate input parameters
    if (format != nil && [format isKindOfClass:[NSString class]])
    {
        // NSInteger is int on 32-bit devices, and long on 64-bit devices
        // => As our enum is defined the same way, we are safe this way, even if someone inputs invalid stuff
        NSInteger _logLevel = logLevel;
        int logLevelCount = (sizeof NMXLogLevelTypeDescription) / (sizeof NMXLogLevelTypeDescription[0]);
        if (_logLevel > logLevelCount || _logLevel < 0)
        {
            _logLevel = none;
        }
        
        NSString *_logPrefix = logPrefix;
        if (!_logPrefix || ![_logPrefix isKindOfClass:[NSString class]])
        {
            _logPrefix = NMXLogLevelTypeDescription[_logLevel];
        }
        
        // Get a reference to the arguments that follow the format parameter
        va_list argList;
        va_copy(argList, arguments);
        
        int argCount = 0;
        while (va_arg(argList, NSObject *))
        {
            argCount += 1;
        }
        va_end(argList);
        NSRegularExpression *regEx = [NSRegularExpression regularExpressionWithPattern:kStringFromatSpecifiers options:0 error:nil];
        NSInteger numSpecifiers = [regEx numberOfMatchesInString:format options:0 range:NSMakeRange(0, format.length)];
        
        NSMutableString *s;
        if (numSpecifiers > argCount)
        {
            // Perform format string argument substitution, reinstate %% escapes, then print
            //s = [[NSMutableString alloc] initWithFormat:@"Error occured when logging: amount of arguments does not for to the defined format. Callstack:\n%@\n", [NSThread callStackSymbols]];
            //printf("%s\n", [s UTF8String]);
            s = [[NSMutableString alloc] initWithString:format];
        }
        else
        {
            // Perform format string argument substitution, reinstate %% escapes, then print
            va_copy(argList, arguments);
            
            s = [[NSMutableString alloc] initWithFormat:format arguments:argList];
            //printf("%s\n", [s UTF8String]);
            va_end(argList);
        }
        
        [s insertString:_logPrefix atIndex:0];

        // If we got a static library, we will know the current preprocessor vars.
        // If we deployed it as Dynamic Framework, we will always have release => The Wrapper Function would have to handle this
        #ifdef NMXCoreStatic
            #ifdef DEBUG
                if (   _logLevel == none
                    || _logLevel == debug)
                {
                    NSLog(@"%@",s);
                }
        
            // Too bad this destroys our nice test coverage percentage, as this is not defined for testing target :-(
            #elif RELEASE
                if (   _logLevel == release)
                {
                    NSLog(@"%@",s);
                }
            #endif
        
            if (_logLevel == all)
            {
                NSLog(@"%@",s);
            }
        #else
            NSLog(@"%@",s);
        #endif
    }
}

__attribute__((overloadable)) void NMXLog(NSString* _Nonnull format, ...)
{
    va_list argList;
    va_start(argList, format);
    NMXLogWithPrefixAndArguments(none, nil, format, argList);
    va_end(argList);
    NSString *obj = nil;
    NMXLogWithPrefixAndArguments(none, nil, obj, nil);
}

__attribute__((overloadable)) void NMXLog(NMXLogLevelType logLevel, NSString* _Nonnull format, ...)
{
    va_list argList;
    va_start(argList, format);
    NMXLogWithPrefixAndArguments(logLevel, nil, format, argList);
    va_end(argList);
    NSString *obj = nil;
    NMXLogWithPrefixAndArguments(none, nil, obj, nil);
}

void NMXLogWithPrefix(NMXLogLevelType logLevel, NSString* _Nullable logPrefix, NSString* _Nonnull format, ...)
{
    va_list argList;
    va_start(argList, format);
    NMXLogWithPrefixAndArguments(logLevel, logPrefix, format, argList);
    va_end(argList);
    NSString *obj = nil;
    NMXLogWithPrefixAndArguments(none, nil, obj, nil);
}
