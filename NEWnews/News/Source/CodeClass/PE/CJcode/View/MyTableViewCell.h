//
//  MyTableViewCell.h
//  xiangmu
//
//  Created by zhaoliangyu on 15/10/15.
//  Copyright (c) 2015年 赵良育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@interface MyTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * anewImage;
@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,strong)Model * model;
@end
