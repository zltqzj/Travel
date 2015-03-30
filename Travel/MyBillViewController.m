//
//  MyBillViewController.m
//  Travel
//
//  Created by ZKR on 1/6/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "MyBillViewController.h"
#import "config.h"
#import "BillCell.h"
#import "ProductDetailViewController.h"
#import "CreateCustomTableViewController.h"

@implementation MyBillViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    SETTING_NAVGATION_STYLE
    self.title = @"特卖";
    self.view.backgroundColor =[UIColor whiteColor];
    [self.tabBarController.tabBar setHidden:NO];
 
    
    // 列表的数据源
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Recommand" ofType:@"plist"];
    NSArray* listData = [NSArray arrayWithContentsOfFile:plistPath];
    _listData = [NSMutableArray arrayWithArray:listData];
    
    
    
    NSArray *testArray = @[ @[ @"全部海南", @"三亚", @"天涯海角", @"海口", @"亚龙湾" , @"蜈支洲岛"], @[@"推荐", @"30天销量",@"满意度",@"价格由高到低",@"价格由低到高"], @[@"筛选"] ];
    
    // 数据
//    self.classifys = @[@"美食",@"今日新单",@"电影",@"酒店"];
//    self.cates = @[@"自助餐",@"快餐",@"火锅",@"日韩料理",@"西餐",@"烧烤小吃"];
//    self.movices = @[@"内地剧",@"港台剧",@"英美剧"];
//    self.hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店"];
//    self.areas = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
//    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
    
    // 第一个 定制游，自助游，周边游，跟团游
    self.movices = @[@"定制游",@"周边游",@"跟团游"];
    // 第二个  @"全部海南", @"三亚", @"天涯海角", @"海口", @"亚龙湾" , @"蜈支洲岛"
    self.areas = @[@"全部海南", @"三亚", @"天涯海角", @"海口", @"亚龙湾" , @"蜈支洲岛"];

    //第三个 @"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"
    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];

    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];

    
    _billTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH,  SCREEN_HEIGHT-108-50) style:UITableViewStylePlain];
    _billTable.delegate = self;
    _billTable.dataSource = self;
     [_billTable registerClass:[BillCell class] forCellReuseIdentifier:@"BillCell"];
    [self.view addSubview:_billTable];
 
    [self setExtraCellLineHidden:_billTable];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor =  [UIColor whiteColor];
    [tableView setTableFooterView:view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma  mark - 
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.movices.count;
    }else if (column == 1){
        return self.areas.count;
    }else {
        return self.sorts.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.movices[indexPath.row];
    } else if (indexPath.column == 1){
        return self.areas[indexPath.row];
    } else {
        return self.sorts[indexPath.row];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
//    if (column == 0) {
//        if (row == 0) {
//            return self.cates.count;
//        } else if (row == 2){
//            return self.movices.count;
//        } else if (row == 3){
//            return self.hostels.count;
//        }
//    }
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
//    if (indexPath.column == 0) {
//        if (indexPath.row == 0) {
//            return self.cates[indexPath.item];
//        } else if (indexPath.row == 2){
//            return self.movices[indexPath.item];
//        } else if (indexPath.row == 3){
//            return self.hostels[indexPath.item];
//        }
//    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item >= 0) {
      //  NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
    }else {
      //  NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}



#pragma mark - UITableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _listData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BillCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BillCell" forIndexPath:indexPath];
    NSArray* arr = _listData[indexPath.row];
    cell.contentLabel.text = arr[1];
    cell.priceLabel.text = arr[2];
    cell.percentLabel.text = arr[3];
    cell.avatarImage.image =[UIImage imageNamed:arr[4]] ; //[UIImage imageNamed:@"Icon-60"];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma  mark - UITableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailViewController* productDetail =[[ProductDetailViewController alloc] init];// viewOnSb(@"productDetail");
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:productDetail animated:YES];
    
}




@end
