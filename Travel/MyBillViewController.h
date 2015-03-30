//
//  MyBillViewController.h
//  Travel
//
//  Created by ZKR on 1/6/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellView.h"
#import "MXPullDownMenu.h"
#import "DOPDropDownMenu.h"

@interface MyBillViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>

 @property(strong,nonatomic)   UITableView* billTable;
@property(strong,nonatomic) NSMutableArray* listData;

@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSArray *areas;
@property (nonatomic, strong) NSArray *sorts;


@end
