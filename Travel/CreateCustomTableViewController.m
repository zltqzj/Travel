//
//  CreateCustomTableViewController.m
//  Travel
//
//  Created by ZKR on 1/19/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "CreateCustomTableViewController.h"
#import <UIKit/UIKit.h>
#import "config.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "ActionSheetPicker.h"
#import <RETableViewManager/RETableViewManager.h>
#import "RETableViewOptionsController.h"
#import "MultilineTextItem.h"

@interface CreateCustomTableViewController ()<RETableViewManagerDelegate>
{
    CalendarHomeViewController *chvc;

}
@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) NSArray *money;
@property (nonatomic, strong) NSArray *persons;
@property (nonatomic, strong) NSMutableArray* cityLeft;
@property (nonatomic, strong) NSMutableArray* cityRight;


@property (strong, readwrite, nonatomic) NSArray* listData;

@property (strong, readwrite, nonatomic) RETableViewManager *manager;
@property (strong, readwrite, nonatomic) RETableViewSection *basicControlsSection;
@property (strong, readwrite, nonatomic) RETextItem *fullLengthFieldItem;
@property (strong, readwrite, nonatomic) RETextItem *textItem;
@property (strong, readwrite, nonatomic) RENumberItem *numberItem;
@property (strong, readwrite, nonatomic) RETextItem *passwordItem;
@property (strong, readwrite, nonatomic) REBoolItem *boolItem;
@property (strong, readwrite, nonatomic) REFloatItem *floatItem;
@property (strong, readwrite, nonatomic) REDateTimeItem *dateTimeItem;
@property (strong, readwrite, nonatomic) RERadioItem *radioItem;
@property (strong, readwrite, nonatomic) REMultipleChoiceItem *multipleChoiceItem;
@property (strong, readwrite, nonatomic) RELongTextItem *longTextItem;
@property (strong, readwrite, nonatomic) RECreditCardItem *creditCardItem;
@property (strong, readwrite, nonatomic) RECreditCardItem *creditCardItemCVV;
@property (strong, readwrite, nonatomic) REPickerItem *pickerDay;
@property (strong, readwrite, nonatomic) REPickerItem *pickerMoney;
@property (strong, readwrite, nonatomic) REPickerItem *pickerPerson;
@property (strong, readwrite, nonatomic) RESegmentedItem *segmentItem;
@property (strong, readwrite, nonatomic) RESegmentedItem *segmentItem2;
@end

@implementation CreateCustomTableViewController


//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.tabBar setHidden:YES];
    self.title = @"个性定制";
    
    /*
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
     */
    
    __typeof (&*self) __weak weakSelf = self;
    
    // Create manager
    //
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    self.manager.delegate = self;
    
    // Add sections and items
    //
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    
    self.radioItem = [RERadioItem itemWithTitle:@"出发城市" value:@"北京" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        // Generate sample options
        //
        NSMutableArray *options = [[NSMutableArray alloc] init];
        
        NSString* cityPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"] ;
        NSArray* cityArr = [NSArray arrayWithContentsOfFile:cityPath];
        
        [cityArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [options addObject:obj[@"state"]];
        }];
//        for (NSInteger i = 1; i < 40; i++)
//            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
        // Present options controller
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^(RETableViewItem *selectedItem){
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        // Adjust styles
        //
        optionsController.delegate = weakSelf;
        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    [section addItem:_radioItem];
    
    self.pickerMoney = [REPickerItem itemWithTitle:@"行程预算" value:@[@"0-￥1000"] placeholder:nil options:@[@[@"0-￥1000",@"￥1000-￥5000",@"￥5000-￥10000",@">￥10000"]]];
    [self.pickerMoney setInlinePicker:YES];
    [section addItem:self.pickerMoney];

    self.pickerMoney.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };
    
    self.pickerPerson = [REPickerItem itemWithTitle:@"出行人数" value:@[@"1人-3人"] placeholder:nil options:@[@[@"1人-3人",@"3人-10人",@"10人-100人",@">100人"]]];
    [self.pickerPerson setInlinePicker:YES];
    [section addItem:self.pickerPerson];

    self.pickerPerson.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };
    
    
    
    [REDateTimeItem itemWithTitle:@"出发日期" value:[NSDate date] placeholder:nil format:@"MM/dd/yyyy hh:mm a" datePickerMode:UIDatePickerModeDateAndTime];
    self.dateTimeItem.onChange = ^(REDateTimeItem *item){
        NSLog(@"Value: %@", item.value.description);
    };
    self.pickerDay = [REPickerItem itemWithTitle:@"出行天数" value:@[@"1-3天"] placeholder:nil options:@[ @[@"1-3天", @"3-10天",@"10-20天",@">20天"]]];
    [self.pickerDay setInlinePicker:YES];
    [section addItem:self.pickerDay];
    
    self.dateTimeItem.inlineDatePicker = YES;

    
   // [section addItem:[RETextItem itemWithTitle:@"Text item" value:nil placeholder:@"Text"]];
  
    
//    [section addItem:[REBoolItem itemWithTitle:@"Bool item" value:YES switchValueChangeHandler:^(REBoolItem *item) {
//        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
//    }]];
    
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"提交个性定制" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        item.title = @"已提交";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    
    [section addItem:buttonItem];
    


    
    
}


