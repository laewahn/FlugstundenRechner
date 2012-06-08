//
//  MainViewController.m
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 31.05.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import "MainViewController.h"

#import "FlugstundenEntry.h"
#import "FlugstundenCollection.h"
#import "FlugstundenKeyboardViewController.h"
#import "FlugstundenCell.h"

@interface MainViewController ()
@end

@implementation MainViewController
@synthesize timeInputTextField;
@synthesize overallTimeLabel;
@synthesize entriesTable;


- (void)viewDidLoad
{
    [super viewDidLoad];

    currentEntry = [[FlugstundenEntry alloc] init];
    entries = [[FlugstundenCollection alloc] init];

    [timeInputTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setTimeInputTextField:nil];
    [self setOverallTimeLabel:nil];
    [self setEntriesTable:nil];
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - UI methods

-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)theRange replacementString:(NSString *)theReplacement
{
    
    if ([theReplacement isEqualToString:@""]) {
        [currentEntry popDigit];
    } else {
        NSInteger newDigit = [theReplacement intValue];
        [currentEntry pushDigit:newDigit];
    }
    
    [self updateInputTextField];
    
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self clearCurrentEntry];
    
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [entries addEntry:currentEntry];
    currentEntry = [[FlugstundenEntry alloc] init];
    
    [self updateInputTextField];
    [self updateTableAndResult];
    
    return NO;
}


#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark - TableView Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [entries flugstundenCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"Cell";
    
    FlugstundenCell *cell = (FlugstundenCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FlugstundenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    
    FlugstundenEntry* cellEntry = [entries entryAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%d. %@", [indexPath row] + 1, cellEntry.timeString];
    
    return cell;
}


# pragma mark - FlugstundenCell delegate methods

-(void)deleteButtonPressedForFlugstundenCell:(FlugstundenCell *)theCell
{
    NSInteger positionOfCell = [[entriesTable indexPathForCell:theCell] row];
    [entries removeEntryAtPosition:positionOfCell];
    
    [self updateTableAndResult];
}


# pragma mark - Private methods

-(void)updateInputTextField
{
    timeInputTextField.text = currentEntry.timeString;
}

-(void)updateTableAndResult
{
    overallTimeLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"OVERALL", nil), entries.overallFlugstundenString]; 
    [entriesTable reloadData];
}

-(void)clearCurrentEntry
{
    [currentEntry clear];
    [self updateInputTextField];
}

-(void)clearList
{
    entries = [[FlugstundenCollection alloc] init];

    [self clearCurrentEntry];
    [self updateTableAndResult];
}


@end