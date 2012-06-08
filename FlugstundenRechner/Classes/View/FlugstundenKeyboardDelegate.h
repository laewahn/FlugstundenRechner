//
//  FlugstundenKeyboardDelegate.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlugstundenKeyboardViewController;

@protocol FlugstundenKeyboardDelegate
-(void)keyboard:(FlugstundenKeyboardViewController *)theKeyboard clickedDigit:(NSString *)aDigit;
-(void)addButtonClickedOnKeyboard:(FlugstundenKeyboardViewController *)theKeyboard;
-(void)deleteButtonClickedOnKeyboard:(FlugstundenKeyboardViewController *)theKeyboard;
@end
