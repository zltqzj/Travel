//
//  MainTableViewCell.h
//  Travel
//
//  Created by ZKR on 2/26/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"
#import "AsyncScrollView.h"
@interface MainTableViewCell : UITableViewCell <UIScrollViewDelegate,ImagePlayerViewDelegate>

@property(strong,nonatomic) IBOutlet AsyncScrollView *sv;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *imageURLs;

@property(strong,nonatomic) IBOutlet UIPageControl* pageControl;

@property(weak,nonatomic) IBOutlet UIScrollView* adScroll;

@property(weak,nonatomic) IBOutlet UIButton* redBag;

@property(weak,nonatomic) IBOutlet UIButton* gyBtn;

@property(weak,nonatomic) IBOutlet UIButton* zdfBtn;

@property(weak,nonatomic) IBOutlet UIButton* jsycBtn;

@property(weak,nonatomic) IBOutlet UIButton* tjjpBtn;

@property(weak,nonatomic) IBOutlet UIButton* jdBtn;

@property(weak,nonatomic) IBOutlet UIButton* jpBtn;

@property(weak,nonatomic) IBOutlet UIButton* jrthBtn;

@property(weak,nonatomic) IBOutlet UIButton* lydjBtn;

@property(weak,nonatomic) IBOutlet UIButton* jdmpBtn;

@property(weak,nonatomic) IBOutlet UIButton* tgBtn;

@property(weak,nonatomic) IBOutlet UIButton* yczjBtn;

@property(weak,nonatomic) IBOutlet UIButton* glBtn;

@property(weak,nonatomic) IBOutlet UIButton* dypBtn;

@property(weak,nonatomic) IBOutlet UIButton* zmyBtn;

@property(weak,nonatomic) IBOutlet UIButton* hcpBtn;

@property(weak,nonatomic) IBOutlet UIButton* hwddBtn;


@end
