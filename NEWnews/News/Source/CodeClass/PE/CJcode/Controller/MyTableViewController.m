//
//  MyTableViewController.m
//  xiangmu
//
//  Created by zhaoliangyu on 15/10/15.
//  Copyright (c) 2015年 赵良育. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyTableViewCell.h"
#import "MyDate.h"
#import "UIImageView+WebCache.h"
#import "SecondViewController.h"
#import "CjHeadView.h"
#import "TwoTableViewCell.h"
#import "ThreeTableViewCell.h"
#import "MJRefresh.h"

@interface MyTableViewController ()<UIScrollViewDelegate>
{
    NSInteger _index;
    NSInteger _indexCount;
}

@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)MyDate * md;
@property(nonatomic,strong)CjHeadView * headView;
@property(nonatomic,strong)UILabel * headLabel;
@property(nonatomic,assign)NSInteger integer;

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    UIGestureRecognizer * gesture = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(returnTop)];
    
    
    [self p_returnTop];
    
    
    
    // 头部滑动图片新闻ffffffffffffffff
    self.headView = [[CjHeadView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.frame),210)];


    _indexCount = 20;
    self.headView.headScrollView.delegate = self;

    [self.tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[TwoTableViewCell class] forCellReuseIdentifier:@"mycell"];
    [self.tableView registerClass:[ThreeTableViewCell class] forCellReuseIdentifier:@"threeCell"];
    
    self.md = [MyDate shareGetDate];
    
//    [self getData];
//     self.dataArr = [NSMutableArray array];
  
    
   
   // 图片的点击事件
    UITapGestureRecognizer * singTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImageAction)];

    [self.headView.OneheadImageView addGestureRecognizer:singTap];
    
     // 上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerReloadData)];
//    [self.tableView footerBeginRefreshing];
    // 下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerReloadData)];
    [self.tableView headerBeginRefreshing];
    UITapGestureRecognizer * singTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TwoheadImageAction)];
    
    [self.headView.TwoHeadImageView addGestureRecognizer:singTap1];
 
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"掌闻天下" style:UIBarButtonItemStyleDone target:self action:nil];
    
}

// 点击回到顶部
-(void)p_returnTop
{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(60, 0, CGRectGetWidth(self.view.frame)-160, 44)];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = view.frame;

    [button addTarget:self action:@selector(returnTop) forControlEvents:UIControlEventTouchUpInside];
    
    
    [view addSubview:button];
    [self.navigationItem setTitleView:view];
}

-(void)returnTop
{
    NSIndexPath * indexPath  = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}





// 上拉刷新


-(void)footerReloadData
{
    _indexCount += 20;
    
//    NSLog(@"%ld",_indexCount);
    if (_indexCount < 420) {
        [self getData];
        self.headView.headScrollView.contentOffset= CGPointMake(0, 0);
    }
    else
    {
        [self.tableView footerEndRefreshing];
    }
}

// 下拉刷新

-(void)headerReloadData
{
   
        _indexCount = 20;
        [self getData];
     self.headView.headScrollView.contentOffset= CGPointMake(0, 0);
}




// 解析数据
-(void)getData
{
    [self.md getDateWithURL:[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/list/T1348648756099/%ld-%d.html",_indexCount-20,20] PassValue:^(NSArray *array) {
  
        if (_indexCount == 20) {
                self.dataArr = [NSMutableArray arrayWithArray:array];
        NSLog(@"%ld",array.count);
        }else
        {
             for (Model * model in array) {
            [self.dataArr addObject:model];
           
        }
        }
       
//        Model * aModel = self.dataArr[self.dataArr.count-19];
//
        Model * model = self.dataArr[0];
//
//        if ([aModel.title isEqualToString:model.title]) {
////            [self.dataArr removeObject:model];
//            NSLog(@"sfsdfsd================");
//        }
        
        NSString * url = [[model.ads lastObject] objectForKey:@"imgsrc"];
        
        NSString * url1= model.imgsrc;
        
        [self.headView.OneheadImageView sd_setImageWithURL:[NSURL URLWithString:url]];
        
        [self.headView.TwoHeadImageView sd_setImageWithURL:[NSURL URLWithString:url1]];
        
        self.headView.headLabel.text =   [[model.ads lastObject] objectForKey:@"title"];
        
        
        self.tableView.tableHeaderView = self.headView;
        
        [self.tableView footerEndRefreshing];
        
        [self.tableView headerEndRefreshing];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
     
    }];

}



// 头部跳转
-(void)headImageAction
{
    [self p_headPush];
}
-(void)TwoheadImageAction
{
    [self p_headPush];
}
-(void)p_headPush
{
    SecondViewController * svc = [[SecondViewController alloc]init];
    
    Model * model = self.dataArr[0];
    
    NSInteger  integer = [model.url length];
    
    NSString * str = [[model.ads lastObject] objectForKey:@"url"];
    
    NSMutableString * urlStr = [NSMutableString stringWithFormat:@"%@",model.url];
    
    [urlStr replaceCharactersInRange:NSMakeRange(integer-21, 16) withString:[NSString stringWithFormat:@"%@",str]];
    
    if (_integer == 0) {
        svc.secondUrl =  urlStr;
    }else
    {
        svc.secondUrl =  model.url;
    }
    
    [self.navigationController pushViewController:svc animated:YES];

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.integer = scrollView.contentOffset.x/self.view.frame.size.width;
    
    NSLog(@"%ld",self.integer);
    Model * model = self.dataArr[0];
    
    //    NSInteger integer = self.headView.headScrollView.frame.size.width/self.view.frame.size.width;
    
    if (_integer == 0) {
        self.headView.headLabel.text =   [[model.ads lastObject] objectForKey:@"title"];
    }else
    {
        self.headView.headLabel.text =  model.title;
    }
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
    return self.dataArr.count-1;
    

   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
//     Configure the cell...
   
    Model * model = self.dataArr[indexPath.row+1];
//    NSLog(@"%ld",indexPath.row);
    if ([model.imgType isEqualToNumber: [NSNumber numberWithInt:1]]) {
        ThreeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell" forIndexPath:indexPath];
        [cell.longImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        cell.longLabel.text = model.title;
    }
    
    if (model.imgextra == nil ) {
        MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

        
        [cell.anewImage sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        
        cell.label1.text = model.title;
        
        cell.label2.text = model.digest;
        return cell;
        
    }
    else
    {
        
        TwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
        
        [cell.oneImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        
        [cell.twoImageView sd_setImageWithURL:[NSURL URLWithString:[model.imgextra[0] objectForKey:@"imgsrc"]]];
        
        [cell.threeImageView sd_setImageWithURL:[NSURL URLWithString:[model.imgextra[1] objectForKey:@"imgsrc"]]];
        
        cell.headLabel.text = model.title;
        
       return cell;
    }

    
//    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Model * model = self.dataArr[indexPath.row+1];
    if ([model.imgType isEqualToNumber: [NSNumber numberWithInt:1]]) {
        return 160;
    }
    if (model.imgextra == nil ) {
        return 90;
    }else
    {
        return 120;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    SecondViewController * svc = [[SecondViewController alloc]init];
    Model * model = self.dataArr[indexPath.row+1];
    svc.secondUrl = model.url;
    
    [self.navigationController pushViewController:svc animated:YES];
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
