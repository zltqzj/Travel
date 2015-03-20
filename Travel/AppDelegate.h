//
//  AppDelegate.h
//  Travel
//
//  Created by ZKR on 1/4/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetUtils.h"
#define PGY_APPKEY @"c9980b0fb573e7761349895ad3386eaf"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NetUtils* netUtils;
@property (strong,nonatomic) UIViewController * splashViewController;

@end

