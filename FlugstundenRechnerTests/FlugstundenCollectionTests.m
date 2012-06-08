//
//  FlugstundenCollectionTests.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlugstundenCollectionTests.h"
#import "FlugstundenEntry.h"
#import "FlugstundenCollection.h"
@implementation FlugstundenCollectionTests

-(void) testAddingAndRemoving
{
    FlugstundenCollection* testCollection = [[FlugstundenCollection alloc] init];
    
    STAssertEquals([testCollection flugstundenCount], 0, @"Wrong number of entries");
    
    FlugstundenEntry* newEntry = [[FlugstundenEntry alloc] init];
    [testCollection addEntry:newEntry];
    STAssertEquals([testCollection flugstundenCount], 1, @"Wrong number of entries");
    
    newEntry = [[FlugstundenEntry alloc] init];
    [testCollection addEntry:newEntry];
    STAssertEquals([testCollection flugstundenCount], 2, @"Wrong number of entries");
    
    [testCollection removeEntryAtPosition:1];
    STAssertEquals([testCollection flugstundenCount], 1, @"Wrong number of entries");
    
    [testCollection removeEntryAtPosition:0];
    STAssertEquals([testCollection flugstundenCount], 0, @"Wrong number of entries");
    
}

-(void)testOverallFlugstundenCalculation
{
    FlugstundenCollection* testCollection = [[FlugstundenCollection alloc] init];
    
    // 1:22
    FlugstundenEntry* newEntry = [[FlugstundenEntry alloc] init];
    [newEntry pushDigit:1];
    [newEntry pushDigit:2];
    [newEntry pushDigit:2];
    [testCollection addEntry:newEntry];
    
    // 0:06
    newEntry = [[FlugstundenEntry alloc] init];
    [newEntry pushDigit:6];
    [testCollection addEntry:newEntry];
    
    // 0:45
    newEntry = [[FlugstundenEntry alloc] init];
    [newEntry pushDigit:4];
    [newEntry pushDigit:5];
    [testCollection addEntry:newEntry];
    
    NSString* overallTime = testCollection.overallFlugstundenString;
    NSString* expectedString = @"02:13";
    STAssertEqualObjects(overallTime, expectedString, @"Wrong result");
    
    
    testCollection = [[FlugstundenCollection alloc] init];
    
    // 1:22
    newEntry = [[FlugstundenEntry alloc] init];
    [newEntry pushDigit:1];
    [newEntry pushDigit:2];
    [newEntry pushDigit:2];
    [testCollection addEntry:newEntry];
    // 0:45
    newEntry = [[FlugstundenEntry alloc] init];
    [newEntry pushDigit:4];
    [newEntry pushDigit:5];
    [testCollection addEntry:newEntry];
    
    overallTime = testCollection.overallFlugstundenString;
    expectedString = @"02:07";
    STAssertEqualObjects(overallTime, expectedString, @"Wrong result");
}


@end
