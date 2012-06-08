//
//  FlugstundenCollection.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlugstundenEntry;

@interface FlugstundenCollection : NSObject {
    
    NSMutableArray* entries;
}

-(FlugstundenEntry *)entryAtIndex:(NSInteger)index;
-(NSInteger)flugstundenCount;

-(void)addEntry:(FlugstundenEntry *)anEntry;
-(void)removeEntryAtPosition:(NSInteger)aPosition;

@property(readonly) NSString* overallFlugstundenString;

@end
