//
//  FlugstundenCell.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlugstundenCell.h"

@implementation FlugstundenCell
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIButton* deleteButton = [self createDeleteButton];

        self.accessoryView = deleteButton;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


# pragma mark - UI methods

-(void)deleteButtonPressed:(id)sender
{
    [self.delegate deleteButtonPressedForFlugstundenCell:self];
}


# pragma mark - Private methods

-(UIButton *)createDeleteButton
{
    UIImage* deleteImage = [UIImage imageNamed:@"delete_control.jpg"];
    UIButton* deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteButton.frame = CGRectMake(80, 5, 34, 33);
    
    [deleteButton setBackgroundImage:deleteImage forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:deleteImage forState:UIControlStateDisabled];
    [deleteButton setBackgroundImage:deleteImage forState:UIControlStateSelected];
    [deleteButton setBackgroundImage:deleteImage forState:UIControlStateHighlighted];
    [deleteButton setBackgroundImage:deleteImage forState:(UIControlStateHighlighted | UIControlStateSelected)];
    
    [deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];    
    return deleteButton;
}
@end
