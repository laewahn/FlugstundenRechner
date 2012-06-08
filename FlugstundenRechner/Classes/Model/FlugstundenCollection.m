//
//  FlugstundenCollection.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlugstundenCollection.h"
#import "FlugstundenEntry.h"
#import "FlugstundenConverter.h"

@implementation FlugstundenCollection


# pragma mark - Initialization

-(id)init
{
    self = [super init];
    
    if (self) {
        entries = [[NSMutableArray alloc] init];
    }
    
    return self;
}


# pragma mark - Public methods

-(FlugstundenEntry *)entryAtIndex:(NSInteger)index
{
    return (FlugstundenEntry *) [entries objectAtIndex:index];
}

-(NSInteger)flugstundenCount
{
    return [entries count];
}

-(void)addEntry:(FlugstundenEntry *)anEntry
{
    [entries addObject:anEntry];
}

-(void)removeEntryAtPosition:(NSInteger)aPosition
{
    [entries removeObjectAtIndex:aPosition];
}

# pragma mark - Properties

-(NSString *)overallFlugstundenString
{
    NSTimeInterval overallSeconds = 0;
    for (FlugstundenEntry* currentEntry in entries) {
        NSTimeInterval entrySeconds = [FlugstundenConverter timeIntervalFromFlugstundenEntry:currentEntry];
        overallSeconds += entrySeconds;
    }
    
    FlugstundenEntry* resultEntry = [FlugstundenConverter flugstundenEntryFromTimeInterval:overallSeconds];
    NSString *resultString = resultEntry.timeString;
    
    return resultString;
}

@end
