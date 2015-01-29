//
//  ModifyViewController.h
//  Travel
//
//  Created by ZKR on 1/6/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) UITableView* accountTable;
@property(strong,nonatomic) NSArray* listData;

@end
