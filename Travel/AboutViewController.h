//
//  AboutViewController.h
//  Travel
//
//  Created by ZKR on 1/28/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic) UITableView* aboutTable;

@property(strong,nonatomic) NSArray* listData;


@end
