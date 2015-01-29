//
//  ProductDetailViewController.h
//  Travel
//
//  Created by ZKR on 1/14/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomToolbar.h"
@interface ProductDetailViewController : UIViewController  <UITableViewDataSource,UITableViewDelegate>


@property(strong,nonatomic) UITableView* productDetailTable;   // parallax
@property(strong,nonatomic)  CustomToolbar *myToolbar;
@property(strong,nonatomic)    UIScrollView* wholeScroll;
@property(strong,nonatomic) UIImageView* bannerImage;// 最上面的图片
@property(strong,nonatomic) UILabel* titleLabel;//标题
@property(strong,nonatomic) UILabel* describeLabel;//描述
@property(strong,nonatomic) UIButton* chatBtn;//聊天按钮
@property(strong,nonatomic) UIButton* searchGuy;//寻找其他小伙伴按钮；
@property(strong,nonatomic) UILabel* priceTip;//促销价
@property(strong,nonatomic) UILabel* priceLabel;//价格
@property(strong,nonatomic) UISegmentedControl* seg;//分段控件
@property(strong,nonatomic) UITableView* productShotTable;// 产品详情最下面的列表
@property(strong,nonatomic) NSArray* listData;//数据源
@end
