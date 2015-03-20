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
#import "MainTableViewCell.h"
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 580;//SCREEN_HEIGHT-20-44-50;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MainTableViewCell" forIndexPath:indexPath];
    cell.redBag.tag = 100;
   // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //[cell.redBag addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.gyBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.zdfBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [cell.jsycBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [cell.tjjpBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [cell.jdBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [cell.jpBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [cell.jrthBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

  
    
    [cell.lydjBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.jdmpBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.tgBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.yczjBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [cell.glBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.dypBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.zmyBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.hcpBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.hwddBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    
  
    
    return cell;
}

-(void)click:(id)sender{
    NSLog(@"1231231");
    UIButton* btn = (UIButton*)sender;
    CABasicAnimation *k = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    k.fromValue = @(1);
    k.toValue = @(0.8);
    k.duration = 1;
    k.autoreverses = YES;
    // k.repeatCount = INT32_MAX;
    [btn.layer addAnimation:k forKey:@"SHOW"]; // 点赞的动画
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    SETTING_NAVGATION_STYLE
    self.title = @"首页";
    [self.tabBarController.tabBar setHidden:NO];

    _myTable.delegate = self;
    _myTable.dataSource = self;
    [_myTable registerClass:[MainTableViewCell class] forCellReuseIdentifier:@"MainTableViewCell"];
    [_myTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_myTable setAllowsSelection:NO];
    // 定时器
     [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(shake) userInfo:nil repeats:YES];
    
    
    // 下拉的贝赛尔曲线效果
  //  self.storeHouseRefreshControl = [CBStoreHouseRefreshControl attachToScrollView:self.wholeScroll target:self refreshAction:@selector(refreshTriggered) plist:@"storehouse" color:MAIN_COLOR lineWidth:1.5 dropHeight:80 scale:1 horizontalRandomness:150 reverseLoadingAnimation:YES internalAnimationFactor:0.5];
  //  _wholeScroll.delegate = self;

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
    UIButton* redBag = (UIButton*)[self.view viewWithTag:100];
    [redBag.layer addAnimation:shake forKey:@"shake"];
  //  [_hotel_view.redBagBtn.layer addAnimation:shake forKey:@"shake"];

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
