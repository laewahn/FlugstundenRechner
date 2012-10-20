//
//  FlipsideViewController.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 31.05.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)fthaLinkClicked:(id)sender
{
    NSLog(@"Link was tapped!");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ftha.de"]];
}


@end
