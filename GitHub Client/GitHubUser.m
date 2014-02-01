//
//  GitHubUser.m
//  GitHub Client
//
//  Created by Richard Lichkus on 1/28/14.
//
//


#import "GitHubUser.h"

@interface GitHubUser (){

}

@end

@implementation GitHubUser

- (void) downloadAvatar {
    
    _downloading = YES;
    
    [_avatarDownloadQueue addOperationWithBlock:^{
        NSData *imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: _avatarURL]];
        _avatar = [UIImage imageWithData:imageData];
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName: @"DownloadedImage"
                                                                object: nil
                                                              userInfo: @{@"user" :self}];
        }];
    }];
}

@end
