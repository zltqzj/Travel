//
//  VoiceViewController.m
//  Travel
//
//  Created by ZKR on 1/7/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "VoiceViewController.h"
#import "config.h"
#import "CustomCollectionViewCell.h"
#import "CreateCustomTableViewController.h"
#import "AppDelegate.h"

//#import "CBStoreHouseRefreshControl.h"

@interface VoiceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
//@property(weak,nonatomic) CBStoreHouseRefreshControl* storeHouseRefreshControl;



@end

@implementation VoiceViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:NO];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    SETTING_NAVGATION_STYLE
    self.title = @"定制";
    NSArray* imageArr = @[@"view1.jpg",@"view2.jpg",@"view3.jpg",@"view4.jpg",@"view1.jpg",@"view3.jpg"];
    NSArray* btnTitle  = @[@"家庭亲子",@"情侣度假",@"蜜月旅行",@"闺密旅行",@"公司出游",@"说走就走"];
    NSArray* btnBgColor = @[RGB(255, 182, 193),RGB(245, 199, 243),RGB(135, 237, 207),RGB(124, 176, 248),RGB(244, 164, 96),RGB(176, 216, 230)];
    _listData = [[NSArray alloc] initWithObjects:imageArr,btnTitle,btnBgColor , nil];

    // 自己写列表去实现。
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH-20)/2,(SCREEN_WIDTH-20)/2  ); //The default size to use for cells.
    NSLog(@"%f  %f",flowLayout.itemSize.height,flowLayout.itemSize.width);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);//If the delegate object does not implement the collectionView:layout:insetForSectionAtIndex: method, the flow layout uses the value in this property to set the margins for each section.
    flowLayout.minimumInteritemSpacing   = 5;//The minimum spacing to use between items in the same row.同一行的两个item的间距的最小值
    flowLayout.minimumLineSpacing = 5;//The minimum spacing to use between items in the same row.
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"aaa"];
    [self.view addSubview:_collectionView];
    
 //self.storeHouseRefreshControl = [CBStoreHouseRefreshControl attachToScrollView:_collectionView target:self refreshAction:@selector(refreshTriggered) plist:@"storehouse" color:[UIColor cyanColor] lineWidth:2.5 dropHeight:80 scale:1 horizontalRandomness:150 reverseLoadingAnimation:YES internalAnimationFactor:0.5];
    
    // Do any additional setup after loading the view.
    
    
  //  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(test)];

}



-(void)test{
    
  //  AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  //  [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[CreateCustomTableViewController alloc] initWithStyle:UITableViewStyleGrouped]] animated:NO completion:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        CreateCustomTableViewController* create = [[CreateCustomTableViewController alloc] init];
        [self presentViewController:create animated:YES completion:nil];
    });
  
   // [delegate.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:[[CreateCustomTableViewController alloc] initWithStyle:UITableViewStyleGrouped]] animated:NO completion:nil];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //[self.storeHouseRefreshControl scrollViewDidEndDragging];
}

- (void)refreshTriggered
{
    //call your loading method here
    
    //Finshed loading the data, reset the refresh control
   // [self.storeHouseRefreshControl finishingLoading];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    //[self.storeHouseRefreshControl scrollViewDidScroll];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_listData[0] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CustomCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aaa" forIndexPath:indexPath];
    NSArray* imageArr = _listData[0];
    NSArray* titleArr = _listData[1];
    NSArray* bgColor = _listData[2];
    cell.descImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
    [cell.descButton setTitle:titleArr[indexPath.row] forState:UIControlStateNormal];
    [cell.descButton setBackgroundColor:bgColor[indexPath.row]];
    cell.descButton.layer.cornerRadius = CGRectGetHeight([cell.descButton bounds]) / 2;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
   //   [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[CreateCustomTableViewController alloc] initWithStyle:UITableViewStyleGrouped]] animated:YES completion:nil];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    [self.navigationController pushViewController:[[CreateCustomTableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller
}
*/

@end
