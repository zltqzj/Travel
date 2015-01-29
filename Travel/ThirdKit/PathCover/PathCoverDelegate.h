//
//  PathCoverDelegate.h
//  Travel
//
//  Created by ZKR on 1/6/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PathCoverDelegate <NSObject>

@optional

-(void)avatarClickEvent;  // 头像点击事件

-(void)bannerClickEvent;// 头部背景点击事件

-(void)detailBtnClickEvent;// 右尖角点击事件


@end
