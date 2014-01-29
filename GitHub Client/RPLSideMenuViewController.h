//
//  RPLSideMenuViewController.h
//  GitHub Client
//
//  Created by Richard Lichkus on 1/27/14.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RPLMasterViewController.h"

@interface RPLSideMenuViewController : UIViewController < MenuControllerDelegate, UIGestureRecognizerDelegate>

- (void)openMenu;
- (void)closeMenu;

@end
