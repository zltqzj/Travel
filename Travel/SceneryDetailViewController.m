//
//  SceneryDetailViewController.m
//  Travel
//
//  Created by ZKR on 3/7/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "SceneryDetailViewController.h"
#import "config.h"
#import "XHPathCover.h"
#import "PathCoverDelegate.h"
#import "LXActionSheet.h"
#import "CommentTableViewCell.h"
#import "BlocksKit+UIKit.h"

#define TITLE_FONT_SIZE 18
#define DESCRIBE_FONT_SIEZE 15
@interface SceneryDetailViewController ()
 @end

@implementation SceneryDetailViewController

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
    SETTING_NAVGATION_STYLE
    [self.tabBarController.tabBar setHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"景区介绍";
    // 全屏的滚动
    _wholeScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_wholeScroll];
    
    // 最上面的大图
    _bannerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    _bannerImage.image = [UIImage imageNamed:@"view1.jpg"];
    [_wholeScroll addSubview:_bannerImage];
    
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, VIEW_HEIGHT(_bannerImage)+5, SCREEN_WIDTH-10, 30)];
    _titleLabel.text = @"呀诺达雨林文化旅游区";
    _titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
    [_wholeScroll addSubview:_titleLabel];
    // 描述
    _describeLabel = [[UILabel alloc] init];
    _describeLabel.numberOfLines = 0;
    _describeLabel.text = @"位于三亚市西南部，海榆中线三亚至五指山方向18公里处";
    _describeLabel.font = [UIFont systemFontOfSize:DESCRIBE_FONT_SIEZE];
    _describeLabel.frame = CGRectMake(5, ORINGIN_Y(_titleLabel)+VIEW_HEIGHT(_titleLabel), SCREEN_WIDTH-10, [self getSizeWithFont:[UIFont systemFontOfSize:DESCRIBE_FONT_SIEZE] constrainedToSize:CGSizeMake(SCREEN_WIDTH, 100) label:_describeLabel].height);
    [_wholeScroll addSubview:_describeLabel];
 
    
    //寻找其他小伙伴按钮
    _searchGuy = [self getButton:CGRectMake(8, ORINGIN_Y(_describeLabel)+VIEW_HEIGHT(_describeLabel)+5, 150, 30) type:UIButtonTypeCustom title:@"了解更多，寻找伙伴？" titleColor:MAIN_COLOR bgColor:nil image:nil];
    _searchGuy.titleLabel.font = [UIFont systemFontOfSize:15];
    [_wholeScroll addSubview:_searchGuy];
    

    // 分段控件
    _seg = [[UISegmentedControl alloc] initWithItems:@[@"概要",@"评价"]];
    _seg.frame = CGRectMake(5, ORINGIN_Y(_searchGuy)+VIEW_HEIGHT(_searchGuy)+5, SCREEN_WIDTH-10, 30);
    [_seg setTintColor:MAIN_COLOR];
    
    _seg.selectedSegmentIndex = 0;
    
    __weak SceneryDetailViewController* vc = self;
    
    [_seg bk_addEventHandler:^(id sender) {
        UISegmentedControl* seg = (id)sender;
        NSLog(@"%ld",(long)seg.selectedSegmentIndex);
        switch (seg.selectedSegmentIndex) {
            case 0:
                [vc.productShotTable setHidden:YES];
                [vc.sceneryDescLabel setHidden:NO];
                break;
            case 1:
                [vc.productShotTable setHidden:NO];
                [vc.sceneryDescLabel setHidden:YES];
                break;
            default:
                break;
        }
    } forControlEvents:UIControlEventValueChanged];
  
    [_wholeScroll addSubview:_seg];
    
    // 景区介绍
    NSString* str = @"   呀诺达雨林文化旅游区位于三亚市西南部，海榆中线三亚至五指山方向18公里处，距离三亚市中心仅35公里。北连五指山、七仙岭和中部绿色腹地，在景区的观景台可眺望远景，海棠湾岸线、蜈支洲岛、猴岛尽收眼底的景观冲击，形成了与众不同的区位优势。景区以展现热带雨林景观为核心，融汇生肖文化、雨林图腾、民俗风情于一体，集生态旅游、度假休闲为一身，营造热爱自然、感受自然、回归自然的文化氛围，打造吃、住、行、游、购、娱复合型国际休闲度假旅游社区。“呀诺达雨林山谷”以美国电瓶车、生态栈道、飞瀑索道、高品质旅游巴士环绕成18公里成的园区通道，由雨林谷和梦幻谷两个区域组成。雨林谷内生长着大量的原始森林和次森林，其中一千四百多种乔木，一百四十多种南药，八十多种热带观赏花卉和几十种热带瓜果，是海南五大热带雨林的精品浓缩。";
    _sceneryDescLabel = [self getLabel:(CGRect){10,ORINGIN_Y(_seg)+VIEW_HEIGHT(_seg),SCREEN_WIDTH-20,300} textColor:[UIColor blackColor] text:str font:[UIFont systemFontOfSize:15] textAligment:NSTextAlignmentLeft];
    _sceneryDescLabel.numberOfLines = 0;
    [_wholeScroll addSubview:_sceneryDescLabel];
    [_sceneryDescLabel setHidden:NO];

    
    // 产品详情最下面的列表
    _productShotTable = [[UITableView alloc] initWithFrame:CGRectMake(0, ORINGIN_Y(_seg)+VIEW_HEIGHT(_seg)+5, SCREEN_WIDTH, 70*4) style:UITableViewStylePlain];
    _productShotTable.delegate = self;
    _productShotTable.dataSource = self;
    [_productShotTable registerClass:[CommentTableViewCell class] forCellReuseIdentifier:@"CommentTableViewCell"];
    [_wholeScroll addSubview:_productShotTable];
    [_productShotTable setScrollEnabled:NO];
    [_productShotTable setTableFooterView:[UIView new]];
    [_productShotTable setHidden:YES];
    _listData = @[@"1",@"2",@"3"];
    [_wholeScroll setContentSize:CGSizeMake(SCREEN_WIDTH, ORINGIN_Y(_seg)+VIEW_HEIGHT(_seg)+70*5)];
    [_wholeScroll setScrollEnabled:YES];
    // Do any additional setup after loading the view.
    
    
    
    // 不随scroll滚动的 toolbar
    float toolbarHeight = 44.0;
    
    _myToolbar = [[CustomToolbar alloc]initWithFrame:CGRectMake(0.0, SCREEN_HEIGHT - toolbarHeight, SCREEN_WIDTH, toolbarHeight)
                                  AndBackgroundColor:[UIColor whiteColor]];
    
    [_myToolbar getButton:CGRectMake(10, 2, SCREEN_WIDTH/2-30, 40) type:UIButtonTypeCustom title:@"电话咨询" titleColor:[UIColor whiteColor] bgColor:RGB(247,176,88) image:nil];
    [_myToolbar getButton:CGRectMake(SCREEN_WIDTH/2, 2, SCREEN_WIDTH/2-10, 40) type:UIButtonTypeCustom title:@"立即预订" titleColor:[UIColor whiteColor] bgColor:RGB(254,128,162) image:nil];
    UIButton* btn1 = (UIButton*)_myToolbar.ToolbarItems[1] ;
    [btn1 addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myToolbar];
    // 导航栏右侧按钮
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fenxiang"] style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
}

// 分享
-(void)share:(id)sender{
//    NSArray *shareButtonTitleArray = [[NSArray alloc] init];
//    NSArray *shareButtonImageNameArray = [[NSArray alloc] init];
//    shareButtonTitleArray = @[@"新浪微博",@"微信",@"微信朋友圈"];
//    shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23"];
//      _lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
//    [_lxActivity show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



#pragma mark - LXActivityDelegate

- (void)didClickOnImageIndex:(NSInteger *)imageIndex
{
    NSLog(@"%d",(int)imageIndex);
}

- (void)didClickOnCancelButton
{
    NSLog(@"didClickOnCancelButton");
}


#pragma mark  - uitableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)dealloc{
    NSLog(@"景区详情介绍界面销毁");
}

@end
