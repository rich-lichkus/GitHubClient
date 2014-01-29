//
//  RPLDetailViewController.h
//  GitHub Client
//
//  Created by Richard Lichkus on 1/27/14.
//
//

#import <UIKit/UIKit.h>

@interface RPLDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
