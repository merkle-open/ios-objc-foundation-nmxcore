//
//  NMXLoggingTest.m
//  ios-objc-foundation-nmxcore Tests
//
//  Created by Tobias Baube on 16.10.17.
//  Copyright © 2017 Namics AG. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+NMXTest.h"
#import "NSNumber+NMXTest.h"
#import "NMXLogging.h"

@interface NMXLoggingTest : XCTestCase
@end

@implementation NMXLoggingTest

static int stderrSave;
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSLog(@"Logs go to %@",[self logFilePath]);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSString *)logFilePath
{
    NSArray *allPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [allPaths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"FWTestLog.txt"];
}

- (void)startLogging
{
    stderrSave = dup(STDERR_FILENO);
    freopen([[self logFilePath] cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}

- (void)closeLogging
{
    fflush(stderr);
    dup2(stderrSave,STDERR_FILENO);
    close(stderrSave);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:[self logFilePath] error:&error];
}


- (BOOL)recordLogLogged:(NSString *)string
{
    NSString* content = [NSString stringWithContentsOfFile:[self logFilePath]
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    return [content hasSuffix:[string stringByAppendingString:@"\n"]];
}

- (void)testNMXLogFormat_Valid
{
    XCTAssertNoThrow(NMXLog(nil));
    XCTAssertNoThrow(NMXLog(@"Test test test %@ --- %@",nil,nil));
    XCTAssertNoThrow(NMXLog(@"Test test test %@ --- %@",@"Argument1", @"Argument2"));
    XCTAssertNoThrow(NMXLog(@"Test test test %@ --- %@",@"Argument1", @"Argument2", @"Argument not listed"));
    XCTAssertNoThrow(NMXLog(@"Test test test %f --- %@",@(YES),@"Valid"));
    XCTAssertNoThrow(NMXLog(@"Test test test %d --- %@",YES,@"Valid"));
    XCTAssertNoThrow(NMXLog((NSString *)[NSData new]));
    XCTAssertNoThrow(NMXLog(@""));
    XCTAssertNoThrow(NMXLog(@"",@""));
    XCTAssertNoThrow(NMXLog(@"Simple string output"));
    XCTAssertNoThrow(NMXLog(@"2 Placeholders. 0 Vars %@ --- %@"));
    XCTAssertNoThrow(NMXLog(@"", (NSString *)[NSData new]));
}
    
- (void)testNMXLogLogLevelFormat_invalid {
    NSString *inputString = @"Test";
    NSString *expectedString = @"Test";
    NSString *outputString = @"";
    
    for (NSNumber *obj in [NSNumber testObjectTypeParamsInvalid])
    {
        [self startLogging];
        NMXLog((NSInteger)obj, inputString);
        BOOL isRecorded = [self recordLogLogged:expectedString];
        [self closeLogging];
        XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    }
    NSObject *obj = nil;
    [self startLogging];
    NMXLog((NSInteger)obj, inputString);
    BOOL isRecorded = [self recordLogLogged:expectedString];
    [self closeLogging];
    XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);

    for (NSString *obj in [NSString testObjectTypeParamsInvalid])
    {
        [self startLogging];
        NMXLog((NSInteger)obj, inputString);
        BOOL isRecorded = [self recordLogLogged:expectedString];
        [self closeLogging];
        XCTAssertTrue(isRecorded, @"🔴🔴 We want to log any kind of object, still we expect a string format input: %@",obj);
    }
    NSString *nullString = nil;
    [self startLogging];
    NMXLog(debug, nullString);
    isRecorded = [self recordLogLogged:expectedString];
    [self closeLogging];
    XCTAssertFalse(isRecorded, @"🔴🔴 We want to log any kind of object, still we expect a string format input: %@",nullString);
}
    
- (void)testNMXLogLogLevelLogPrefixFormat_invalid {
    NSString *inputString = @"Test";
    NSString *expectedString = @"Test";
    NSString *outputString = @"";
    BOOL isRecorded = NO;

    for (NSNumber *obj in [NSNumber testObjectTypeParamsInvalid])
    {
        [self startLogging];
        NMXLogWithPrefix((NSInteger)obj, nil, inputString);
        isRecorded = [self recordLogLogged:expectedString];
        [self closeLogging];
        XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    }
    NSObject *obj = nil;
    [self startLogging];
    NMXLogWithPrefix((NSInteger)obj, nil, inputString);
    isRecorded = [self recordLogLogged:expectedString];
    [self closeLogging];
    XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);

    [self startLogging];
    NMXLogWithPrefix((NSInteger)17, nil, inputString);
    isRecorded = [self recordLogLogged:expectedString];
    [self closeLogging];
    XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);

    [self startLogging];
    NMXLogWithPrefix((NSInteger)-12, nil, inputString);
    isRecorded = [self recordLogLogged:expectedString];
    [self closeLogging];
    XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);

    expectedString = [NSString stringWithFormat:@"%@%@",NMXLogLevelTypeDescription[debug], inputString];
    for (NSString *obj in [NSString testObjectTypeParamsInvalid])
    {
        [self startLogging];
        NMXLogWithPrefix(debug, obj, inputString);
        isRecorded = [self recordLogLogged:expectedString];
        [self closeLogging];
        XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    }
    [self startLogging];
    NMXLogWithPrefix(debug, nil, inputString);
    isRecorded = [self recordLogLogged:expectedString];
    [self closeLogging];
    XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);

    for (NSString *obj in [NSString testObjectTypeParamsInvalid])
    {
        [self startLogging];
        NMXLogWithPrefix(debug, nil, obj);
        isRecorded = [self recordLogLogged:expectedString];
        [self closeLogging];
        XCTAssertFalse(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    }
    NSString *nullString = nil;
    [self startLogging];
    NMXLogWithPrefix(debug, nil, nullString);
    isRecorded = [self recordLogLogged:expectedString];
    [self closeLogging];
    XCTAssertFalse(isRecorded, @"🔴🔴 We want to log any kind of object, still we expect a string format input: %@",obj);
}

