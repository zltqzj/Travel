//
//  DiaryTableViewCell.m
//  Travel
//
//  Created by ZKR on 3/5/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "DiaryTableViewCell.h"

@implementation DiaryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"DiaryTableViewCell" owner:self options:nil];
        self = [array firstObject];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
