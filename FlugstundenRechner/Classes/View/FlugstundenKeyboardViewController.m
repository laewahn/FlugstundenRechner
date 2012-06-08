//
//  TestViewController.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlugstundenKeyboardViewController.h"

@interface FlugstundenKeyboardViewController ()

@end


@implementation FlugstundenKeyboardViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)button1Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"1"];
}

- (IBAction)button2Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"2"];
}

- (IBAction)button3Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"3"];
}

- (IBAction)button4Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"4"];
}

- (IBAction)button5Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"5"];
}

- (IBAction)button6Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"6"];
}

- (IBAction)button7Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"7"];
}

- (IBAction)button8Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"8"];
}

- (IBAction)button9Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"9"];
}

- (IBAction)button0Pressed:(id)sender {
    [delegate keyboard:self clickedDigit:@"0"];
}


-(IBAction)addButtonPressed:(id)sender
{
    [delegate addButtonClickedOnKeyboard:self];
}

- (IBAction)deleteButtonPressed:(id)sender {
    [delegate deleteButtonClickedOnKeyboard:self];
}

@end
