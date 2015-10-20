//
//  PETableViewController.m
//  News
//
//  Created by Xcord-LS on 15/10/19.
//  Copyright (c) 2015年 李帅,赵良育,吴豪明. All rights reserved.
//

#import "PETableViewController.h"
#import "Pe1TableViewCell.h"
#import "Pe2TableViewCell.h"
#import "GetPeData.h"
#import "Pe2Model.h"
#import "PeDetailViewController.h"
@interface PETableViewController ()

@property (nonatomic,strong)NSArray *arr1;
@property (nonatomic,strong)NSArray *arr2;
@property (nonatomic,strong)NSArray *arr3;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIView *view1;


@end

@implementation PETableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[Pe1TableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView  registerClass:[Pe2TableViewCell class] forCellReuseIdentifier:@"cell2"];
    
    self.arr1 = [NSArray array];
    self.arr2 = [NSArray array];
    self.arr3 = [NSArray array];
    [[GetPeData sharePeHandleData] getDataWithUrl:KPeURL PeValue:^(NSArray *arr1, NSArray *arr2,NSArray *arr3) {
        
        self.arr1 = arr1;
        self.arr2 = arr2;
        self.arr3 = arr3;
        [self.tableView reloadData];
    }];
    
    
    
    [self setUpScrPage];
}


-(void)setUpScrPage
{
    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.frame) , 180)];
    _view1.backgroundColor = [UIColor redColor];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    // 轮播图的实现
    self.PeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160)];
    
    self.PeScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.PeScrollView.frame) * 2, 0);
    self.PeScrollView.backgroundColor = [UIColor orangeColor];
    self.PeScrollView.pagingEnabled = YES;//设置翻动时候在下一个停留
    self.PeScrollView.delegate = self;
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  CGRectGetWidth(self.PeScrollView.frame), CGRectGetHeight(self.PeScrollView.frame))];
   
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image1.frame), 0,  CGRectGetWidth(self.PeScrollView.frame), CGRectGetHeight(self.PeScrollView.frame))];
  

    Pe2Model *Pm = self.arr2[0];
    [image1 sd_setImageWithURL:[NSURL URLWithString:Pm.imgsrc]];
    PeModel *Pm2 = self.arr1[0];
    [image2 sd_setImageWithURL:[NSURL URLWithString:Pm2.imgsrc]];
    
    
    [self.PeScrollView addSubview:image2];
    [self.PeScrollView addSubview:image1];
    [self.view1 addSubview:_PeScrollView];
    
    
    
    
    self.PePageController = [[UIPageControl alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.PeScrollView.frame) - 100, CGRectGetMaxY(self.PeScrollView.frame), 100, 20)];
    self.PePageController.backgroundColor = [UIColor orangeColor];
    self.PePageController.numberOfPages = 2;
    self.PePageController.currentPage = 1;
    self.PePageController.backgroundColor = [UIColor orangeColor];
    
    
    [self.PePageController addTarget:self action:@selector(HeadPageAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setupTimer];
    [self.view addSubview:_PePageController];
    [self.view1 addSubview:_PePageController];
    
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.PeScrollView.frame), 275, 20)];
    lable.text = Pm.title;
    lable.font = [UIFont systemFontOfSize:14];
    lable.backgroundColor = [UIColor orangeColor];
    [_view1 addSubview:lable];

    
    
    
    
    self.tableView.tableHeaderView = _view1;



}
-(void)setupTimer
{
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerChange) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)timerChange
{
    int page = (self.PePageController.currentPage + 1) % 2;
    self.PePageController.currentPage = page;
    [self HeadPageAction:self.PePageController];
}
// 设置page点击事件
-(void)HeadPageAction:(UIPageControl *)sender
{
    CGFloat x = (sender.currentPage) * self.PeScrollView.bounds.size.width;
    [self.PeScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.PeScrollView.frame), 275, 20)];
    
///// 实现轮播图小标题  //////
    if (x == 0)
    {
         Pe2Model *Pm = self.arr2[0];
        lable.text = Pm.title;
        lable.font = [UIFont systemFontOfSize:14];
        lable.backgroundColor = [UIColor orangeColor];
        [_view1 addSubview:lable];
    }
    if (x == self.PeScrollView.bounds.size.width)
    {
         PeModel *Pm2 = self.arr1[0];
        lable.text = Pm2.title;
        lable.font = [UIFont systemFontOfSize:14];
        lable.backgroundColor = [UIColor orangeColor];
        [_view1 addSubview:lable];
    }
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
    self.PePageController.currentPage = self.PeScrollView.contentOffset.x / self.view.bounds.size.width;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.arr1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeModel *p = self.arr1[indexPath.row];
    
    if ([p.digest isEqualToString:@""])
    {
        Pe2TableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        PeModel *hImage = self.arr1[indexPath.row];
        
        [cell2.pe1Image sd_setImageWithURL:[NSURL URLWithString:hImage.imgsrc]];
        
        [cell2.pe2Image sd_setImageWithURL:[NSURL URLWithString:[hImage.imgextra[0] objectForKey:@"imgsrc"]]];
        [cell2.pe3Image sd_setImageWithURL:[NSURL URLWithString:[hImage.imgextra[1] objectForKey:@"imgsrc"]]];
        cell2.peHeadLable.text = hImage.title;
        
        return cell2;
    }
    else
    {
        Pe1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        if (indexPath.row == 0)
        {
            cell.p1Model = self.arr1[indexPath.row + 1];
        }else
        {
            cell.p1Model = self.arr1[indexPath.row];
        }
        
        
        return cell;
        
    }
    
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeDetailViewController *peView = [[PeDetailViewController alloc]init];
    PeModel *p = self.arr1[indexPath.row];
    if ([p.digest isEqualToString:@""])
    {
        
    }
    else
    {
        peView.detailWebUrl = p.url;
    }
    
    
    [self.navigationController pushViewController:peView animated:YES];
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
