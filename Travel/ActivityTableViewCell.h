//
//  ActivityTableViewCell.h
//  Travel
//
//  Created by ZKR on 3/7/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell


@property(weak,nonatomic) IBOutlet UIImageView* iconImage;

@property(weak,nonatomic) IBOutlet UILabel* titleLabel;

@property(weak,nonatomic) IBOutlet UILabel* descLabel;

@end
