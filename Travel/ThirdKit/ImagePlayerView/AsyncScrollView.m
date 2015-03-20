//
//  AsyncScrollView.m
//  DDViedo
//
//  Created by 赵 冰冰 on 15/2/27.
//  Copyright (c) 2015年 赵 冰冰. All rights reserved.
//
#define kScrollDuration 2
#define kDuration 1
#import "AsyncScrollView.h"
#import "UIImageView+WebCache.h"
#import "UIView+WebCacheOperation.h"
#import "UIView+BlocksKit.h"
//- (void)sd_setImageLoadOperation:(id)operation forKey:(NSString *)key;
@interface AsyncScrollView ()
{
    NSTimer * timer;
}

@property (nonatomic, strong) UIPageControl * pageCtrl;
@property (nonatomic, strong) NSArray * urlArr;
@end

@implementation AsyncScrollView
-(id)initWithFrame:(CGRect)frame andImageArray:(NSArray *)imageArray
{
    if (self = [super initWithFrame:frame]) {
        CGRect temp = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        self.urlArr = imageArray;
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:temp];
        self.scrollView.contentSize = CGSizeMake(frame.size.width * (imageArray.count + 1), frame.size.height);
        self.scrollView.scrollEnabled = YES;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
    
        self.pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        self.pageCtrl.numberOfPages = imageArray.count;
        self.pageCtrl.backgroundColor = [UIColor clearColor];
        [self addSubview:self.pageCtrl];
        for (NSInteger i = 0; i < imageArray.count + 1; i++) {
            
            UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(temp.size.width * i, 0, temp.size.width, temp.size.height)];
            
            if (i == imageArray.count) {
                
                iv.image = [UIImage imageNamed:imageArray[0]];
            }else{
                iv.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
            }
            
            iv.userInteractionEnabled = YES;
            
            [iv bk_whenTouches:1 tapped:1 handler:^{
                
                [timer invalidate];
                
                timer = nil;
                
                NSLog(@"imageView被点击了！");
                
                
            }];
            
            [self.scrollView addSubview:iv];
            
        }
    }
    
    return self;
}
-(id)initWithFrame:(CGRect)frame andImageUrlArray:(NSArray *)imageUrlArray
{
    if (self = [super initWithFrame:frame]) {
        CGRect temp = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        self.urlArr = imageUrlArray;
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:temp];
        self.scrollView.contentSize = CGSizeMake(frame.size.width * (imageUrlArray.count + 1), frame.size.height);
        self.scrollView.scrollEnabled = YES;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO;
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        self.pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        self.pageCtrl.numberOfPages = imageUrlArray.count;
        self.pageCtrl.backgroundColor = [UIColor clearColor];
        [self addSubview:self.pageCtrl];
        for (NSInteger i = 0; i < imageUrlArray.count + 1; i++) {
            
            UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(temp.size.width * i, 0, temp.size.width, temp.size.height)];
            
            if (i == imageUrlArray.count) {
                
                NSString * url = imageUrlArray[0];
                
                NSString * newUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                NSLog(@"%@", newUrl);
                
                [iv sd_setImageWithURL:[NSURL URLWithString:newUrl] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
                
            }else{
                
                NSString * url = imageUrlArray[i];

                 NSString * newUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
               [iv sd_setImageWithURL:[NSURL URLWithString:newUrl] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    
            }
            
            [self.scrollView addSubview:iv];
        }
        
//        [self addTimer];
    }
    
    return self;
}
///增加定时器
-(void)addTimer
{
    //设定定时器间隔
    if (self.scrollDuration == 0) {
        self.scrollDuration = kScrollDuration;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollDuration target:self selector:@selector(upDateTimer) userInfo:nil repeats:YES];
}
///更新定时器
-(void)upDateTimer
{
    NSInteger currentPage =  self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    
    if (currentPage == self.urlArr.count) {
        
        currentPage = 0;
        
        CGPoint point = CGPointMake(currentPage * self.scrollView.frame.size.width, 0);
        
        self.scrollView.contentOffset = point;
        
        return;
        
    }
    if (self.duration == 0) {
        
        self.duration = kDuration;
    }
    
    currentPage++;
    
    CGPoint point = CGPointMake(currentPage * self.scrollView.frame.size.width, 0);
    
    [UIView animateWithDuration:self.duration animations:^{
        
        self.scrollView.contentOffset = point;
        
    } completion:^(BOOL finished) {
        
        //在这里可以添加别的东西
    }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [timer invalidate];
    timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (IBAction)buttonTapped:(UIButton *)sender
{
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"X"]) {
        [sender setTitle:@"A very long title for this button"
                forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"X" forState:UIControlStateNormal];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage =  self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
//    NSLog(@"%d", currentPage);
    ///最后一页出现的时候把最后一页换成第一个
    if (currentPage == self.urlArr.count) {
        
        self.pageCtrl.currentPage = 0;
        self.scrollView.contentOffset = CGPointMake(0, 0);
        
    }else{
        self.pageCtrl.currentPage = currentPage;
  
    }
}
@end
