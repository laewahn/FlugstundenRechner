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

#import <QuartzCore/QuartzCore.h>

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
    
    [self.overallTimeLabel.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.overallTimeLabel.layer setBorderWidth:1];
    
    [timeInputTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setTimeInputTextField:nil];
    [self setOverallTimeLabel:nil];
    [self setEntriesTable:nil];
    [self setClearAllButton:nil];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

# pragma mark - UI methods

-(IBAction)clearAllButtonClicked:(id)sender
{
    entries = [[FlugstundenCollection alloc] init];
    
    NSIndexSet* firstSection = [NSIndexSet indexSetWithIndex:0];
    [self.entriesTable reloadSections:firstSection withRowAnimation:UITableViewRowAnimationFade];
    
    [self updateResult];
}

-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)theRange replacementString:(NSString *)theReplacement
{
    if ([theReplacement isEqualToString:@""]) {
        [currentEntry popDigit];
    } else {
        
        if ([currentEntry.timeString length] > 7) {
            return NO;
        }
        
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
    if (![currentEntry isValid]) {
        [UIView animateWithDuration:1.0 animations:^(void){
            UIColor* prevColor = self.view.backgroundColor;
            //            [timeInputTextField.layer setBackgroundColor:[UIColor redColor].CGColor];
            [self.view setBackgroundColor:[UIColor redColor]];
            [self.view setBackgroundColor:prevColor];
        }];
        
        return NO;
    }
    
    [entries addEntry:currentEntry];
    currentEntry = [[FlugstundenEntry alloc] init];
    
    NSIndexPath* lastRowIndex = [NSIndexPath indexPathForRow:([entries flugstundenCount] - 1) inSection:0];
    [entriesTable insertRowsAtIndexPaths:[NSArray arrayWithObject:lastRowIndex] withRowAnimation:UITableViewRowAnimationTop];
    
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
    cell.accessoryView = [cell deleteButton];
    cell.delegate = self;
    
    return cell;
}


# pragma mark - FlugstundenCell delegate methods

-(void)deleteButtonPressedForFlugstundenCell:(FlugstundenCell *)theCell
{
    NSIndexPath *rowsToDelete = [entriesTable indexPathForCell:theCell];
    
    NSInteger positionOfCell = [rowsToDelete row];

    [entries removeEntryAtPosition:positionOfCell];
    
    [self.entriesTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:rowsToDelete] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self updateTextInRowsStartingAtIndex:positionOfCell];
    [self updateResult];
    
}


# pragma mark - Private methods

-(void)updateInputTextField
{
    timeInputTextField.text = currentEntry.timeString;
}

-(void)updateTextInRowsStartingAtIndex:(NSInteger)startIndex
{
    for (int cellIndex = startIndex; cellIndex < [entries flugstundenCount]; cellIndex++) {
        NSIndexPath* currentCellIndexPath = [NSIndexPath indexPathForRow:cellIndex inSection:0];
        UITableViewCell* currentCell = [self.entriesTable cellForRowAtIndexPath:currentCellIndexPath];
        
        FlugstundenEntry* cellsEntry = [entries entryAtIndex:cellIndex];
        currentCell.textLabel.text = [NSString stringWithFormat:@"%d. %@", cellIndex + 1, cellsEntry.timeString];
    }
}

-(void)updateTableAndResult
{
    [self updateTable];
    [self updateResult];
}
     
-(void)updateResult
{
    NSString* overallAbreviation;
    
    if ([entries.overallFlugstundenString length] <= 7) {
        overallAbreviation = NSLocalizedString(@"OVERALL", nil);
    }
    else {
        overallAbreviation = NSLocalizedString(@"OVERALL_SHORT", nil);
    }
    
    overallTimeLabel.text = [NSString stringWithFormat:@"%@: %@", overallAbreviation, entries.overallFlugstundenString];
}

-(void)updateTable
{
    NSIndexPath* lastEntry = [NSIndexPath indexPathForRow:([entries flugstundenCount] - 1) inSection:0];
    [entriesTable scrollToRowAtIndexPath:lastEntry atScrollPosition:UITableViewScrollPositionBottom animated:YES];
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
