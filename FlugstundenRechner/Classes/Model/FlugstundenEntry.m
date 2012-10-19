//
//  TextFieldTimeFormatter.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 02.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlugstundenEntry.h"


const static int kTextFieldFormatterCapacity = 4;


@interface FlugstundenEntry()
-(void)initializeDigits;
@end


@implementation FlugstundenEntry


# pragma mark - Initialization

-(id)init
{
    self = [super init];
    
    if(self != nil) {
        [self initializeDigits];
    }
    
    return self;
}


# pragma mark - Public methods

-(void)pushDigit:(NSInteger)aDigit
{
    if ([digits count] < kTextFieldFormatterCapacity) {
        [digits insertObject:[NSNumber numberWithInt:aDigit] atIndex:0];
    }
}

-(NSInteger)popDigit
{
    NSNumber* currentNumber;
    if ([digits count] > 0) {
        currentNumber = (NSNumber *)[digits objectAtIndex:0];
        [digits removeObjectAtIndex:0];
    }
    
    return [currentNumber intValue];
}

-(void)clear
{
    [self initializeDigits];
}

-(NSString *)timeString
{
    NSMutableString* outputString = [[NSMutableString alloc] init];
    
    for (int position = 3 ; position >= 0 ; position--) {

        if (position == 1) {
            [outputString appendString:@":"];
        }
        
        NSNumber* currentNumber;
        if (position >= [digits count]) {
            currentNumber = [NSNumber numberWithInt:0];
        } else {
            currentNumber = (NSNumber *)[digits objectAtIndex:position];
        }
        
        NSString* formatString = [NSString stringWithFormat:@"%d", [currentNumber intValue]];
        [outputString appendString:formatString];
         
    }
         
    return [NSString stringWithString:outputString];
}

-(BOOL)isValid
{
    if ([digits count] == 0) {
        return NO;
    }
    
    if ([digits count] == 1) {
        return YES;
    }
    
    return !([[digits objectAtIndex:1] intValue] >= 6);
}


# pragma mark - Private methods

-(void)initializeDigits
{
    digits = [NSMutableArray arrayWithCapacity:kTextFieldFormatterCapacity];
}

@end
