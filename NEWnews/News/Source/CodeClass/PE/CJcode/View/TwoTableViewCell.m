//
//  TwoTableViewCell.m
//  xiangmu
//
//  Created by zhaoliangyu on 15/10/17.
//  Copyright (c) 2015年 赵良育. All rights reserved.
//

#import "TwoTableViewCell.h"

@implementation TwoTableViewCell


-(UILabel *)headLabel
{
    if (_headLabel == nil) {
        self.headLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.contentView.frame)+5, CGRectGetMinY(self.contentView.frame), CGRectGetWidth(self.contentView.frame)-10, 30)];
        
        self.headLabel.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_headLabel];
    }
    return _headLabel;
}



-(UIImageView *)oneImageView
{
    if (_oneImageView == nil) {
        self.oneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.headLabel.frame), CGRectGetMaxY(self.headLabel.frame)+2, CGRectGetWidth(self.contentView.frame)/3 -6, CGRectGetHeight(self.contentView.frame)-CGRectGetHeight(self.headLabel.frame) - 4)];
//        self.oneImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_oneImageView];
    }
    return _oneImageView;
}

-(UIImageView *)twoImageView
{
    if (_twoImageView == nil) {
        self.twoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.oneImageView.frame)+4, CGRectGetMinY(self.oneImageView.frame), CGRectGetWidth(self.oneImageView.frame), CGRectGetHeight(self.oneImageView.frame))];
//        self.twoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_twoImageView];
    }
    return _twoImageView;
}

-(UIImageView *)threeImageView
{
    if (_threeImageView == nil) {
        self.threeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.twoImageView.frame)+4, CGRectGetMinY(self.twoImageView.frame), CGRectGetWidth(self.oneImageView.frame), CGRectGetHeight(self.twoImageView.frame))];
//        self.threeImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_threeImageView];
    }
    return _threeImageView;
}












- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
