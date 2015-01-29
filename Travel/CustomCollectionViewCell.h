//
//  CustomCollectionViewCell.h
//  Travel
//
//  Created by ZKR on 1/19/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

@property(weak,nonatomic) IBOutlet UIImageView* descImage;
@property(weak,nonatomic) IBOutlet UIButton* descButton;
@end
