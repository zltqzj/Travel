//
//  BillCell.h
//  Travel
//
//  Created by ZKR on 1/6/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillCell : UITableViewCell

@property(weak,nonatomic) IBOutlet UIImageView * avatarImage;

@property(weak,nonatomic) IBOutlet UILabel* contentLabel;// 内容

@property(weak,nonatomic) IBOutlet UILabel* priceLabel;// 价格

@property(weak,nonatomic) IBOutlet UILabel* percentLabel;// 满意度



@end
