//
//  AppDelegate.m
//  Travel
//
//  Created by ZKR on 1/4/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "AppDelegate.h"
#import "config.h"
#import "TabbarViewController.h"
#import "Url.h"
#import <PgySDK/PgyManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBarTintColor:MAIN_COLOR];
    [[UITabBar appearance] setTintColor:MAIN_COLOR];
    [[UITabBar appearance] setBackgroundColor:TABBAR_COLOR];
    
    _netUtils = [[NetUtils alloc] init];
    [_netUtils getUpdate:^(BOOL update) {
        
    }];
    
    
    TabbarViewController* tabbar = viewOnSb(@"tabbar");
    self.window.rootViewController=tabbar;

    
//    [self.window addSubview:self.window.rootViewController.view];
//    //设置splashVC，显示splashVC.view。不使用其他splashVC的功能
//    self.splashViewController=[[UIViewController alloc]init];
//    NSString * splashImageName=@"splash.jpg";
//    if(self.window.bounds.size.height>480){
//        splashImageName=@"splashR4.jpg";
//    }
//
//    
//    self.splashViewController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:splashImageName]];
//    //把splashVC添加进去
//    [self.window addSubview:self.splashViewController.view];
//    //⬇️ 让splashimage显示2s，让用户看一眼得了。
//    [self performSelector:@selector(splashAnimate:) withObject:@0.0 afterDelay:2.0];

    
    
    //1.创建消息上面要添加的动作(按钮的形式显示出来)
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    action.identifier = @"action";//按钮的标示
    action.title=@"Accept";//按钮的标题
    action.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    //    action.authenticationRequired = YES;
    //    action.destructive = YES;
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.identifier = @"action2";
    action2.title=@"Reject";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action.destructive = YES;
    
    //2.创建动作(按钮)的类别集合
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"alert";//这组动作的唯一标示
    [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
    //3.创建UIUserNotificationSettings，并设置消息的显示类类型
    UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
    
#pragma mark - 推送设置   // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |  UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |  UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    /*
    //5.发起本地推送消息
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:5];
    notification.timeZone=[NSTimeZone defaultTimeZone];
    notification.alertBody=@"测试推送的快捷回复";
    notification.category = @"alert";
    [[UIApplication sharedApplication]  scheduleLocalNotification:notification];
    */
    
   // 蒲公英崩溃收集代码
    // [[PgyManager sharedPgyManager] setEnableFeedback:NO]; //关闭用户反馈功能(默认开启)：
    //设置用户反馈界面激活方式为三指拖动
    //[[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeThreeFingersPan];
    //设置用户反馈界面激活方式为摇一摇
    //[[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeShake];
    // 上述自定义必须在调用 [[PgyManager sharedPgyManager] startManagerWithAppId:@"PGY_APP_ID"] 前设置。
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGY_APP_ID];

   // 在需要检查更新的低吗文件中引入头文件：
    //[[PgyManager sharedPgyManager] checkUpdate];
    
    return YES;
}


-(void) splashAnimate:(NSNumber *)alpha{
    // ⬇️ 只能用UIViewAnimationOptionCurveEaseInOut和ViewAnimationOptionTransitionNone两种效果
    UIView * splashView=self.splashViewController.view;
    [UIView animateWithDuration:1.0 animations:^{
        splashView.transform=CGAffineTransformScale(splashView.transform, 1.5, 1.5);
        splashView.alpha=alpha.floatValue;
    } completion:^(BOOL finished) {
        //ARC通过赋值nil释放内存，动画中不能removeFromSuperview.
        [splashView removeFromSuperview];
        self.splashViewController=nil;
    }];
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString* newToken = [[[NSString stringWithFormat:@"%@",deviceToken]
                           stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"nsdata:%@\n 字符串token: %@",deviceToken, newToken);// 获取device token
    // 上传devicetoken
    [_netUtils requestContentWithUrl:DEVICE_TOKEN para:@{@"appleID": newToken} withSuccessBlock:^(id returnData) {
        NSLog(@"%@",returnData);
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"RegistFail%@",error);
  
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // 处理推送消息
    NSLog(@"收到推送消息:%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    if (application.applicationIconBadgeNumber > 0) {
        application.applicationIconBadgeNumber  = 0;
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
