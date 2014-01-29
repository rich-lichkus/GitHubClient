//
//  RPLNetworkController.m
//  GitHub Client
//
//  Created by Richard Lichkus on 1/27/14.
//
//

#import "RPLNetworkController.h"
#import "GitHubUser.h"

@interface RPLNetworkController()

@end

@implementation RPLNetworkController

+(RPLNetworkController *) sharedController
{
    static dispatch_once_t pred;
    static RPLNetworkController *shared =nil;
    dispatch_once(&pred, ^{
        shared = [[RPLNetworkController alloc]init];
    });
    return shared;
}

- (NSDictionary *)reposForSearchString:(NSString *)searchString
{
    searchString = [NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@", searchString];
    searchString = [searchString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSError *error;
    NSURL *searchURL = [NSURL URLWithString:searchString];
    NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
    NSDictionary *searchDictionary = [NSJSONSerialization JSONObjectWithData:searchData options: NSJSONReadingMutableContainers error: &error];
    return searchDictionary[@"items"];
    
    
}

- (NSMutableArray *)usersForSearchString:(NSString *)searchString
// PRE:     Search GitHub for users with, name (string)
// POST:    GitHubUser objects (NSMutableArray)
{
    NSMutableArray* gitUsers = [NSMutableArray new];
    NSDictionary *searchDictionary = [NSDictionary new];
    NSError *error;
    self.avatarDownloadQueue = [NSOperationQueue new];
    
    searchString = [NSString stringWithFormat:@"https://api.github.com/search/users?q=%@", searchString];
    searchString = [searchString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    @try {
        NSURL *searchURL = [NSURL URLWithString:searchString];
        NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
        searchDictionary = [NSJSONSerialization JSONObjectWithData:searchData options: NSJSONReadingMutableContainers error: &error];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception.description);
        NSLog(@"%@", error.debugDescription);
    }
    
    // Convert dictionary to array of githubuser
    for(NSDictionary *aUser in searchDictionary[@"items"])
    {
        GitHubUser *user = [GitHubUser new];
        user.name = aUser[@"login"];
        user.avatarURL = aUser[@"avatar_url"];
        user.avatarDownloadQueue = self.avatarDownloadQueue;
        [gitUsers addObject:user];
    }
    return gitUsers;
}





@end
