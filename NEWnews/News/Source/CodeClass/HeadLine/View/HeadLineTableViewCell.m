//
//  HeadLineTableViewCell.m
//  News
//
//  Created by Xcord-LS on 15/10/16.
//  Copyright (c) 2015年 李帅,赵良育,吴豪明. All rights reserved.
//

#import "HeadLineTableViewCell.h"


@implementation HeadLineTableViewCell



-(UIImageView *)headLineImage
{
    if (_headLineImage == nil)
    {
        self.headLineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100,80)];
        //self.picImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_headLineImage];
    }
    return _headLineImage;
}


-(UILabel *)HeadtitleLable
{
    if (_HeadtitleLable == nil)
    {
        self.HeadtitleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headLineImage.frame)+5, CGRectGetMinY(self.headLineImage.frame), 250, 30)];
        //self.songLable.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_HeadtitleLable];
    }
    return _HeadtitleLable;
    
}

-(UILabel *)headDegest
{
    if (_headDegest == nil)
    {
        self.headDegest = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.HeadtitleLable.frame), CGRectGetMaxY(self.HeadtitleLable.frame) + 5, CGRectGetWidth(self.HeadtitleLable.frame), CGRectGetHeight(self.HeadtitleLable.frame)+10)];
        self.headDegest.font = [UIFont systemFontOfSize:14];
        self.headDegest.numberOfLines = 2;
        self.headDegest.textColor = [UIColor grayColor];
        //self.songLable.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_headDegest];
    }
    return _headDegest;
    
}


-(void)setHeadLine:(HeadLine *)headLine
{
    [self.headLineImage sd_setImageWithURL:[NSURL URLWithString:headLine.imgsrc]];
    self.HeadtitleLable.text = headLine.title;
    self.headDegest.text = headLine.digest;
}





















- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
