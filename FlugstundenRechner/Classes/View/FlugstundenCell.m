//
//  FlugstundenCell.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlugstundenCell.h"

static UIImage* sharedDeleteImage;

@implementation FlugstundenCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected) {
        return;
    }
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


# pragma mark - UI methods

-(void)deleteButtonPressed:(id)sender
{
    [self.delegate deleteButtonPressedForFlugstundenCell:self];
}


# pragma mark - Private methods

-(UIButton *)deleteButton
{
    if (sharedDeleteImage == nil) {
        sharedDeleteImage = [UIImage imageNamed:@"delete.png"];
    }
    
    UIImage* deleteImage = sharedDeleteImage;
    
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
