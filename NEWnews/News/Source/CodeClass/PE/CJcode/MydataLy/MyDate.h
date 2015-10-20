//
//  MyDate.h
//  xiangmu
//
//  Created by zhaoliangyu on 15/10/15.
//  Copyright (c) 2015年 赵良育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

typedef void(^PassValue)(NSArray * array);

@interface MyDate : NSObject

@property(nonatomic,strong)NSMutableArray * dataArray;

+(instancetype)shareGetDate;

-(void)getDateWithURL:(NSString *)URL PassValue:(PassValue)passValue;

-(Model * )getModelWithIndex:(NSInteger)index;

@end
