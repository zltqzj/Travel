//
//  MyTravelPlanViewController.m
//  Travel
//
//  Created by ZKR on 2/4/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "MyTravelPlanViewController.h"
#import "config.h"
#import "PlanTableViewCell.h"
#import "UIButton+Bootstrap.h"
@interface MyTravelPlanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) UITableView* planTable;
@property(strong,nonatomic) NSArray* listData;

@end

@implementation MyTravelPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的行程";
    self.tabBarController.tabBar.hidden = YES;
    SETTING_NAVGATION_STYLE
    
    _planTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _planTable.delegate = self;
    _planTable.dataSource  = self;
    [_planTable registerClass:[PlanTableViewCell class] forCellReuseIdentifier:@"plan"];
    [self.view addSubview:_planTable];
    
    UIButton*  customPlan = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    customPlan.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [customPlan defaultStyle];
    [customPlan setTitle:@"一键定制行程计划" forState:UIControlStateNormal];
    [self.view addSubview:customPlan];
    [customPlan addTarget:self action:@selector(customPlanDo) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"管理" style:UIBarButtonItemStyleBordered target:self action:@selector(managePlan)];
    // Do any additional setup after loading the view.
}


-(void)managePlan{
    
}

-(void)customPlanDo{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlanTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"plan" forIndexPath:indexPath];
  

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
