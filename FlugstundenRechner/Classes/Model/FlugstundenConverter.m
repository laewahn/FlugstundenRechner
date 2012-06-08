//
//  FlugstundenConverter.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlugstundenConverter.h"
#import "FlugstundenConverter+Private.h"

#import "FlugstundenEntry.h"

@implementation FlugstundenConverter


# pragma mark - Public methods

+(FlugstundenEntry *)flugstundenEntryFromTimeInterval:(NSTimeInterval)anInterval
{
    NSInteger hours = [self hoursFromTimeInterval:anInterval];
    NSInteger minutes = [self minutesFromTimeInterval:anInterval];
    
    NSString *timeString = [NSString stringWithFormat:@"%d%2d", hours, minutes];
    
    FlugstundenEntry* newEntry = [[FlugstundenEntry alloc] init];
    
    for (int position = 0; position < [timeString length]; position++) {
        NSInteger currentValue = [[timeString substringWithRange:NSMakeRange(position, 1)] intValue];
        [newEntry pushDigit:currentValue];
    }
    
    return newEntry;
}

+(NSTimeInterval)timeIntervalFromFlugstundenEntry:(FlugstundenEntry *)anEntry
{
    NSString* timeString = anEntry.timeString;
    
    NSArray* timeComponents = [timeString componentsSeparatedByString:@":"];
    
    NSString* hoursString = [timeComponents objectAtIndex:0];
    NSString* minutesString = [timeComponents objectAtIndex:1];
    
    NSInteger hoursInMinutes = [hoursString intValue] * 60;
    NSInteger hoursAndMinutes = hoursInMinutes + [minutesString intValue];
    
    NSTimeInterval seconds = hoursAndMinutes * 60;

    return seconds;
}


# pragma mark - Private methods

+(NSInteger)hoursFromTimeInterval:(NSTimeInterval)theInterval
{
    return theInterval/3600;
}

+(NSInteger)minutesFromTimeInterval:(NSTimeInterval)theInterval
{
    // TimeInterval comes in seconds
    NSInteger minutes = theInterval / 60;
    
    // First get the hours
    NSInteger hours = [self hoursFromTimeInterval:theInterval];
    
    // Substract the minutes of the completed hours from the minutes
    NSInteger hoursInMinutes = hours * 60;
    NSInteger remainingMinutes = minutes - hoursInMinutes;
    
    return remainingMinutes;
}



@end
