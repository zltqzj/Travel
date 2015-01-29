//
//  CreateCustomTableViewController.m
//  Travel
//
//  Created by ZKR on 1/19/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "CreateCustomTableViewController.h"
#import "config.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "ActionSheetPicker.h"

@interface CreateCustomTableViewController ()
{
    CalendarHomeViewController *chvc;

}
@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) NSArray *money;
@property (nonatomic, strong) NSArray *persons;
@property (nonatomic, strong) NSMutableArray* cityLeft;
@property (nonatomic, strong) NSMutableArray* cityRight;


@property (strong, readwrite, nonatomic) NSArray* listData;
@end

@implementation CreateCustomTableViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.tabBar setHidden:YES];
    self.title = @"个性定制";
    self.days = @[@"1-3天", @"3-10天",@"10-20天",@">20天"];
    self.money = @[@"0-￥1000",@"￥1000-￥5000",@"￥5000-￥10000",@">￥10000"];
    self.persons = @[@"1人-3人",@"3人-10人",@"10人-100人",@">100人"];
    
    NSString* cityPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"] ;
    NSArray* cityArr = [NSArray arrayWithContentsOfFile:cityPath];
  //  NSLog(@"%@",cityArr);
    
    [cityArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_cityLeft  addObject:obj[@"state"]];
        
    }];
    
    _listData = [[NSArray alloc] initWithObjects:@"出发城市",@"旅游目的地",@"出发日期",@"出行天数",@"行程预算",@"出游人数",@"其他需求", nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"create"];
}

-(void)cancelView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)selectPicture{
    NSLog(@"1111111");
}

-(void)dismissPage{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel * sender = cell.textLabel;
    
    if ([sender.text isEqualToString:@"出行天数"]) {
        // 出行天数
        ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"出行天数" rows:_days initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
        } origin:sender];
        
        [picker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
        [picker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
        [picker showActionSheetPicker];

    }
    if ([sender.text isEqualToString:@"行程预算"]) {
        // 行程预算
        ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"行程预算" rows:_persons initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
        } origin:sender];
        
        [picker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
        [picker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
        [picker showActionSheetPicker];
    }
    if ([sender.text isEqualToString:@"出游人数"]) {
        // 出游人数
        ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"出游人数" rows:_money initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
        } origin:sender];
        
        [picker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
        [picker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
        [picker showActionSheetPicker];

    }
    if ([sender.text isEqualToString:@"出发日期"]) {
        // 出发日期
        if (!chvc) {
            
            chvc = [[CalendarHomeViewController alloc]init];
            
            chvc.calendartitle = @"日期";
            
            [chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
            
        }
        
        chvc.calendarblock = ^(CalendarDayModel *model){
            
            NSLog(@"\n---------------------------");
            NSLog(@"1星期 %@",[model getWeek]);
            NSLog(@"2字符串 %@",[model toString]);
            NSLog(@"3节日  %@",model.holiday);
            
            if (model.holiday) {
                
                // [but setTitle:[NSString stringWithFormat:@"%@ %@ %@",[model toString],[model getWeek],model.holiday] forState:UIControlStateNormal];
                
            }else{
                
                //  [but setTitle:[NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]] forState:UIControlStateNormal];
                
            }
        };
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController pushViewController:chvc animated:YES];
    }
    

}
 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"create" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = _listData[indexPath.row];
    return cell;
}


@end