- (RETableViewSection *)addBasicControls
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Basic controls"];
    [self.manager addSection:section];
    
    // Custom item / cell
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    // Add items to this section
    //
    [section addItem:@"Simple NSString"];
    
    self.fullLengthFieldItem = [RETextItem itemWithTitle:nil value:nil placeholder:@"Full length text field"];
    self.textItem = [RETextItem itemWithTitle:@"Text item" value:nil placeholder:@"Text"];
    self.numberItem = [RENumberItem itemWithTitle:@"Phone" value:@"" placeholder:@"(123) 456-7890" format:@"(XXX) XXX-XXXX"];
    self.numberItem.onEndEditing = ^(RENumberItem *item){
        NSLog(@"Value: %@", item.value);
    };
    self.passwordItem = [RETextItem itemWithTitle:@"Password" value:nil placeholder:@"Password item"];
    self.passwordItem.secureTextEntry = YES;
    self.boolItem = [REBoolItem itemWithTitle:@"Bool item" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
    }];
    self.segmentItem = [RESegmentedItem itemWithTitle:@"Segmented" segmentedControlTitles:@[@"One", @"Two"] value:1 switchValueChangeHandler:^(RESegmentedItem *item) {
        NSLog(@"Value: %li", (long)item.value);
    }];
    self.segmentItem2 = [RESegmentedItem itemWithTitle:nil segmentedControlImages:@[[UIImage imageNamed:@"Heart"], [UIImage imageNamed:@"Heart_Highlighted"]] value:0 switchValueChangeHandler:^(RESegmentedItem *item) {
        NSLog(@"Value: %li", (long)item.value);
    }];
    self.segmentItem2.tintColor = [UIColor orangeColor];
    self.floatItem = [REFloatItem itemWithTitle:@"Float item" value:0.3 sliderValueChangeHandler:^(REFloatItem *item) {
        NSLog(@"Value: %f", item.value);
    }];
    self.dateTimeItem = [REDateTimeItem itemWithTitle:@"Date / Time" value:[NSDate date] placeholder:nil format:@"MM/dd/yyyy hh:mm a" datePickerMode:UIDatePickerModeDateAndTime];
    self.dateTimeItem.onChange = ^(REDateTimeItem *item){
        NSLog(@"Value: %@", item.value.description);
    };
    
    self.dateTimeItem.inlineDatePicker = YES;
    
//    self.pickerItem = [REPickerItem itemWithTitle:@"Picker" value:@[@"Item 12", @"Item 23"] placeholder:nil options:@[@[@"Item 11", @"Item 12", @"Item 13"], @[@"Item 21", @"Item 22", @"Item 23", @"Item 24"]]];
//    self.pickerItem.onChange = ^(REPickerItem *item){
//        NSLog(@"Value: %@", item.value);
//    };
//    
//    // Use inline picker in iOS 7
//    //
//    self.pickerItem.inlinePicker = YES;
    
    self.radioItem = [RERadioItem itemWithTitle:@"Radio" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        // Generate sample options
        //
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
        // Present options controller
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^(RETableViewItem *selectedItem){
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        // Adjust styles
        //
        optionsController.delegate = weakSelf;
        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    self.multipleChoiceItem = [REMultipleChoiceItem itemWithTitle:@"Multiple" value:@[@"Option 2", @"Option 4"] selectionHandler:^(REMultipleChoiceItem *item) {
        [item deselectRowAnimated:YES];
        
        // Generate sample options
        //
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
        // Present options controller
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:YES completionHandler:^(RETableViewItem *selectedItem){
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
            NSLog(@"parent: %@, child: %@", item.value, selectedItem.title);
        }];
        
        // Adjust styles
        //
        optionsController.delegate = weakSelf;
        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    self.longTextItem = [RELongTextItem itemWithValue:nil placeholder:@"Multiline text field"];
    self.longTextItem.cellHeight = 88;
    
    
    [section addItem:self.fullLengthFieldItem];
    [section addItem:self.textItem];
    [section addItem:self.numberItem];
    [section addItem:self.passwordItem];
    [section addItem:self.boolItem];
    [section addItem:self.floatItem];
    [section addItem:self.dateTimeItem];
    
    [section addItem:self.radioItem];
    [section addItem:self.multipleChoiceItem];
    [section addItem:self.segmentItem];
    [section addItem:self.segmentItem2];
    [section addItem:self.longTextItem];
    
    [section addItem:[MultilineTextItem itemWithTitle:@"Custom item / cell example. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sem leo, malesuada tempor metus et, elementum pulvinar nibh."]];
    
    RETableViewItem *titleAndImageItem = [RETableViewItem itemWithTitle:@"Text and image item" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
    }];
    titleAndImageItem.image = [UIImage imageNamed:@"Heart"];
    titleAndImageItem.highlightedImage = [UIImage imageNamed:@"Heart_Highlighted"];
    [section addItem:titleAndImageItem];
    
    return section;
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

/*
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
*/
-(void)dealloc{
    NSLog(@"个性定制界面销毁");
}
@end
