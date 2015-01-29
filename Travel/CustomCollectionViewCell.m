//
//  CustomCollectionViewCell.m
//  Travel
//
//  Created by ZKR on 1/19/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"CustomCollectionViewCell" owner:self options:nil];
        self = [array firstObject];
    }
    return self;
}


@end
