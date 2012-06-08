//
//  TimeTextField.h
//  FlugstundenRechner
//
//  Created by Dennis Lewandowski on 03.06.12.
//  Copyright (c) 2012 RWTH Aachen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlugstundenKeyboardDelegate.h"

@class FlugstundenEntry;
@class FlugstundenKeyboardViewController;

@interface TimeTextField : UITextField<FlugstundenKeyboardDelegate> {
    FlugstundenKeyboardViewController* keyboard;
}

@end
