//
//  ActivityViewController.h
//  Travel
//
//  Created by ZKR on 3/7/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncScrollView.h"
@interface ActivityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(strong,nonatomic) IBOutlet UITableView* actTable;

@property(strong,nonatomic) NSMutableArray * listData;

// 轮播
@property(strong,nonatomic) IBOutlet AsyncScrollView *sv;

@property(strong,nonatomic) IBOutlet UIPageControl* pageControl;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *imageURLs;
@end
