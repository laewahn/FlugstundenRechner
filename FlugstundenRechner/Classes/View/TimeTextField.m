//
//  TimeTextField.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "TimeTextField.h"

#import "FlugstundenEntry.h"
#import "FlugstundenKeyboardViewController.h"


@implementation TimeTextField


# pragma mark - Initialization

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        keyboard = [[FlugstundenKeyboardViewController alloc] initWithNibName:@"FlugstundenKeyboardViewController" bundle:nil];
        self.inputView = keyboard.view;
        keyboard.delegate = self;
        
    }
    
    return self;
}


# pragma mark - Keyboard delegate methods

-(void)keyboard:(FlugstundenKeyboardViewController *)theKeyboard clickedDigit:(NSString *)aDigit
{
    [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(0, 1) replacementString:aDigit];
}

-(void)deleteButtonClickedOnKeyboard:(FlugstundenKeyboardViewController *)theKeyboard
{
    [self.delegate textField:self shouldChangeCharactersInRange:NSMakeRange(0, 1) replacementString:@""];
}

-(void)addButtonClickedOnKeyboard:(FlugstundenKeyboardViewController *)theKeyboard
{
    [self.delegate textFieldShouldReturn:self];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // I don't know what this beaks...
    return NO;
}

@end
