//
//  ScenryDescViewController.m
//  Travel
//
//  Created by ZKR on 3/7/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "ScenryDescViewController.h"
#import "config.h"
#import "SecenryDescCollectionViewCell.h"
#import "SceneryDetailViewController.h"
@interface ScenryDescViewController ()

@end

@implementation ScenryDescViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SETTING_NAVGATION_STYLE
    self.title = @"景区";
    [self.tabBarController.tabBar setHidden:NO];

    _imageURLs = @[@"tyhj.jpg",@"ntwq.jpg",@"wzz.jpg",@"nss.jpg"];
    
    
    _sv = [[AsyncScrollView alloc] initWithFrame:CGRectMake(0, 78, SCREEN_WIDTH, 110) andImageArray:_imageURLs];
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    [self.view addSubview:_sv];
    [_sv addTimer];
    
    
    NSArray* imageArr = @[@"tyhj.jpg",@"ntwq.jpg",@"nss.jpg",@"wzz.jpg",@"fhl.jpg", @"mlzg.jpg",
    @"blg.jpg",@"ynd.jpg",        @"fjz.jpg",@"lht.jpg",  @"hhp.jpg",@"qhysg.jpg"];// 12个
    NSArray* btnTitle = @[@"天涯海角", @"南田温泉",  @"南山寺",  @"蜈支洲" , @"凤凰岭公园",@"美丽之冠",        @"槟榔谷",@"呀诺达热态旅游公园",@"分界洲岛",@"鹿回头风景区",@"好汉坡温泉",@"三亚奇幻艺术馆"];// 12个
    
    NSArray* btnBgColor = @[RGB(255, 182, 193),RGB(245, 199, 243),RGB(135, 237, 207),RGB(124, 176, 248),RGB(244, 164, 96),RGB(176, 216, 230),RGB(255, 182, 193),RGB(245, 199, 243),RGB(135, 237, 207),RGB(124, 176, 248),RGB(244, 164, 96),RGB(176, 216, 230)];
    _listData = [[NSArray alloc] initWithObjects:imageArr,btnTitle,btnBgColor , nil];
    
    // 自己写列表去实现。
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
  
    flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH-20)/3,(SCREEN_WIDTH-20)/3  );

    
    if (SCREEN_WIDTH<321) {
        flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH-20)/3,(SCREEN_WIDTH-20)/3  );
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);


    }else if (SCREEN_WIDTH<376 && SCREEN_WIDTH>321){
        flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH-20)/3,(SCREEN_WIDTH-20)/3  );
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);


    }
    else if (SCREEN_WIDTH>400){
        flowLayout.itemSize=CGSizeMake((SCREEN_WIDTH-30)/3,(SCREEN_WIDTH-30)/3  );
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);


    }
    flowLayout.minimumInteritemSpacing   = 5;//The minimum spacing to use between items in the same row.同一行的两个item的间距的最小值
    flowLayout.minimumLineSpacing = 5;//The minimum spacing to use between items in the same row.
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
  //  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    [_collectionView setCollectionViewLayout:flowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[SecenryDescCollectionViewCell class] forCellWithReuseIdentifier:@"SecenryDescCollectionViewCell"];
    [self.view addSubview:_collectionView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_listData[0] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SecenryDescCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SecenryDescCollectionViewCell" forIndexPath:indexPath];
    NSArray* imageArr = _listData[0];
    NSArray* titleArr = _listData[1];
   // NSArray* bgColor = _listData[2];
    cell.iconImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
    cell.descLabel.text = titleArr[indexPath.row];

    cell.descLabel.layer.cornerRadius = CGRectGetHeight([cell.descLabel bounds]) / 2;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    NSInteger row = indexPath.row;
    NSLog(@"%ld",(long)row);
    SceneryDetailViewController* detail = [[SceneryDetailViewController alloc] init];
    detail.numberIndex = row;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:detail animated:YES];
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
