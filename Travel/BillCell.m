//
//  BillCell.m
//  Travel
//
//  Created by ZKR on 1/6/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "BillCell.h"

@implementation BillCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"BillCell" owner:self options:nil];
        self = [array firstObject];
    }
    return self;
}



- (void)awakeFromNib {
    // Initialization code
    
    // 圆角
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
