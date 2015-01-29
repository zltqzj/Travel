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

@interface MyBillViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,MXPullDownMenuDelegate>

@property(strong,nonatomic)  UIScrollView* wholeScroll;
@property(strong,nonatomic)   UITableView* billTable;
@property(strong,nonatomic) NSMutableArray* listData;

@property(strong,nonatomic) SellView* sellView1;
@property(strong,nonatomic) SellView* sellView2;
@property(strong,nonatomic) SellView* sellView3;
@property(strong,nonatomic) SellView* sellView4;

@end
