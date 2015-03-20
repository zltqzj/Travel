//
//  MakePlanViewController.m
//  Travel
//
//  Created by ZKR on 2/5/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "MakePlanViewController.h"
#import "config.h"
#import "MakeTravlView.h"
#import "UIButton+Bootstrap.h"
#import "ActionSheetPicker.h"

@interface MakePlanViewController ()
@property(strong,nonatomic) MakeTravlView* view1;
@property(strong,nonatomic) MakeTravlView* view2;
@property(strong,nonatomic) MakeTravlView* view3;
@property(strong,nonatomic) MakeTravlView* view4;

@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) NSArray *money;
@property (nonatomic, strong) NSArray *persons;
@property (nonatomic, strong) NSMutableArray* cityLeft;
@property (nonatomic, strong) NSMutableArray* cityRight;
@end

@implementation MakePlanViewController


-(void)initView:(CGRect)rect borderColor:(UIColor*)color borderWidth:(float)borderWidth cornerRadius:(float)cornerRadius uiview:(MakeTravlView*)view avatarImage:(UIImage*)avatarImage label1:(NSString*)label1 label2:(NSString*)label2 {
    view = [[[NSBundle mainBundle] loadNibNamed:@"MakeTravlView" owner:self options:nil] lastObject];
    view.frame = rect;//CGRectMake(10, 70, SCREEN_WIDTH-20, 50);
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = borderWidth;
    view.layer.cornerRadius = cornerRadius;
    view.label1.text = label1;
    view.label2.text = label2;
    view.avatar.image = avatarImage;
    view.userInteractionEnabled = YES;

    [self.view addSubview:view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定制行程";
    self.view.backgroundColor = [UIColor whiteColor];
    
   // _view1 = [[[NSBundle mainBundle] loadNibNamed:@"MakeTravlView" owner:self options:nil] lastObject];
    
    [self initView:CGRectMake(10, 70, SCREEN_WIDTH-20, 50) borderColor:[UIColor lightGrayColor] borderWidth:0.5 cornerRadius:0 uiview:_view1 avatarImage:[UIImage imageNamed:@"plan_create_icon_start_place.png"] label1:@"出发地" label2:@"请选择"];
    
    [self initView:CGRectMake(10, 130, SCREEN_WIDTH-20, 50) borderColor:[UIColor lightGrayColor] borderWidth:0.5 cornerRadius:0 uiview:_view2 avatarImage:[UIImage imageNamed:@"plan_create_icon_start_destination"] label1:@"目的地" label2:@"请选择"];
    [self initView:CGRectMake(10,190, SCREEN_WIDTH-20, 50) borderColor:[UIColor lightGrayColor] borderWidth:0.5 cornerRadius:0 uiview:_view3 avatarImage:[UIImage imageNamed:@"plan_create_icon_start_month"] label1:@"出行月份" label2:@"3月"];
    [self initView:CGRectMake(10, 250, SCREEN_WIDTH-20, 50) borderColor:[UIColor lightGrayColor] borderWidth:0.5 cornerRadius:0 uiview:_view4 avatarImage:[UIImage imageNamed:@"plan_create_icon_start_month"] label1:@"游玩天数" label2:@"4天"];

    UIButton*  makePlan = [[UIButton alloc] initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, 50)];
    [makePlan warningStyle];
   // customPlan.layer.cornerRadius = 0;
    
    [makePlan setTitle:@"智能生成行程" forState:UIControlStateNormal];
    [self.view addSubview:makePlan];
    [makePlan addTarget:self action:@selector(customPlanMake) forControlEvents:UIControlEventTouchUpInside];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.navigationController popViewControllerAnimated:YES];
//    });
 //   [self.view addSubview:_view1];
    // Do any additional setup after loading the view.
    
    
    
    self.days = @[@"1-3天", @"3-10天",@"10-20天",@">20天"];
    self.money = @[@"0-￥1000",@"￥1000-￥5000",@"￥5000-￥10000",@">￥10000"];
    self.persons = @[@"1人-3人",@"3人-10人",@"10人-100人",@">100人"];
    
    NSString* cityPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"] ;
    NSArray* cityArr = [NSArray arrayWithContentsOfFile:cityPath];
    [cityArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_cityLeft  addObject:obj[@"state"]];
        
    }];
    
    
    
    
//    UIView* viewTest = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100)];
//    viewTest.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:viewTest];
    
    
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    _view1.userInteractionEnabled = YES;
    [_view1 addGestureRecognizer:tap];
    
    //[viewTest addGestureRecognizer:tap];
    
}

-(void)tap{
    NSLog(@"11111111");

}


-(void)howManyDays:(id)sender{
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"出行天数" rows:_days initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:sender];
    
    [picker setDoneButton:[[UIBarButtonItem alloc] initWithTitle:@"确定"  style:UIBarButtonItemStylePlain target:nil action:nil]];
    [picker setCancelButton:[[UIBarButtonItem alloc] initWithTitle:@"取消"  style:UIBarButtonItemStylePlain target:nil action:nil]];
    [picker showActionSheetPicker];
}



-(void)customPlanMake{
        [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    NSLog(@"一键定制行程界面销毁");
}

@end
