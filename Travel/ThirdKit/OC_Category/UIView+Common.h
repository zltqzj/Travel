//
//  UIView+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-6.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<QuartzCore/QuartzCore.h>
#import "UIBadgeView.h"

@class EaseLoadingView, EaseBlankPageView;

typedef NS_ENUM(NSInteger, EaseBlankPageType)
{
    EaseBlankPageTypeView = 0,
    EaseBlankPageTypeActivity,
    EaseBlankPageTypeTask,
    EaseBlankPageTypeTopic,
    EaseBlankPageTypeTweet,
    EaseBlankPageTypeTweetOther,
    EaseBlankPageTypeProject,
    EaseBlankPageTypeFileDleted,
    EaseBlankPageTypeFolderDleted
};

@interface UIView (Common)
- (void)addBadgeTip:(NSString *)badgeValue withCenterPosition:(CGPoint)center;
- (void)addBadgeTip:(NSString *)badgeValue;
- (void)removeBadgeTips;
- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setOrigin:(CGPoint)origin;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;
- (CGFloat)maxXOfFrame;


- (void)addGradientLayerWithColors:(NSArray *)cgColorArray;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )aPoint endPoint:(CGPoint)endPoint;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color;
- (void)removeViewWithTag:(NSInteger)tag;
- (CGSize)doubleSizeOfFrame;

+ (CGRect)frameWithOutNavTab;
+ (CGRect)frameWithOutNav;
+ (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY;
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color;


#pragma mark LoadingView
@property (strong, nonatomic) EaseLoadingView *loadingView;
- (void)beginLoading;
- (void)endLoading;

#pragma mark BlankPageView
@property (strong, nonatomic) EaseBlankPageView *blankPageView;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end

@interface EaseLoadingView : UIView
@property (strong, nonatomic) UIImageView *loopView, *monkeyView;
@property (assign, nonatomic, readonly) BOOL isLoading;
- (void)startAnimating;
- (void)stopAnimating;
@end

@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UIImageView *monkeyView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);
- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end

