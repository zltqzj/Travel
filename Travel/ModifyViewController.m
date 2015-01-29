//
//  ModifyViewController.m
//  Travel
//
//  Created by ZKR on 1/6/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "ModifyViewController.h"
#import "config.h"
@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SETTING_NAVGATION_STYLE
    self.title = @"修改帐号";
    [self.tabBarController.tabBar setHidden:YES];

    _accountTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [_accountTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"modifyCell"];
    _accountTable.delegate = self;
    _accountTable.dataSource = self;
    [self.view addSubview:_accountTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?0:34;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//
//
//}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"交易密码会在使用余额、提现等操作中使用";

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==0?2:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"modifyCell" forIndexPath:indexPath];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section ==0 &&  row ==0) {
        cell.textLabel.text =@"修改登录手机号";
    }
    else if (section ==0 && row ==1){
        cell.textLabel.text =@"修改登录密码";

    }
    else{
        cell.textLabel.text =@"找回交易密码";

    }
    //cell.textLabel.text = descArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


@end
