//
//  FlugstundenCellDelegate.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlugstundenCell;

@protocol FlugstundenCellDelegate <NSObject>
-(void)deleteButtonPressedForFlugstundenCell:(FlugstundenCell *)theCell;
@end
