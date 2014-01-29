//
//  RPLNetworkController.h
//  GitHub Client
//
//  Created by Richard Lichkus on 1/27/14.
//
//

#import <Foundation/Foundation.h>

@interface RPLNetworkController : NSObject

@property (strong, nonatomic) NSOperationQueue *avatarDownloadQueue;

+(RPLNetworkController *) sharedController;
- (NSDictionary *)reposForSearchString:(NSString *)searchString;
- (NSMutableArray *)usersForSearchString:(NSString *)searchString;

@end
