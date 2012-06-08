//
//  FlugstundenConverterTests.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlugstundenConverterTests.h"

#import "FlugstundenConverter.h"
#import "FlugstundenConverter+Private.h"
#import "FlugstundenEntry.h"

const static NSTimeInterval oneTwentyTwoInSeconds = 4920;

@implementation FlugstundenConverterTests

-(void)testPrivateMethods
{    
    
    STAssertEquals([FlugstundenConverter hoursFromTimeInterval:oneTwentyTwoInSeconds], 1, @"Wrong result");
    STAssertEquals([FlugstundenConverter minutesFromTimeInterval:oneTwentyTwoInSeconds], 22, @"Wrong result");
    
}

-(void)testConversionFromTimeInterval
{
    FlugstundenEntry* convertedEntry = [FlugstundenConverter flugstundenEntryFromTimeInterval:oneTwentyTwoInSeconds];
    
    NSString* expectedString = @"01:22";
    STAssertEqualObjects(convertedEntry.timeString, expectedString, @"Wrong result");
}

-(void)testConversionFromEntry
{
    FlugstundenEntry* testEntry = [[FlugstundenEntry alloc] init];
    [testEntry pushDigit:1];
    [testEntry pushDigit:2];
    [testEntry pushDigit:2];
    
    NSTimeInterval testInterval = [FlugstundenConverter timeIntervalFromFlugstundenEntry:testEntry];
    STAssertEquals(testInterval, oneTwentyTwoInSeconds, @"Wrong result");
}


@end
