//
//  MainPageViewController.h
//  Travel
//
//  Created by ZKR on 1/4/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(weak,nonatomic) IBOutlet UIButton* cheapSaleToday_btn;// 今日特惠
@property(weak,nonatomic) IBOutlet UIButton* department_btn;// 公寓
@property(weak,nonatomic) IBOutlet UIButton* hourHouse_btn;// 钟点房
@property(weak,nonatomic) IBOutlet UIButton* orderCar_btn;//接送用车

@property(weak,nonatomic) IBOutlet UIButton* weekendTravel_btn;//周末游
@property(weak,nonatomic) IBOutlet UIButton* buyTogether_btn;//团购
@property(weak,nonatomic) IBOutlet UIButton* seneryTicket_btn;//景点门票
@property(weak,nonatomic) IBOutlet UIButton* travelMethod_btn;//攻略
@property(weak,nonatomic) IBOutlet UIButton* ownCar_btn;//用车自驾
@property(weak,nonatomic) IBOutlet UIButton* holiday_btn;//旅游度假
@property(weak,nonatomic) IBOutlet UIButton* trainTicket_btn;//火车票
@property(weak,nonatomic) IBOutlet UIButton* localMan_btn;//当地人
@property(weak,nonatomic) IBOutlet UIButton* camelBook_btn;//骆驼书
@property(weak,nonatomic) IBOutlet UIButton* visa_btn;//签证

@property(strong,nonatomic) IBOutlet UITableView* myTable;

@property(strong,nonatomic) UIScrollView* wholeScroll;
@property(strong,nonatomic) UIScrollView* ad_scroll;

@property (strong,nonatomic) NSMutableArray *slideImages;// 广告栏的图片数组
@property (strong,nonatomic)UIPageControl *pageControl;

@end
