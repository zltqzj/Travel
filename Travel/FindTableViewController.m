//
//  FindTableViewController.m
//  Travel
//
//  Created by ZKR on 1/7/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "FindTableViewController.h"
#import "config.h"
#import "FindCollectionViewCell.h"
#import "DiaryTableViewCell.h"
#import "ProfileViewController.h"
@interface FindTableViewController ()

@end

@implementation FindTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:NO];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FindCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FindCollectionViewCell" forIndexPath:indexPath];
    cell.iconImage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.descLabel.text = _descArray[indexPath.row];
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SETTING_NAVGATION_STYLE
    [self.tabBarController.tabBar setHidden:NO];

    self.title = @"发现";
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];

    if(SCREEN_WIDTH<321){
        flowLayout.itemSize=CGSizeMake(72,72 ); //The default size to use for cells.
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 2);
    }
    else{
        flowLayout.itemSize=CGSizeMake(80,80 );
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);

    }

    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    
    _imageArray  = @[@"destination_tab_must_read",@"destination_tab_city",@"destination_tab_food",@"destination_tab_shopping",@"destination_tab_plan",@"destination_tab_activity",@"destination_tab_traffic",@"destination_tab_remote"];
    _descArray = @[@"出行必读",@"城市攻略",@"美食",@"购物",@"行程",@"活动",@"本地交通",@"如何到达"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[FindCollectionViewCell class] forCellWithReuseIdentifier:@"FindCollectionViewCell"];
    [_collectionView setCollectionViewLayout:flowLayout];
    
   
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mainpage_my_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(my:)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}


// 分享。
-(void)my:(id)sender{
    ProfileViewController* profile = [[ProfileViewController alloc] init];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:profile animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (tableView.tag ==100) {
        return 3;

    }
    else{
        return 3;
    }
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag ==100) {
        return 2;
    }
    // Return the number of rows in the section.
    return 1;
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
