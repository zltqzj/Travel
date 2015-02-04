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
    self.view.backgroundColor = MAIN_COLOR;
    [self.tabBarController.tabBar setHidden:NO];
 
    
    // 列表的数据源
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Recommand" ofType:@"plist"];
    NSArray* listData = [NSArray arrayWithContentsOfFile:plistPath];
    _listData = [NSMutableArray arrayWithArray:listData];
    
    
    
    NSArray *testArray = @[ @[ @"全部海南", @"三亚", @"天涯海角", @"海口", @"亚龙湾" , @"蜈支洲岛"], @[@"推荐", @"30天销量",@"满意度",@"价格由高到低",@"价格由低到高"], @[@"筛选"] ];
    
    

    
    _wholeScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
    _wholeScroll.backgroundColor = MAIN_COLOR;
    [self.view addSubview:_wholeScroll];
    
    MXPullDownMenu *menu = [[MXPullDownMenu alloc] initWithArray:testArray selectedColor:MAIN_COLOR];
    menu.delegate = self;
    menu.frame = CGRectMake(0, 0, SCREEN_WIDTH, menu.frame.size.height);
    [_wholeScroll addSubview:menu];
    /*
    // 四个view
    NSInteger hotelWidth = (SCREEN_WIDTH-15) /2;
    
    _sellView1   = [[[NSBundle mainBundle] loadNibNamed:@"SellView" owner:self options:nil] lastObject];
    _sellView1.frame = CGRectMake(5, 5, hotelWidth, hotelWidth*0.75);
    _sellView1.backgroundColor = [UIColor orangeColor];
    [_wholeScroll addSubview:_sellView1];
    NSArray* arr = _listData[1];
    [_sellView1.titleLabel setText: @"天涯海角"];
  //  _sellView1.imageview.image = [UIImage imageNamed:@"voice_hotel_checked"];
    
    
    _sellView2 =[[[NSBundle mainBundle] loadNibNamed:@"SellView" owner:self options:nil] lastObject];
    _sellView2.frame = CGRectMake(SCREEN_WIDTH-5-hotelWidth, 5, hotelWidth, hotelWidth*0.75);
    [_wholeScroll addSubview:_sellView2];
    //_sellView2.imageview.image = [UIImage imageNamed:@"voice_hotel_checked"];


    _sellView3 = [[[NSBundle mainBundle] loadNibNamed:@"SellView" owner:self options:nil] lastObject];
    _sellView3.frame = CGRectMake(5, ORINGIN_Y(_sellView1)+VIEW_HEIGHT(_sellView1)+5, hotelWidth, hotelWidth*0.75);
    [_wholeScroll addSubview:_sellView3];
    
    
    _sellView4 = [[[NSBundle mainBundle] loadNibNamed:@"SellView" owner:self options:nil] lastObject];
    _sellView4.frame = CGRectMake(SCREEN_WIDTH-5-hotelWidth, ORINGIN_Y(_sellView1)+VIEW_HEIGHT(_sellView1)+5, hotelWidth, hotelWidth*0.75);
    [_wholeScroll addSubview:_sellView4];
    [_sellView4.priceLabel setText: @"天涯海角"];
*/
    
    _billTable  = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH,  _listData.count*60) style:UITableViewStylePlain];
    _billTable.delegate = self;
    _billTable.dataSource = self;
    [_billTable setScrollEnabled:NO];
    [_billTable registerClass:[BillCell class] forCellReuseIdentifier:@"BillCell"];
    [_wholeScroll addSubview:_billTable];
    [_wholeScroll setScrollEnabled:YES];
    [_wholeScroll setContentSize:CGSizeMake(SCREEN_WIDTH,  _listData.count*60 )];
    [self setExtraCellLineHidden:_billTable];
    
    
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor =MAIN_COLOR;// [UIColor whiteColor];
    [tableView setTableFooterView:view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _listData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailViewController* productDetail =[[ProductDetailViewController alloc] init];// viewOnSb(@"productDetail");
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:productDetail animated:YES];
    
}

#pragma mark - MXPullDownMenuDelegate
- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row{
    
}
-(void)ScrollEnable:(BOOL)scrollEnable{
    if (scrollEnable ==NO) {
        _wholeScroll.scrollEnabled = NO;
    }
    else{
        _wholeScroll.scrollEnabled = YES;
    }
}


@end
