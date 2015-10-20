//
//  SecondViewController.m
//  xiangmu
//
//  Created by zhaoliangyu on 15/10/15.
//  Copyright (c) 2015年 赵良育. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
-(void)loadView
{
    self.secondWebView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _secondWebView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self p_setData];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonAction:)];
}
-(void)p_setData
{
    NSURL * url = [NSURL URLWithString:self.secondUrl];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    self.secondWebView.scalesPageToFit = YES;
    
    [self.secondWebView loadRequest:request];
}

#pragma mark 返回上一个页面
-(void)leftBarButtonAction:(UIBarButtonItem *)sender
{
    if ([self.secondWebView canGoBack]) {
        [self.secondWebView goBack];
    }else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
