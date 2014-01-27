//
//  RPLMasterViewController.h
//  GitHub Client
//
//  Created by Richard Lichkus on 1/27/14.
//
//

#import <UIKit/UIKit.h>

@class RPLDetailViewController;

@interface RPLMasterViewController : UITableViewController

@property (strong, nonatomic) RPLDetailViewController *detailViewController;

@end
