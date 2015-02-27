//
//  MainTableViewCell.m
//  Travel
//
//  Created by ZKR on 2/26/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
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
