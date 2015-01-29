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
    
#pragma mark - 推送设置   // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |  UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |  UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    return YES;
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
