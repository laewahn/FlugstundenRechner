//
//  TextFieldTimeFormatterTests.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 02.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlugstundenEntryTests.h"
#import "FlugstundenEntry.h"

@implementation FlugstundenEntryTests

-(void) testInitialization
{
    FlugstundenEntry* testEntry = [[FlugstundenEntry alloc] init];
    NSString* expectedString = @"00:00";
    
    STAssertEqualObjects(testEntry.timeString, expectedString,@"Wrong string returned.");
}

-(void) testPushing
{
    FlugstundenEntry* testEntry = [[FlugstundenEntry alloc] init];

    [testEntry pushDigit:1];
    NSString* expectedString = @"00:01";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    
    [testEntry pushDigit:2];
    expectedString = @"00:12";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    
    [testEntry pushDigit:3];
    expectedString = @"01:23";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    
    [testEntry pushDigit:4];
    expectedString = @"12:34";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    
}

-(void) testPopping
{
    FlugstundenEntry* testEntry = [[FlugstundenEntry alloc] init];
    
    [testEntry pushDigit:1];
    [testEntry pushDigit:2];
    [testEntry pushDigit:3];
    [testEntry pushDigit:4];
    
    NSString* expectedString = @"12:34";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    
    NSInteger lastNumber = [testEntry popDigit];
    expectedString = @"01:23";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    STAssertEquals(lastNumber, 4, @"Wrong value returned.");

    lastNumber = [testEntry popDigit];
    expectedString = @"00:12";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    STAssertEquals(lastNumber, 3, @"Wrong value returned.");
    
    [testEntry pushDigit:4];
    expectedString = @"01:24";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");

    lastNumber = [testEntry popDigit];
    expectedString = @"00:12";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    STAssertEquals(lastNumber, 4, @"Wrong value returned.");

    lastNumber = [testEntry popDigit];
    expectedString = @"00:01";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    STAssertEquals(lastNumber, 2, @"Wrong value returned.");

    lastNumber = [testEntry popDigit];
    expectedString = @"00:00";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    STAssertEquals(lastNumber, 1, @"Wrong value returned.");

}

-(void) testClearing
{
    FlugstundenEntry* testFormatter = [[FlugstundenEntry alloc] init];
    
    [testFormatter pushDigit:1];
    [testFormatter pushDigit:2];
    [testFormatter pushDigit:3];
    [testFormatter pushDigit:4];
    
    NSString* expectedString = @"12:34";
    STAssertEqualObjects(testFormatter.timeString, expectedString, @"Wrong string returned.");

    STAssertNoThrow([testFormatter clear], @"Clearing caused an exception");
    
    expectedString = @"00:00";
    STAssertEqualObjects(expectedString, testFormatter.timeString, @"Wrong string returned.");
}

-(void) testEdgeCases
{
    FlugstundenEntry* testEntry = [[FlugstundenEntry alloc] init];
    
    [testEntry pushDigit:1];
    [testEntry pushDigit:2];
    [testEntry pushDigit:3];
    [testEntry pushDigit:4];
    
    STAssertNoThrow([testEntry pushDigit:5], @"Puhsing caused an exception");
    NSString* expectedString = @"12:34";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    
    NSInteger lastDigit = [testEntry popDigit];
    STAssertEquals(lastDigit, 4, @"Wrong value returned");
    
    [testEntry popDigit];
    [testEntry popDigit];
    [testEntry popDigit];

    expectedString = @"00:00";
    STAssertEqualObjects(testEntry.timeString, expectedString, @"Wrong string returned.");
    STAssertNoThrow([testEntry popDigit], @"Popping the empty formatter caused an exception");
}

-(void)testEmptyEntryShouldBeInvalid
{
    FlugstundenEntry* testEntry = [[FlugstundenEntry alloc] init];
    
    STAssertFalse([testEntry isValid], @"Empty entry is not valid");
}

-(void)testInvalidEntryShouldBeInvalid
{
    FlugstundenEntry* testEntry = [[FlugstundenEntry alloc] init];
    
    [testEntry pushDigit:9];
    [testEntry pushDigit:9];
    
    STAssertFalse([testEntry isValid], @"%@ is not valid", testEntry.timeString);
    
    testEntry = [[FlugstundenEntry alloc] init];
    
    [testEntry pushDigit:9];
    [testEntry pushDigit:9];
    [testEntry pushDigit:1];
    
    STAssertFalse([testEntry isValid], @"%@ is not valid", testEntry.timeString);
    
    testEntry = [[FlugstundenEntry alloc] init];
    
    [testEntry pushDigit:6];
    [testEntry pushDigit:9];
    
    STAssertFalse([testEntry isValid], @"%@ is not valid", testEntry.timeString);
}

-(void)testValidEntryShouldBeValid
{
    FlugstundenEntry* testEntry = [[FlugstundenEntry alloc] init];
    
    [testEntry pushDigit:1];
    
    STAssertNoThrow([testEntry isValid], @"Should not crash");
    STAssertTrue([testEntry isValid], @"%@ should be valid", testEntry.timeString);
    
    testEntry = [[FlugstundenEntry alloc] init];
    
    [testEntry pushDigit:1];
    [testEntry pushDigit:2];
    
    STAssertNoThrow([testEntry isValid], @"Should not crash");
    STAssertTrue([testEntry isValid], @"%@ should be valid", testEntry.timeString);
}


@end