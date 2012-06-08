//
//  TestViewController.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlugstundenKeyboardDelegate.h"


@interface FlugstundenKeyboardViewController : UIViewController 

@property(nonatomic, weak) id<FlugstundenKeyboardDelegate> delegate;
@end
