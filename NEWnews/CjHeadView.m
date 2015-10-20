//
//  CjHeadView.m
//  xiangmu
//
//  Created by zhaoliangyu on 15/10/17.
//  Copyright (c) 2015年 赵良育. All rights reserved.
//

#import "CjHeadView.h"

#define ONE 100
#define TWO 101

@implementation CjHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{
    self.headScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-30)];
    
    self.headScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*2, CGRectGetHeight(self.frame)-30);
    
    self.headScrollView.showsHorizontalScrollIndicator = false;
    self.headScrollView.pagingEnabled = YES;
    
    self.OneheadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-30)];
    self.OneheadImageView.userInteractionEnabled = YES;
    
    
    self.TwoHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.OneheadImageView.frame), CGRectGetMinY(self.OneheadImageView.frame), CGRectGetWidth(self.OneheadImageView.frame), CGRectGetHeight(self.OneheadImageView.frame))];
    
    self.TwoHeadImageView.userInteractionEnabled = YES;
    
    self.headLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.headScrollView.frame)+5, CGRectGetMaxY(self.headScrollView.frame), CGRectGetWidth(self.headScrollView.frame), 30)];
    self.headLabel.font = [UIFont systemFontOfSize:14];
    
    
    self.OneheadImageView.tag = ONE;
    self.TwoHeadImageView.tag = TWO;

    

    
    [self.headScrollView addSubview:_OneheadImageView];
    
    [self.headScrollView addSubview:_TwoHeadImageView];
    [self addSubview:_headLabel];
    [self addSubview:_headScrollView];
  
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
