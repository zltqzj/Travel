//
//  ProfileViewController.m
//  Travel
//
//  Created by ZKR on 1/5/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "ProfileViewController.h"
#import "XHPathCover.h"
#import "UIButton+WebCache.h"
#import "config.h"
#import "PathCoverDelegate.h"
#import "ModifyViewController.h"
#import "AboutViewController.h"
#import "MyTravelPlanViewController.h"
@interface ProfileViewController ()<PathCoverDelegate>

@property (nonatomic, strong) XHPathCover *pathCover;
@property (nonatomic, strong) NSMutableArray* listData;

@end

@implementation ProfileViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self.tabBarController.tabBar setHidden:YES];

    SETTING_NAVGATION_STYLE
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Profile" ofType:@"plist"];
    NSArray* listData = [NSArray arrayWithContentsOfFile:plistPath];
    _listData = [NSMutableArray arrayWithArray:listData];
    
    
    _profileTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _profileTable.dataSource = self;
    _profileTable.delegate = self;
    [self setExtraCellLineHidden:_profileTable];
    [_profileTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_profileTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
   // _profileTable.backgroundColor = MAIN_COLOR;
    [self.view addSubview:_profileTable];
    
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 140)];
    _pathCover.backgroundColor = MAIN_COLOR;
  //  self.view.backgroundColor = MAIN_COLOR;
    [_pathCover setBackgroundImage:[self imageWithColor:MAIN_COLOR]];
    [_pathCover setAvatarImage:[UIImage imageNamed:@"default_thumbnail"]];

    _pathCover.userNameLabel.text = @"赵健";
    _pathCover.descLabel.text = @"18658054127";
    _pathCover.isZoomingEffect = YES;
    _profileTable.tableHeaderView = self.pathCover;
    _pathCover.pathDelegate = self;
    
    __weak ProfileViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    [_pathCover setHandleTapBackgroundImageEvent:^{
       // [wself.pathCover setBackgroundImage:[UIImage imageNamed:@"AlbumHeaderBackgrounImage"]];
    }];
    
    // Do any additional setup after loading the view.
}


#pragma mark - PathCoverDelegate


-(void)avatarClickEvent{
    [self modifyProfile];
}

-(void)bannerClickEvent{
    [self modifyProfile];

}

-(void)detailBtnClickEvent{
    [self modifyProfile];
}


-(void)modifyProfile{
    ModifyViewController* modify = [[ModifyViewController alloc] init];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:modify animated:YES];
}


-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
}



- (void)_refreshing {
    // refresh your data sources
    
    __weak ProfileViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //[wself getClubDetailInfo];//进行网络请求获取数据
        [wself.pathCover stopRefresh];
        
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark- scroll delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView];
    NSLog(@"%f",scrollView.contentOffset.y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _listData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_listData[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray* descArr = _listData[indexPath.section];
    
    cell.textLabel.text = descArr[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"%ld,%ld",(long)indexPath.row,(long)indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section ==4 && indexPath.row == 0) {
//        AboutViewController* about = [[AboutViewController alloc ] init];
//        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//        [self.navigationController pushViewController:about animated:YES];
    }
    else if(indexPath.section ==1 && indexPath.row == 0){ // 我的行程
        MyTravelPlanViewController* myPlan = [[MyTravelPlanViewController alloc] init];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        NSLog(@"%@",cell.textLabel.text);
        [self.navigationController pushViewController:myPlan animated:YES];
    }
  
//    if ([cell.textLabel.text isEqualToString:@"关于"]) {
//        AboutViewController* about = [[AboutViewController alloc ] init];
//        [self.navigationController pushViewController:about animated:YES];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)dealloc{
    NSLog(@"个人主页界面销毁");
}

@end
