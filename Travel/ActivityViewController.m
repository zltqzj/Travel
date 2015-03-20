//
//  ActivityViewController.m
//  Travel
//
//  Created by ZKR on 3/7/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityTableViewCell.h"
#import "config.h"
#import "ActivityDetailTableViewController.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tabBarController.tabBar setHidden:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _actTable.delegate = self;
    _actTable.dataSource = self;
    self.title = @"活动";
    [self.tabBarController.tabBar setHidden:NO];
  //  self.automaticallyAdjustsScrollViewInsets = NO;

    SETTING_NAVGATION_STYLE
    [_actTable registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"ActivityTableViewCell"];
    NSArray* imageArr =  @[@"tyhj.jpg",@"ntwq.jpg",@"nss.jpg",@"wzz.jpg",@"fhl.jpg", @"mlzg.jpg",
                           @"blg.jpg",@"ynd.jpg"];
    NSArray* titleArr  = @[@"海南岛国际大帆船赛",
                           @"儋州樱花节",
                           @"第十五届中国海南岛欢乐节",
                           @"海南佛光舍利博物馆开馆",
                           @"东坡文化体验之旅",
                           @"樱花之海",
                           @"五指山红峡谷漂流顺利试漂",
                           @"海南槟榔谷：木棉花开艳"];
    NSArray* descArr = @[@"2014“阿罗哈杯”第五届环海南岛国际大帆船赛28日晚在半山半岛三亚帆船港闭幕。经过八天场地赛和环岛拉力赛的角逐，麦博号和万宁号分别夺得IRC-A组和博纳多40组总冠军，友宝号和华帝聚能号则分别在IRC-B1组和IRC-B2组中称雄。",
                         @"儋州市在开展“东坡文化体验之旅”的活动中将举办“儋州樱花节”，为市民和游客提供一个春天里踏青和浪漫的好去处。据悉，“儋州樱花节”将于农历大年初三在儋州市近郊的合罗农场正式开幕，近千株各种樱花将在春节及以后的30多天里相继绽放。",
                         @"2014第十五届中国海南岛欢乐节将于2014年12月26日—28日举行，主题为“旅游嘉年华 椰城‘深呼吸’”，主会场定址海口市。为更好的服务岛内外市民游客，欢乐节组委会12月22日在海南荣丰花卉香榭花园睡莲粉丝基地召开第三次发布会，公布海口主会场详细节目单与“安居”“购物”“旅游”“美食”“愉悦”五大板块详细安排，并就欢乐节期间出行及游玩攻略做详细答疑。市民及游客可根据节目单详细信息安排出行活动，不错过任何一场精彩。",
                         @"为弘扬传统文化，倡导行善积德风气，推动佛教文化传播，加强文化与文物保护，12月27日上午，海南佛光舍利博物馆在中国香街举办开馆仪式，同时进行舍利子展示，主要展示佛陀与诸大弟子、罗汉舍利，以及唐卡、佛文化艺术品等。",
                         @"为了打造特色旅游产品，提升儋州旅游的知名度和美誉度，推动旅游业的快速发展，儋州市定于2015年2月7日正式启动“东坡文化体验之旅”活动。本次活动内容主要有:背诵东坡诗词免费游览东坡书院、东坡诗词背诵大赛、东坡诗词书法大赛、“发现儋州之美”摄影大赛以及东坡美食和儋州特色美食推介等，活动内容非常丰富。背诵东坡诗词免费游览东坡书院启动之日起实行，完整背诵3首东坡诗词者，免费游览东坡书院。",
                         @"据悉，“樱花之海”的樱花品种涵盖南方种的中国红、广州樱，北方种的貂蝉等，有红色、粉色、白色等，不同树种花开的时间不一样，技术人员会合理地安排园区内樱花有序开放，使园区樱花保持长达40多天的花期，让春节期间来到“樱花之海”的人都能一睹樱花的芳容。",
                         @"五指山红峡谷旅游区项目根据中部山区的资源特点，提出以游客为本、极品追求、植根文化、借力科技为理念；以热带雨林、险峻峡谷漂流为主题；以黎苗文化为根基，植入多元文化元素，挖掘养生文化内涵。突出休闲、康体、素质拓展等文化特色，形成了集旅游观光、极限运动、康体娱乐、休闲度假、居住养生为一体的复合型现代文化生态旅游发展区.",
                         @"阳春三月，春暖花开，正是出游好时节，海南槟榔谷黎苗文化旅游区里百年的木棉花争相怒放，一簇簇相拥的灿烂，红火火的一片，成为早春一道亮丽的风景线，吸引众多游客驻足观看。"];
    
    _listData = [NSMutableArray arrayWithObjects:imageArr,titleArr,descArr, nil];
    
    
    
    _imageURLs = @[@"tyhj.jpg",@"ntwq.jpg",@"wzz.jpg",@"nss.jpg"];
    
    
    _sv = [[AsyncScrollView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 110) andImageArray:_imageURLs];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:_sv];
    [_sv addTimer];
    
    _actTable.tableHeaderView = _sv;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_listData[1] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityTableViewCell* cell  = [tableView dequeueReusableCellWithIdentifier:@"ActivityTableViewCell" forIndexPath:indexPath];
    NSArray* imageArr = _listData[0];
    NSArray* titleArr = _listData[1];
    NSArray* descArr = _listData[2];
    NSInteger row = indexPath.row;
    cell.titleLabel.text = titleArr[row];
    cell.descLabel.text = descArr[row];
    cell.iconImage.image = [UIImage imageNamed:imageArr[row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityDetailTableViewController* actDetail =viewOnSb(@"ActivityDetailTableViewController"); //[[ActivityDetailTableViewController alloc] init];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:actDetail animated:YES];
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
