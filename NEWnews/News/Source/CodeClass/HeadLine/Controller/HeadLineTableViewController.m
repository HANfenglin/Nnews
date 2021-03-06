//
//  HeadLineTableViewController.m
//  News
//
//  Created by Xcord-LS on 15/10/16.
//  Copyright (c) 2015年 李帅,赵良育,吴豪明. All rights reserved.
//

#import "HeadLineTableViewController.h"
#import "HeadLineTableViewCell.h"
#import "HeadLine2TableViewCell.h"
#import "GetHendLineData.h"
#import "HeadDetailViewController.h"
#import "HeadLineAds.h"
#import "HeadLineImage.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#define KimageCount self.view.frame.size.width
@interface HeadLineTableViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)NSArray *array1;
@property (nonatomic,strong)NSArray *array2;
@property (nonatomic,strong)NSArray *arr;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIImageView *image1;

@property (nonatomic,strong) UIView *view1;

@end

@implementation HeadLineTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    [self.tableView registerClass:[HeadLineTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[HeadLine2TableViewCell class] forCellReuseIdentifier:@"cell1"];
    
    self.HeadScrollView.delegate = self;
    
    
    
    self.array = [NSArray array];
  
    self.arr = [NSArray array];
    
    self.array1 = [NSArray array];
    self.array2 = [NSArray array];
    
    
    [[GetHendLineData shareHandLineData] getDataWithUrl:KHeadLineURL PassValue:^(NSArray *array) {
        
        self.array = array;
        
         [self.tableView reloadData];
       
    }];
    
    
    
    [[GetHendLineData shareHandLineData] getAdsWithUrl:KHeadLineURL PassValue:^(NSArray *arr,NSArray *arr2) {
        
        self.array1 = arr;
        self.array2 = arr2;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
           
        });
        
    }];
    

  [self setUpUI];
    
    
    //[self.tableView addHeaderWithTarget:self action:@selector(aAction)];
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadLine *h = self.array[indexPath.row];
    if ([h.digest isEqualToString:@""])
    {
        HeadLine2TableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        HeadLine *hImage = self.array[indexPath.row];
        
        [cell2.firstImage sd_setImageWithURL:[NSURL URLWithString:hImage.imgsrc]];
        
        [cell2.SecondImage sd_setImageWithURL:[NSURL URLWithString:[hImage.imgextra[0] objectForKey:@"imgsrc"]]];
        [cell2.ThirdImage sd_setImageWithURL:[NSURL URLWithString:[hImage.imgextra[1] objectForKey:@"imgsrc"]]];
        cell2.headLable.text = hImage.title;
        
        return cell2;
    }
    else
    
    {
        HeadLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.headLine = self.array[indexPath.row];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadDetailViewController *headVC = [[HeadDetailViewController alloc]init];
    HeadLine *h = self.array[indexPath.row];
    if ([h.digest isEqualToString:@""])
    {
//        NSString *s = @"http://c.3g.163.com/photo/api/set/0096/79595.json";
//        NSString *s1 = [h.ads[indexPath.row] objectForKey:@"url"];
//        NSString *s2 = [s1 substringFromIndex:5];
        
        //headVC.webStr =
    }
    else
    {
    
        
        headVC.webStr = h.url;
    }
    
    //NSLog(@"%@",headVC.webStr);
    
    [self.navigationController pushViewController:headVC animated:YES];
    
}

-(void)setUpUI
{
    // 定义一个view 用来放轮播图00000
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.frame) , 220)];
    //view1.backgroundColor = [UIColor redColor];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    // 轮播图的实现
    self.HeadScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200)];

    self.HeadScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.HeadScrollView.frame) * self.array1.count, 0);
    self.HeadScrollView.backgroundColor = [UIColor orangeColor];
    self.HeadScrollView.pagingEnabled = YES;//设置翻动时候在下一个停留
    self.HeadScrollView.delegate = self;
    [_view1 addSubview:_HeadScrollView];
    
    HeadLineAds *h = [[HeadLineAds alloc]init];
    
    for (int i = 0; i < self.array1.count ; i++)
    {
        CGFloat imageX = CGRectGetWidth(self.HeadScrollView.frame) * i;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, 0, CGRectGetWidth(self.HeadScrollView.frame), CGRectGetHeight(self.HeadScrollView.frame))];
        
        h = self.array1[i];
        imageView.backgroundColor = [UIColor redColor];
//        UIGestureRecognizer *gRe = [[UIGestureRecognizer alloc]init];1
//        [gRe addTarget:self action:@selector(greAction)];
//        [imageView addGestureRecognizer:gRe];
        //imageView.image = [UIImage imageNamed:@"12.png"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:h.imgsrc]];
        [self.HeadScrollView addSubview:imageView];
    }

    self.HeadPage = [[UIPageControl alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.HeadScrollView.frame) - 100, CGRectGetMaxY(self.HeadScrollView.frame), 100, 20)];
    self.HeadPage.backgroundColor = [UIColor orangeColor];
    self.HeadPage.numberOfPages = 5;
    self.HeadPage.currentPage = 1;
    
    
    [self.HeadPage addTarget:self action:@selector(HeadPageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setupTimer];
    [self.view addSubview:_HeadPage];
    [_view1 addSubview:_HeadPage];
    
    
    self.tableView.tableHeaderView = _view1;
    
}

-(void)setupTimer
{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)timerChange
{
    int page = (self.HeadPage.currentPage + 1) % 5;
    self.HeadPage.currentPage = page;
    [self HeadPageAction:self.HeadPage];
}
// 设置page点击事件
-(void)HeadPageAction:(UIPageControl *)sender
{
    CGFloat x = (sender.currentPage) * self.HeadScrollView.bounds.size.width;
    [self.HeadScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
 
    
    // 根据sender的值将title加到Lable上
    HeadLineAds *h = [[HeadLineAds alloc]init];
     h = self.array1[sender.currentPage];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.HeadScrollView.frame), 275, 20)];
    lable.text = h.title;
    lable.font = [UIFont systemFontOfSize:14];
    lable.backgroundColor = [UIColor orangeColor];
    [_view1 addSubview:lable];
    
}
// 移动scrollview时候,让定时器停止
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}
// 停止移动scrollview时候,让定时器开始
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

//活动scrollView时page动的方法(scroll减速时触发的方法)
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.HeadPage.currentPage = self.HeadScrollView.contentOffset.x / self.view.bounds.size.width;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
