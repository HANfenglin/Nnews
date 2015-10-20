//
//  ThreeTableViewCell.m
//  xiangmu
//
//  Created by zhaoliangyu on 15/10/17.
//  Copyright (c) 2015年 赵良育. All rights reserved.
//

#import "ThreeTableViewCell.h"

@implementation ThreeTableViewCell

-(UILabel *)longLabel
{
    if (_longLabel == nil) {
        self.longLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.contentView.frame)+5, CGRectGetMinY(self.contentView.frame), CGRectGetWidth(self.contentView.frame)-10, 30)];
        [self.contentView addSubview:_longLabel];
        self.longLabel.font = [UIFont systemFontOfSize:15];
    }
    return _longLabel;
}

-(UIImageView *)longImageView
{
    if (_longImageView == nil) {
        self.longImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.longLabel.frame), CGRectGetMaxY(self.longLabel.frame)+2, CGRectGetWidth(self.longLabel.frame), CGRectGetHeight(self.contentView.frame)-7-CGRectGetHeight(self.longLabel.frame))];
        [self.contentView addSubview:_longImageView];
    }
    return _longImageView;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
