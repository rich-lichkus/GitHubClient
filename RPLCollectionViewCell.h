//
//  RPLCollectionViewCell.h
//  GitHub Client
//
//  Created by Richard Lichkus on 1/28/14.
//
//

#import <UIKit/UIKit.h>

@interface RPLCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (nonatomic, getter=isDownloadingImage) BOOL downloadingImage;
@end
