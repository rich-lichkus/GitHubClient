//
//  RPLMasterViewController.h
//  GitHub Client
//
//  Created by Richard Lichkus on 1/27/14.
//
//

#import <UIKit/UIKit.h>
#import "RPLNetworkController.h"

@protocol MenuControllerDelegate <NSObject>

- (void)openMenu;
- (void)closeMenu;

@end

@class RPLDetailViewController;

@interface RPLMasterViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, unsafe_unretained) id<MenuControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISearchBar *txtSearch;
@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) RPLDetailViewController *detailViewController;

@end
