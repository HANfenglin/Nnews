//
//  MyTableViewCell.m
//  xiangmu
//
//  Created by zhaoliangyu on 15/10/15.
//  Copyright (c) 2015年 赵良育. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

-(UIImageView *)anewImage
{
    if (_anewImage == nil) {
        self.anewImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.contentView.frame)+5, CGRectGetMinY(self.contentView.frame)+5, CGRectGetWidth(self.contentView.frame)-280, CGRectGetHeight(self.contentView.frame)-10)];
        
        [self.contentView addSubview:_anewImage];
    }
    return _anewImage;
}

-(UILabel *)label1
{
    if (_label1 == nil) {
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.anewImage.frame)+5, CGRectGetMinY(self.anewImage.frame), CGRectGetWidth(self.contentView.frame)-self.anewImage.frame.size.width-15, (CGRectGetHeight(self.contentView.frame)-15)/2)];
        self.label1.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:_label1];
    }
    return _label1;
}

-(UILabel *)label2
{
    if (_label2 == nil) {
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.label1.frame), CGRectGetMaxY(self.label1.frame)+2.5, CGRectGetWidth(self.label1.frame), CGRectGetHeight(self.label1.frame))];
        self.label2.font = [UIFont systemFontOfSize:14];
        self.label2.textColor = [UIColor grayColor];
        self.label2.numberOfLines = 2;
        [self.contentView addSubview:_label2];
    }
    return _label2;
}

//-(void)setModel:(Model *)model
//{
//    self.label1.text = model.title;
//    self.label2.text = model.digest;
//}










- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
