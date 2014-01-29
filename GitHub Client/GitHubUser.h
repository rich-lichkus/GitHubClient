//
//  GitHubUser.h
//  GitHub Client
//
//  Created by Richard Lichkus on 1/28/14.
//
//

#import <Foundation/Foundation.h>

@interface GitHubUser : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) UIImage *avatar;
@property (nonatomic, getter = isDownloading) BOOL downloading;
@property (nonatomic, weak) NSOperationQueue *avatarDownloadQueue;

- (void)downloadAvatar;

@end
