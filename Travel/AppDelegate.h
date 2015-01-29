//
//  AppDelegate.h
//  Travel
//
//  Created by ZKR on 1/4/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetUtils.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NetUtils* netUtils;

@end

