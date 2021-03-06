//
//  FlugstundenConverter.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlugstundenEntry;

@interface FlugstundenConverter : NSObject

+(FlugstundenEntry *)flugstundenEntryFromTimeInterval:(NSTimeInterval)anInterval;
+(NSTimeInterval)timeIntervalFromFlugstundenEntry:(FlugstundenEntry *)anEntry;

@end
