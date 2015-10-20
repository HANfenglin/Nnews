//
//  MyDate.m
//  xiangmu
//
//  Created by zhaoliangyu on 15/10/15.
//  Copyright (c) 2015年 赵良育. All rights reserved.
//

#import "MyDate.h"

static MyDate * md = nil;




@implementation MyDate
+(instancetype)shareGetDate
{
    if (md == nil) {
        static dispatch_once_t once_token;
        dispatch_once(&once_token, ^{
            md = [[MyDate alloc]init];
        });
    }
    return md;
}
-(void)getDateWithURL:(NSString *)URL PassValue:(PassValue)passValue
{
    dispatch_queue_t globl_t = dispatch_get_global_queue(0, 0);
    
    dispatch_async(globl_t, ^{
    
        NSURL * url = [NSURL URLWithString:URL];
        
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            self.dataArray = [NSMutableArray array];
            
            for (NSDictionary * d in [dict objectForKey:@"T1348648756099"]) {
                
                
                Model * model = [[Model alloc]init];
                
                [model setValuesForKeysWithDictionary:d];

                [self.dataArray addObject:model];
            }
            passValue(self.dataArray);      
        }];
    
    });
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(Model *)getModelWithIndex:(NSInteger)index
{
    return  self.dataArray[index];
}
@end
