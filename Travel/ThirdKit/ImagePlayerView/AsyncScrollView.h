//
//  AsyncScrollView.h
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsyncScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, assign) NSInteger duration; //动画周期

@property (nonatomic, assign) NSInteger scrollDuration;//滚动周期
@property (nonatomic, assign) BOOL autoScroll;//是否自动滚动

/**
 加载网络图片
 frame：坐标
 imageUrlArray:网络的imageurls
*/
-(id)initWithFrame:(CGRect)frame andImageUrlArray:(NSArray *)imageUrlArray;
/**
 加载本地图片
 */
-(id)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray;
///启动定时器
-(void)addTimer;

@end
