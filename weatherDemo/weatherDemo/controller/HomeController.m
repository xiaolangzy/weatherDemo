//
//  HomeController.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/27.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "HomeController.h"
#import "CityViewController.h"

@interface HomeController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tabView;
    UIView *_footView;
    UIScrollView *_mainScroll;
    UIPageControl *_pageCtrl;
    NSMutableArray *_dataArray;
    
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self uiInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UI
- (void)uiInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScrollView];
    [self createTabView];
    [self createFootView];
    
    
    
}

- (void)createTabView
{
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44) style:UITableViewStylePlain];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    [_mainScroll addSubview:_tabView];
}

- (void)createScrollView
{
    _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44)];
    _mainScroll.showsHorizontalScrollIndicator = NO;
    _mainScroll.showsVerticalScrollIndicator = NO;
    _mainScroll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainScroll];
}

- (void)createFootView
{
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 44)];
    
    //pageCtrl
    _pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _pageCtrl.currentPage = 0;
    [_footView addSubview:_pageCtrl];
    
    //天气web
    UIButton *weatherBtn = [MyUtil createBtnFrame:CGRectMake(5, 5, 34, 34) title:@"w" bgImage:nil image:nil target:self action:@selector(gotoWeatherWeb)];
    
    //添加城市
    UIButton *addCityBtn = [MyUtil createBtnFrame:CGRectMake(kScreenWidth-34-5, 5, 34, 34) title:@"c" bgImage:nil image:nil target:self action:@selector(addCity)];
    
    //左边点击控制
    UIButton *leftBtn = [MyUtil createBtnFrame:CGRectMake(15, 0, _pageCtrl.center.x, 44) title:nil bgImage:nil image:nil target:self action:@selector(leftAction)];
    [_footView addSubview:leftBtn];
    
    //右边点击控制
    UIButton *rightBtn = [MyUtil createBtnFrame:CGRectMake(_pageCtrl.center.x, 0, addCityBtn.frame.origin.x-_pageCtrl.center.x, 44) title:nil bgImage:nil image:nil target:self action:@selector(rightAction)];
    [_footView addSubview:rightBtn];
    
    [_footView addSubview:weatherBtn];
    [_footView addSubview:addCityBtn];
    
    [self.view addSubview:_footView];
}

#pragma mark - UITabViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return nil;
}


#pragma mark -按钮动作
- (void)gotoWeatherWeb
{
    NSURL* url = [[ NSURL alloc ] initWithString :@"http://weather.com"];
    [[UIApplication sharedApplication ] openURL: url];
}

- (void)addCity
{
    CityViewController *cityCtrl = [[CityViewController alloc]init];
    [self presentViewController:cityCtrl animated:NO completion:nil];
}

- (void)leftAction
{
    NSLog(@"left");
}

- (void)rightAction
{
    NSLog(@"right");
}

@end























