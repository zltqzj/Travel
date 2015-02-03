//
//  ProductDetailViewController.m
//  Travel
//
//  Created by ZKR on 1/14/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "config.h"
#import "XHPathCover.h"
#import "PathCoverDelegate.h"
#import "LXActionSheet.h"
#define TITLE_FONT_SIZE 18
#define DESCRIBE_FONT_SIEZE 15

@interface ProductDetailViewController ()<PathCoverDelegate,LXActionSheetDelegate>

@property (nonatomic, strong) XHPathCover *pathCover;

@end

@implementation ProductDetailViewController


- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size label:(UILabel*)label{
    CGSize resultSize = CGSizeZero;
 
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:label.text attributes:@{NSFontAttributeName:font}];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //[paragraphStyle setLineSpacing:2.0];
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, [label.text length])];
    resultSize = [attributedStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;

    return resultSize;
}

-(UILabel*)getLabel:(CGRect)frame textColor:(UIColor*)textColor text:(NSString*)text font:(UIFont*)font textAligment:(NSTextAlignment)textAligment{
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = textColor;
    label.text = text;
    label.font  = font;
    label.textAlignment = textAligment;
    return label;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品详情";
   
    
    

     SETTING_NAVGATION_STYLE
    [self.tabBarController.tabBar setHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    // 全屏的滚动
    _wholeScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_wholeScroll];
    
    // 最上面的大图
    _bannerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    _bannerImage.image = [UIImage imageNamed:@"view1.jpg"];
    [_wholeScroll addSubview:_bannerImage];
    
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, VIEW_HEIGHT(_bannerImage)+5, SCREEN_WIDTH-10, 30)];
    _titleLabel.text = @"[春节]海南5日游";
    _titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
    [_wholeScroll addSubview:_titleLabel];
    // 描述
    _describeLabel = [[UILabel alloc] init];
    _describeLabel.numberOfLines = 0;
    _describeLabel.text = @"春节最高减6000，8大景点CDF免税，4晚海景0自费，疯玩Sanya！";
    _describeLabel.font = [UIFont systemFontOfSize:DESCRIBE_FONT_SIEZE];
    _describeLabel.frame = CGRectMake(5, ORINGIN_Y(_titleLabel)+VIEW_HEIGHT(_titleLabel), SCREEN_WIDTH-10, [self getSizeWithFont:[UIFont systemFontOfSize:DESCRIBE_FONT_SIEZE] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 100) label:_describeLabel].height);
    [_wholeScroll addSubview:_describeLabel];
    
    // 聊天按钮
    _chatBtn = [self getButton:CGRectMake(5, ORINGIN_Y(_describeLabel)+VIEW_HEIGHT(_describeLabel)+5, 80, 30) type:UIButtonTypeCustom title:nil titleColor:nil bgColor:nil image:[UIImage imageNamed:@"chat_entrance_icon_unpressed.png"]];
    [_wholeScroll addSubview:_chatBtn];
    
    //寻找其他小伙伴按钮
    _searchGuy = [self getButton:CGRectMake(90, ORINGIN_Y(_describeLabel)+VIEW_HEIGHT(_describeLabel)+5, 150, 30) type:UIButtonTypeCustom title:@"了解更多，寻找伙伴？" titleColor:MAIN_COLOR bgColor:nil image:nil];
    _searchGuy.titleLabel.font = [UIFont systemFontOfSize:15];
    [_wholeScroll addSubview:_searchGuy];
    
    //促销价
    _priceTip = [self getLabel:CGRectMake(5, ORINGIN_Y(_searchGuy)+VIEW_HEIGHT(_searchGuy)+5, 60, 30) textColor:RGB(243, 140, 167) text:@"促销价" font:[UIFont systemFontOfSize:DESCRIBE_FONT_SIEZE]  textAligment:NSTextAlignmentCenter];
    [_wholeScroll addSubview:_priceTip];
    
    // 价格
    _priceLabel = [self getLabel:CGRectMake(65, ORINGIN_Y(_searchGuy)+VIEW_HEIGHT(_searchGuy), 100, 35) textColor:RGB(243, 140, 167) text:@"$2399" font:[UIFont systemFontOfSize:TITLE_FONT_SIZE] textAligment:NSTextAlignmentCenter];
    [_wholeScroll addSubview:_priceLabel];
    
    // 分段控件
    _seg = [[UISegmentedControl alloc] initWithItems:@[@"概要",@"行程",@"评价"]];
    _seg.frame = CGRectMake(5, ORINGIN_Y(_priceLabel)+VIEW_HEIGHT(_priceLabel), SCREEN_WIDTH-10, 30);
    [_seg setTintColor:MAIN_COLOR];
    [_wholeScroll addSubview:_seg];
    
    
    // 不随scroll滚动的 toolbar
    float toolbarHeight = 44.0;
    
    _myToolbar = [[CustomToolbar alloc]initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - toolbarHeight, SCREEN_WIDTH, toolbarHeight)
                                  AndBackgroundColor:[UIColor whiteColor]];
    
    [_myToolbar getButton:CGRectMake(10, 2, SCREEN_WIDTH/2-30, 40) type:UIButtonTypeCustom title:@"电话咨询" titleColor:[UIColor whiteColor] bgColor:RGB(247,176,88) image:nil];
    [_myToolbar getButton:CGRectMake(SCREEN_WIDTH/2, 2, SCREEN_WIDTH/2-10, 40) type:UIButtonTypeCustom title:@"立即预订" titleColor:[UIColor whiteColor] bgColor:RGB(254,128,162) image:nil];
    [self.view addSubview:_myToolbar];
    
    UIButton* btn1 = (UIButton*)_myToolbar.ToolbarItems[1] ;
    [btn1 addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];

    // 产品详情最下面的列表
    _productShotTable = [[UITableView alloc] initWithFrame:CGRectMake(0, ORINGIN_Y(_seg)+VIEW_HEIGHT(_seg), SCREEN_WIDTH, 44*5) style:UITableViewStylePlain];
    _productShotTable.delegate = self;
    _productShotTable.dataSource = self;
    [_productShotTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"shotCell"];
    [_wholeScroll addSubview:_productShotTable];
    [_productShotTable setScrollEnabled:NO];
    _listData = @[@[@"查看和选择团期",@"01-24，01-27，01-31，02-03，02-05"],@[@"产品特色",@"2014销量冠军，全新升级，会员名一起齐聚在东北这片辽阔纯净的土地上。和我们一起带着欢乐带着热情踏入海南"],@[@"住宿安排",@"【升级品质】城市酒店升级挂牌三星，提升舒适度"],@[@"行程安排",@"【精品线路】独立成团，让您包揽海南最美景色"],@[@"升级品质",@"产品经理亲自踩线，一辆旅游车全程服务，无缝对接。告别一人一座拥堵旅游车位。"]];
    [_wholeScroll setContentSize:CGSizeMake(SCREEN_WIDTH, ORINGIN_Y(_seg)+VIEW_HEIGHT(_seg)+5*40+80)];
    [_wholeScroll setScrollEnabled:YES];
    /*
    _productDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _productDetailTable.dataSource = self;
    _productDetailTable.delegate = self;
    [self setExtraCellLineHidden:_productDetailTable];
    [_productDetailTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_productDetailTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    // _profileTable.backgroundColor = MAIN_COLOR;
    [self.view addSubview:_productDetailTable];
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 140)];
    _pathCover.backgroundColor = MAIN_COLOR;
    //  self.view.backgroundColor = MAIN_COLOR;
  //  [_pathCover setBackgroundImage:[self imageWithColor:MAIN_COLOR]];
    //[_pathCover setAvatarImage:[UIImage imageNamed:@"default_thumbnail"]];

    _pathCover.isZoomingEffect = YES;
    _productDetailTable.tableHeaderView = self.pathCover;
    _pathCover.pathDelegate = self;
    
    __weak ProductDetailViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    [_pathCover setHandleTapBackgroundImageEvent:^{
        // [wself.pathCover setBackgroundImage:[UIImage imageNamed:@"AlbumHeaderBackgrounImage"]];
    }];
     */
}


-(void)pay{
    NSLog(@"123");
    LXActionSheet* actionSheet = [[LXActionSheet alloc] initWithTitle:@"支付方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"支付宝支付",@"微信支付",@"财付通支付"]];
    [actionSheet showInView:self.view];
    
}


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


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
//[_wholeScroll setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+100)];

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


- (void)_refreshing {
    // refresh your data sources
    
    __weak ProductDetailViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //[wself getClubDetailInfo];//进行网络请求获取数据
        [wself.pathCover stopRefresh];
        
    });
}



-(void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [tableView setTableFooterView:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma  mark - UITableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"shotCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _listData[indexPath.row][0];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.text = _listData[indexPath.row][1];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}

@end
