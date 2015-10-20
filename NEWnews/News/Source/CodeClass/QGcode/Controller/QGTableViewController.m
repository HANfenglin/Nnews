//
//  QGTableViewController.m
//  News
//
//  Created by zhaoliangyu on 15/10/20.
//  Copyright (c) 2015年 李帅,赵良育,吴豪明. All rights reserved.
//

#import "QGTableViewController.h"

@interface QGTableViewController ()
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation QGTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[QGTableViewCell class] forCellReuseIdentifier:@"onecell"];
    
    [self.tableView registerClass:[QGTwoTableViewCell class] forCellReuseIdentifier:@"twocell"];
    
    // 数据请求
    [self p_getData];
    
    NSLog(@"-----%ld",self.dataArray.count);
    // 设置tableView头部
    [self setHead];

}
-(void)setHead
{

}

-(void)p_getData
{
    [[QGdata shareGetData]getDataWithURL:qgUrl PassValue:^(NSArray *array) {
        
        self.dataArray = [NSMutableArray arrayWithArray:array];
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240)];
        

        UIImageView * headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height-20)];
        
        UILabel * label = [[UILabel  alloc]initWithFrame:CGRectMake(CGRectGetMinX(view.frame)+10, CGRectGetMaxY(headImageView.frame), CGRectGetWidth(self.view.frame), 20)];
        
        label.font = [UIFont systemFontOfSize:12];
        
        [view addSubview:headImageView];
        
        [view addSubview:label];
        
        QGheaderModel * model = self.dataArray[0];
        
        label.text = model.title;
        
        [headImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        
        NSLog(@"-----%ld",self.dataArray.count);
        self.tableView.tableHeaderView = view;
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [self.tableView reloadData];
            
        });
     
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArray.count -1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QGheaderModel * model = self.dataArray[indexPath.row+1];
    
    if (model.imgextra == nil) {
        QGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"onecell" forIndexPath:indexPath];
        
        
        [cell.aImageVew sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        
        cell.oneLabel.text = model.title;
        
        cell.twoLabel.text = model.digest;
        
        return cell;
    }else
    {
        QGTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"twocell" forIndexPath:indexPath];
        [cell.oneImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        [cell.twoImageView sd_setImageWithURL:[NSURL URLWithString:[model.imgextra[0] objectForKey:@"imgsrc"]]];
        [cell.threeImageView sd_setImageWithURL:[NSURL URLWithString:[model.imgextra[1] objectForKey:@"imgsrc"]]];
        return cell;
    }
    
    
    
    

    
   
    
    // Configure the cell...
    
//    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QGheaderModel * model = self.dataArray[indexPath.row+1];

    if (model.imgextra == nil) {
        return 80;
    }else
    {
        return 110;
    }
    
//    return 80;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
