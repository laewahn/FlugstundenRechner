//
//  TextFieldTimeFormatter.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 02.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlugstundenEntry : NSObject {
    
    NSMutableArray* digits;
    
}

-(void)pushDigit:(NSInteger)aDigit;
-(NSInteger)popDigit;

-(void)clear;
-(BOOL)isValid;

@property(nonatomic, readonly) NSString* timeString;

@end
