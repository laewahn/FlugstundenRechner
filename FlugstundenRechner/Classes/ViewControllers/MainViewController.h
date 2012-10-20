//
//  MainViewController.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 31.05.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlipsideViewController.h"
#import "FlugstundenCellDelegate.h"

@class FlugstundenEntry;
@class FlugstundenCollection;
@class FlugstundenKeyboardViewController;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, FlugstundenCellDelegate> {
    
    FlugstundenEntry* currentEntry;
    FlugstundenCollection* entries;
    
}

@property (weak, nonatomic) IBOutlet UITextField *timeInputTextField;
@property (weak, nonatomic) IBOutlet UILabel *overallTimeLabel;
@property (weak, nonatomic) IBOutlet UITableView *entriesTable;
@property (weak, nonatomic) IBOutlet UIButton *clearAllButton;


@end
