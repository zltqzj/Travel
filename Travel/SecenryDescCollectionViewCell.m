//
//  SecenryDescCollectionViewCell.m
//  Travel
//
//  Created by ZKR on 3/7/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "SecenryDescCollectionViewCell.h"

@implementation SecenryDescCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"SecenryDescCollectionViewCell" owner:self options:nil];
        self = [array firstObject];
    }
    return self;
}

@end
