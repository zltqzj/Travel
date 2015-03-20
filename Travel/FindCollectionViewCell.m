//
//  FindCollectionViewCell.m
//  Travel
//
//  Created by ZKR on 3/4/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "FindCollectionViewCell.h"

@implementation FindCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"FindCollectionViewCell" owner:self options:nil];
        self = [array firstObject];
    }
    return self;
}

@end
