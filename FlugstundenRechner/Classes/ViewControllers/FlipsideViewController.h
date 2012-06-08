//
//  FlipsideViewController.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 31.05.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
