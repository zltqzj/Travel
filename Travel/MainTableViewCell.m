//
//  MainTableViewCell.m
//  Travel
//
//  Created by ZKR on 2/26/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "MainTableViewCell.h"
#import "config.h"
@implementation MainTableViewCell



- (void)awakeFromNib {
    // Initialization code
 
    
    _imageURLs = @[@"bg_product_moren",@"bg_pic_header_default",@"bg_zhaomu",@"bg_ddr_list_default"];
 
 
    _sv = [[AsyncScrollView alloc] initWithFrame:CGRectMake(8, 8, SCREEN_WIDTH-16, 110) andImageArray:_imageURLs];
    [self addSubview:_sv];
    [_sv addTimer];
}




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:self options:nil];
        self = [array firstObject];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
