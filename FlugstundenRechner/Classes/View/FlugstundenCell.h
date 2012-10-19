//
//  FlugstundenCell.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlugstundenCellDelegate.h"

@interface FlugstundenCell : UITableViewCell

@property(nonatomic, weak) id<FlugstundenCellDelegate> delegate;

-(UIButton *)deleteButton;

@end
