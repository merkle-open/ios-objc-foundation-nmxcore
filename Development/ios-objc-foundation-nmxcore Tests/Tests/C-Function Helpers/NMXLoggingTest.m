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

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNMXLogFormat_Valid
{
    XCTAssertNoThrow(NMXLog(nil));
    XCTAssertNoThrow(NMXLog(@"Test test test %@ --- %@",nil,nil));
    XCTAssertNoThrow(NMXLog(@"Test test test %@ --- %@",@"Argument1", @"Argument2"));
    XCTAssertNoThrow(NMXLog(@"Test test test %@ --- %@",@"Argument1", @"Argument2", @"Argument not listed"));
    XCTAssertNoThrow(NMXLog(@"Test test test %@ --- %@"));
    XCTAssertNoThrow(NMXLog(@"Test test test %f --- %@",@(YES),@"Valid"));
    XCTAssertNoThrow(NMXLog((NSString *)[NSData new]));
    XCTAssertNoThrow(NMXLog(@""));
    XCTAssertNoThrow(NMXLog(@"",@""));
    XCTAssertNoThrow(NMXLog(@"Simple string output"));
    XCTAssertNoThrow(NMXLog(@"", (NSString *)[NSData new]));
}
    
- (void)testNMXLogLogLevelFormat_invalid {
    NSString *inputString = @"Test";
    NSString *expectedString = @"Test";
    NSString *outputString = @"";
    
    for (NSNumber *obj in [NSNumber testObjectTypeParamsInvalid])
    {
        NSLog(@"%@",obj);
        outputString = NMXLog((NSInteger)obj, inputString);
        XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    }
    NSObject *obj = nil;
    outputString = NMXLog((NSInteger)obj, inputString);
    XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    
    for (NSString *obj in [NSString testObjectTypeParamsInvalid])
    {
        NSLog(@"%@",obj);
        outputString = NMXLog(debug, obj);
        XCTAssertNil(outputString, @"🔴🔴 We want to log any kind of object, still we expect a string format input: %@",obj);
    }
    NSString *nullString = nil;
    outputString = NMXLog(debug, nullString);
    XCTAssertNil(outputString, @"🔴🔴 We want to log any kind of object, still we expect a string format input: %@",obj);
    // nevertheless common logging if an object was "by accident" nil, should work
}
    
- (void)testNMXLogLogLevelLogPrefixFormat_invalid {
    NSString *inputString = @"Test";
    NSString *expectedString = @"Test";
    NSString *outputString = @"";
    
    for (NSNumber *obj in [NSNumber testObjectTypeParamsInvalid])
    {
        outputString = NMXLogWithPrefix((NSInteger)obj, nil, inputString);
        XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    }
    NSObject *obj = nil;
    outputString = NMXLogWithPrefix((NSInteger)obj, nil, inputString);
    XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    
    outputString = NMXLogWithPrefix((NSInteger)17, nil, inputString);
    XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    
    outputString = NMXLogWithPrefix((NSInteger)-12, nil, inputString);
    XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    
    expectedString = [NSString stringWithFormat:@"%@%@",NMXLogLevelTypeDescription[debug], inputString];
    for (NSString *obj in [NSString testObjectTypeParamsInvalid])
    {
        outputString = NMXLogWithPrefix(debug, obj, inputString);
        XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    }
    outputString = NMXLogWithPrefix(debug, nil, inputString);
    XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    
    for (NSString *obj in [NSString testObjectTypeParamsInvalid])
    {
        outputString = NMXLogWithPrefix(debug, nil, obj);
        XCTAssertNil(outputString, @"🔴🔴 We want to log any kind of object, still we expect a string format input: %@",obj);
    }
    NSString *nullString = nil;
    outputString = NMXLogWithPrefix(debug, nil, nullString);
    XCTAssertNil(outputString, @"🔴🔴 We want to log any kind of object, still we expect a string format input: %@",obj);
    // nevertheless common logging if an object was "by accident" nil, should work
}

- (void)testNMXLogLogLevelLogPrefixFormat_valid
{
    NSString *inputString = @"Test";
    NSString *expectedString = @"Test";
    NSString *outputString = @"";
    
    int validLevels[3] = {none,debug,all,};
    for (int i = 0; i < sizeof(validLevels)/sizeof(validLevels[0]); i++)
    {
        NMXLogLevelType level = validLevels[i];
        expectedString = [NSString stringWithFormat:@"%@%@",NMXLogLevelTypeDescription[level], inputString];
        outputString = NMXLogWithPrefix(level, nil, inputString);
        XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
    }
    
    NMXLogLevelType level = release;
    expectedString = [NSString stringWithFormat:@"%@%@",NMXLogLevelTypeDescription[level], inputString];
    outputString = NMXLogWithPrefix(level, nil, inputString);
    XCTAssertNil(outputString, @"🔴🔴 No output string expected for release only builds, as we are on debug currently");
    
    
    level = all;
    NSString *prefix = @"CUSTOM_PREFIX";
    expectedString = [NSString stringWithFormat:@"%@%@",prefix, inputString];
    outputString = NMXLogWithPrefix(level, prefix, inputString);
    XCTAssertTrue([expectedString isEqualToString:outputString], @"🔴🔴 Outputstring differs from expected outputstring:\nInput:    %@\nOutput:   %@\nExpected: %@",inputString, outputString, expectedString);
}
    
@end
