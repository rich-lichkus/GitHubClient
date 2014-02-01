//
//  RPLDetailViewController.h
//  GitHub Client
//
//  Created by Richard Lichkus on 1/27/14.
//
//

#import <UIKit/UIKit.h>
#import "RPLGitHubRepo.h"

@interface RPLDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) RPLGitHubRepo *detailItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
