//
//  MainPageViewController.m
//  Travel
//
//  Created by ZKR on 1/4/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "MainPageViewController.h"
#import "config.h"
#import "SpecialView.h"
#import "CreateCustomTableViewController.h"
#define RED RGB(245,91,59)
#define PINK RGB(130,100,239)
#define ORANGE RGB(246,136,58)
#define BLUE RGB(40,136,203)
#define LIGHT_GREEN RGB(138,179,70)
#define DARK_GREEN RGB(0,161,148)


@interface MainPageViewController ()<UIScrollViewDelegate>

@property(weak,nonatomic) IBOutlet SpecialView* hotel_view;// 酒店
@property(weak,nonatomic) IBOutlet SpecialView* airTicket_view;// 机票
@end

@implementation MainPageViewController


-(UIButton*)getButton:(CGRect)rect type:(UIButtonType)type title:(NSString*)title titleColor:(UIColor*)titleColor bgColor:(UIColor*)bgColor image:(UIImage*)image{
    UIButton* btn = [UIButton buttonWithType:type];
    btn.frame = rect;
    if (title !=nil) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (image !=nil) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (titleColor!=nil) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (bgColor != nil) {
        btn.backgroundColor = bgColor;
    }
    return btn;
}


-(UIButton*)getButton:(CGRect)rect type:(UIButtonType)type title:(NSString*)title titleColor:(UIColor*)titleColor image:(UIImage*)image setTitleEdgeInsets:(UIEdgeInsets)titleEdgeInsets setImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets {
    UIButton* btn = [UIButton buttonWithType:type];
    btn.frame = rect;
    if (title !=nil) {
        
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (image !=nil) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (titleColor!=nil) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    [btn setTitleEdgeInsets:titleEdgeInsets];
    [btn setImageEdgeInsets:imageEdgeInsets];
    return btn;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    SETTING_NAVGATION_STYLE
    self.title = @"首页";
    [self.tabBarController.tabBar setHidden:NO];

    // 整个页面的滑动
    _wholeScroll  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_wholeScroll];
    _wholeScroll.scrollEnabled = YES;
    _wholeScroll.contentSize  = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+100);
    _wholeScroll.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    

    // 定时器 循环
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    // 广告栏
    _ad_scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
    _ad_scroll.bounces = YES;
    _ad_scroll.pagingEnabled = YES;
    _ad_scroll.delegate = self;
    _ad_scroll.tag = 100;
    _ad_scroll.userInteractionEnabled = YES;
    _ad_scroll.showsHorizontalScrollIndicator = NO;
    [_wholeScroll addSubview:_ad_scroll];
    
    // 初始化 数组 并添加四张图片
    _slideImages = [[NSMutableArray alloc] init];
    [_slideImages addObject:@"bg_product_moren"];
    [_slideImages addObject:@"bg_pic_header_default"];
    [_slideImages addObject:@"bg_zhaomu"];
    [_slideImages addObject:@"bg_ddr_list_default"];
    
    
    // 初始化 pagecontrol
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120,92,100,18)]; // 初始化mypagecontrol
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    _pageControl.numberOfPages = [self.slideImages count];
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [_ad_scroll addSubview:_pageControl];
    
    
    // 创建四个图片 imageview
    for (int i = 0;i<[_slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((SCREEN_WIDTH * i) + SCREEN_WIDTH, 0, SCREEN_WIDTH, 110);
        [_ad_scroll addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
    }

    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_slideImages objectAtIndex:([_slideImages count]-1)]]];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 110); // 添加最后1页在首页 循环
    [_ad_scroll addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_slideImages objectAtIndex:0]]];
    imageView.frame = CGRectMake((SCREEN_WIDTH * ([_slideImages count] + 1)) , 0, SCREEN_WIDTH, 110); // 添加第1页在最后 循环
    [_ad_scroll addSubview:imageView];
    [_ad_scroll setContentSize:CGSizeMake(SCREEN_WIDTH * ([_slideImages count] + 2), 110)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [_ad_scroll setContentOffset:CGPointMake(0, 0)];
    [_ad_scroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,110) animated:YES]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页
    
    
    // 四个btn
    float width_btn = (SCREEN_WIDTH-25)/4;
    float y_btn = 115;
                           
    _cheapSaleToday_btn = [self getButton:CGRectMake(5, y_btn, width_btn, width_btn*0.75) type:UIButtonTypeCustom title:@"今日特惠" titleColor:[UIColor whiteColor]  bgColor:RED  image:nil];
                           
                           
    [_wholeScroll addSubview:_cheapSaleToday_btn];
    /////////////////////
    _department_btn = [self getButton:CGRectMake(5*2+width_btn, y_btn, width_btn, width_btn*0.75) type:UIButtonTypeCustom title:@"公寓" titleColor:[UIColor whiteColor] bgColor:RED image:nil];
    [_wholeScroll addSubview:_department_btn];
    /////////////////////
    _hourHouse_btn = [self getButton:CGRectMake(5*3+width_btn*2, y_btn, width_btn, width_btn*0.75) type:UIButtonTypeCustom title:@"钟点房" titleColor:[UIColor whiteColor]  bgColor:RED image:nil];
    [_wholeScroll addSubview:_hourHouse_btn];

    /////////////////////

    _orderCar_btn = [self getButton:CGRectMake(SCREEN_WIDTH-width_btn-5, y_btn, width_btn, width_btn*0.75) type:UIButtonTypeCustom title:@"接送用车" titleColor:[UIColor whiteColor] bgColor:PINK image:nil];
    
    _orderCar_btn.backgroundColor = [UIColor orangeColor];
    [_wholeScroll addSubview:_orderCar_btn];

    //中间两个大按钮
    
    NSInteger hotelWidth = (SCREEN_WIDTH-15) /2;
   
    _hotel_view   = [[[NSBundle mainBundle] loadNibNamed:@"SpecialView" owner:self options:nil] lastObject];
    _hotel_view.frame = CGRectMake(5, ORINGIN_Y(_orderCar_btn)+VIEW_HEIGHT(_orderCar_btn)+5, hotelWidth, hotelWidth*0.75);
    _hotel_view.backgroundColor = RED;
    
    _hotel_view.imageview.image = [UIImage imageNamed:@"home_hotel"];
    [_hotel_view.redBagBtn setImage:[UIImage imageNamed:@"redpacket_for_qunar"] forState:UIControlStateNormal];
    
    [_wholeScroll addSubview:_hotel_view];
    
    
    _airTicket_view =[[[NSBundle mainBundle] loadNibNamed:@"SpecialView" owner:self options:nil] lastObject];
    _airTicket_view.frame = CGRectMake(5*2+hotelWidth, ORINGIN_Y(_orderCar_btn)+VIEW_HEIGHT(_orderCar_btn)+5, hotelWidth, hotelWidth*0.75);
    _airTicket_view.backgroundColor = PINK;
    _airTicket_view.titleLabel.text = @"机票";
    _airTicket_view.imageview.image = [UIImage imageNamed:@"home_flight"];

    _airTicket_view.descLabel.text = @"国内国际机票一折起";
    [_airTicket_view.redBagBtn setImage:[UIImage imageNamed:@"blank"] forState:UIControlStateNormal];
   

    [_wholeScroll addSubview:_airTicket_view];
    
    
    // 周末游
    _weekendTravel_btn = [self getButton:CGRectMake(5, ORINGIN_Y(_airTicket_view)+VIEW_HEIGHT(_airTicket_view)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"周末游" titleColor:[UIColor whiteColor] bgColor:ORANGE image:[UIImage imageNamed:@"home_vacation_around"]];
    [_weekendTravel_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];

    [_wholeScroll addSubview:_weekendTravel_btn];
    
    // 团购
    _buyTogether_btn = [self getButton:CGRectMake(5*2+hotelWidth, ORINGIN_Y(_airTicket_view)+VIEW_HEIGHT(_airTicket_view)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"团购" titleColor:[UIColor whiteColor] bgColor:BLUE image:[UIImage imageNamed:@"home_groupbuy"]];
    [_buyTogether_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];

    [_wholeScroll addSubview:_buyTogether_btn];
    
    //景点门票
    _seneryTicket_btn =[self getButton:CGRectMake(5, ORINGIN_Y(_weekendTravel_btn)+VIEW_HEIGHT(_weekendTravel_btn)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"景点门票" titleColor:[UIColor whiteColor] bgColor:ORANGE image: [UIImage imageNamed:@"home_scenery"]];
    [_seneryTicket_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];

    [_wholeScroll addSubview:_seneryTicket_btn];
   
    // 攻略
    _travelMethod_btn =  [self getButton:CGRectMake(5*2+hotelWidth, ORINGIN_Y(_weekendTravel_btn)+VIEW_HEIGHT(_weekendTravel_btn)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"攻略" titleColor:[UIColor whiteColor] bgColor:BLUE image:[UIImage imageNamed:@"home_gonglue"]];
    [_travelMethod_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];

    [_wholeScroll addSubview:_travelMethod_btn];
    
    // 用车自驾
    _ownCar_btn =[self getButton:CGRectMake(5, ORINGIN_Y(_seneryTicket_btn)+VIEW_HEIGHT(_seneryTicket_btn)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"用车自驾" titleColor:[UIColor whiteColor] bgColor:LIGHT_GREEN image:[UIImage imageNamed:@"home_ut"]];
    [_ownCar_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];

    [_wholeScroll addSubview:_ownCar_btn];
    
    // 旅游度假
    _holiday_btn =[self getButton:CGRectMake(5*2+hotelWidth, ORINGIN_Y(_travelMethod_btn)+VIEW_HEIGHT(_travelMethod_btn)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"旅游度假" titleColor:[UIColor whiteColor] bgColor:DARK_GREEN image:[UIImage imageNamed:@"home_travel"]];
    [_holiday_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];

    [_wholeScroll addSubview:_holiday_btn];
    
    // 火车票
    _trainTicket_btn =[self getButton:CGRectMake(5, ORINGIN_Y(_ownCar_btn)+VIEW_HEIGHT(_ownCar_btn)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"火车票" titleColor:[UIColor whiteColor] bgColor:LIGHT_GREEN image:[UIImage imageNamed:@"home_train"]];
    [_trainTicket_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];

    [_wholeScroll addSubview:_trainTicket_btn];
    
    //当地人
    _localMan_btn =[self getButton:CGRectMake(5*2+hotelWidth, ORINGIN_Y(_ownCar_btn)+VIEW_HEIGHT(_ownCar_btn)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"当地人" titleColor:[UIColor whiteColor] bgColor:DARK_GREEN image:[UIImage imageNamed:@"home_lvtu"]];
    [_wholeScroll addSubview:_localMan_btn];
    [_localMan_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];
    
    // 骆驼书
    _camelBook_btn =[self getButton:CGRectMake(5, ORINGIN_Y(_localMan_btn)+VIEW_HEIGHT(_localMan_btn)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"骆驼书" titleColor:[UIColor whiteColor] bgColor:RGB(0,206,209) image:[UIImage imageNamed:@"home_lvtu"]];
    [_camelBook_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];

    [_wholeScroll addSubview:_camelBook_btn];
    
    
    // 签证
    _visa_btn =[self getButton:CGRectMake(5*2+hotelWidth, ORINGIN_Y(_localMan_btn)+VIEW_HEIGHT(_localMan_btn)+5, hotelWidth, hotelWidth/3) type:UIButtonTypeCustom title:@"签证" titleColor:[UIColor whiteColor] bgColor:RGB(0,206,209) image:[UIImage imageNamed:@"home_visa"]];
    [_visa_btn addTarget:self action:@selector(animationClick:) forControlEvents:UIControlEventTouchDown];

    [_wholeScroll addSubview:_visa_btn];
    
    _wholeScroll.contentSize  = CGSizeMake(SCREEN_WIDTH, ORINGIN_Y(_visa_btn)+VIEW_HEIGHT(_visa_btn)+5);
    
    
    // 下拉的贝赛尔曲线效果
  //  self.storeHouseRefreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.wholeScroll target:self refreshAction:@selector(refreshTriggered) plist:@"storehouse" color:MAIN_COLOR lineWidth:1.5 dropHeight:80 scale:1 horizontalRandomness:150 reverseLoadingAnimation:YES internalAnimationFactor:0.5];
    _wholeScroll.delegate = self;

    // Do any additional setup after loading the view.
}





-(void)animationClick:(id)sender{
    UIButton* btn = (UIButton*)sender;
    CABasicAnimation *k = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    k.fromValue = @(1);
    k.toValue = @(0.8);
    k.duration = 1;
    k.autoreverses = YES;
   // k.repeatCount = INT32_MAX;
    [btn.layer addAnimation:k forKey:@"SHOW"]; // 点赞的动画
}

-(void)shake{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.3];
    shake.toValue = [NSNumber numberWithFloat:+0.3];
    shake.duration = 0.1f;
    shake.repeatCount = 2;
    shake.autoreverses = YES;
    [_hotel_view.redBagBtn.layer addAnimation:shake forKey:@"shake"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (sender.tag  ==100) {
        CGFloat pagewidth = _ad_scroll.frame.size.width;
        int page = floor((_ad_scroll.contentOffset.x - pagewidth/([_slideImages count]+2))/pagewidth)+1;
        page --;  // 默认从第二页开始
        _pageControl.currentPage = page;
    }
    else{
    }
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = _ad_scroll.frame.size.width;
    NSInteger currentPage = floor((_ad_scroll.contentOffset.x - pagewidth/ ([_slideImages count]+2)) / pagewidth) + 1;
    //    int currentPage_ = (int)self.scrollView.contentOffset.x/320; // 和上面两行效果一样
    //    NSLog(@"currentPage_==%d",currentPage_);
    if (currentPage==0)
    {
        [_ad_scroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH * [_slideImages count],0,SCREEN_WIDTH,110) animated:YES]; // 序号0 最后1页
    }
    else if (currentPage==([_slideImages count]+1))
    {
        [_ad_scroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH,0,SCREEN_WIDTH,110) animated:YES]; // 最后+1,循环第1页
    }
}

// pagecontrol 选择器的方法
- (void)turnPage
{
    NSInteger page = _pageControl.currentPage; // 获取当前的page
    [_ad_scroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH*(page+1),0,SCREEN_WIDTH,110) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    NSInteger page = _pageControl.currentPage; // 获取当前的page
    page++;
    page = page > 3 ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];
    [self shake];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