- (void)testNMXLogLogLevelLogPrefixFormat_valid
{
    NSString *inputString = @"Test";
    NSString *expectedString = @"Test";
    NSString *outputString = @"";
    BOOL isRecorded = NO;

    int validLevels[3] = {none,debug,all,};
    for (int i = 0; i < sizeof(validLevels)/sizeof(validLevels[0]); i++)
    {
        NMXLogLevelType level = validLevels[i];
        expectedString = [NSString stringWithFormat:@"%@%@",NMXLogLevelTypeDescription[level], inputString];
        [self startLogging];
        NMXLogWithPrefix(level, nil, inputString);
        isRecorded = [self recordLogLogged:expectedString];
        [self closeLogging];
        XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    }

    NMXLogLevelType level = release;
    expectedString = [NSString stringWithFormat:@"%@%@",NMXLogLevelTypeDescription[level], inputString];
    [self startLogging];
    NMXLogWithPrefix(level, nil, inputString);
    isRecorded = [self recordLogLogged:expectedString];
    [self closeLogging];
// For static inputs we will run synchronously with the app => can determine the current DEBUG/RELEASE state and also use its related preprocessor macros
#ifdef NMXCoreStatic
    XCTAssertFalse(isRecorded, @"🔴🔴 No output string expected for release only builds, as we are on debug currently");
#else
    XCTAssertTrue(isRecorded, @"🔴🔴 In dynamic Library we are always archived => RELEASE, thus we cannot make use of this feature directly here and should always log our output.");
#endif
    
    level = all;
    NSString *prefix = @"CUSTOM_PREFIX";
    expectedString = [NSString stringWithFormat:@"%@%@",prefix, inputString];
    [self startLogging];
    NMXLogWithPrefix(level, prefix, inputString);
    isRecorded = [self recordLogLogged:expectedString];
    [self closeLogging];
    XCTAssertTrue(isRecorded, @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
}

@end
