//
//  PlanTableViewCell.m
//  Travel
//
//  Created by ZKR on 2/4/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "PlanTableViewCell.h"
#import "config.h"
@implementation PlanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"PlanTableViewCell" owner:self options:nil];
        self = [array firstObject];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
