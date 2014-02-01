//
//  RPLMainViewController.h
//  GitHub Client
//
//  Created by Richard Lichkus on 1/28/14.
//
//

#import <UIKit/UIKit.h>
#import "RPLCollectionViewCell.h"
#import "RPLNetworkController.h"
#import "GitHubUser.h"
#import "RPLGitHubRepo.h"
#import "RPLDetailViewController.h"

@protocol MenuControllerDelegate <NSObject>

- (void)openMenu;
- (void)closeMenu;

@end

@interface RPLMainViewController : UIViewController
@property (nonatomic, unsafe_unretained) id<MenuControllerDelegate> delegate;
@property (strong, nonatomic) RPLDetailViewController *detailViewController;

@end
