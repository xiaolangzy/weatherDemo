//
//  HomeController.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/27.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "HomeController.h"
#import "CityViewController.h"

@interface HomeController ()<UITableViewDataSource,UITableViewDelegate,CityViewControllerDelegate>
{
    UITableView *_tabView;
    UIView *_footView;
    UIScrollView *_mainScroll;
    UIPageControl *_pageCtrl;
    NSMutableArray *_dataArray;
    
    //城市信息
    UIView *_cityView;
    UILabel *_cityNameLabel;
    UILabel *_cityTemptLabel;
    UILabel *_weatherInfoLabel;
    UILabel *_lowHighLabel;
    //时间信息
    NSArray *_arrWeek;
    NSDateComponents *_dateComponent;
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
    _arrWeek =[NSArray arrayWithObjects:@"星期六",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScrollView];
    [self createCityView];
    [self createTabView];
    [self createFootView];
    
    
    
}

- (void)createCityView
{
    _cityView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, self.view.center.y-40)];
    _cityView.backgroundColor = [UIColor grayColor];
    //城市名
    _cityNameLabel = [MyUtil createLabelFrame:CGRectMake(0, 30, kScreenWidth, 30) text:@"上海直辖市" font:[UIFont systemFontOfSize:20] textAlignment:NSTextAlignmentCenter];
    [_cityView addSubview:_cityNameLabel];
    //当前天气信息
    _weatherInfoLabel = [MyUtil createLabelFrame:CGRectMake(0, 60, kScreenWidth, 15) text:@"晴间多云" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter];
    [_cityView addSubview:_weatherInfoLabel];
    //温度
    _cityTemptLabel = [MyUtil createLabelFrame:CGRectMake(0, _weatherInfoLabel.frame.origin.y + 15 + 5, kScreenWidth, 80) text:@"10°" font:[UIFont systemFontOfSize:80] textAlignment:NSTextAlignmentCenter];
    [_cityView addSubview:_cityTemptLabel];
   //今天信息
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday;
    _dateComponent = [calendar components:unitFlags fromDate:now];

    UILabel *today = [MyUtil createLabelFrame:CGRectMake(20, _cityView.frame.size.height-70,100 , 70) text:[NSString stringWithFormat:@"%@  今天",[_arrWeek objectAtIndex:[_dateComponent weekday]]] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft];
    [_cityView addSubview:today];
    //最高最低温度
    _lowHighLabel = [MyUtil createLabelFrame:CGRectMake(kScreenWidth-20-100, _cityView.frame.size.height-70, 100, 70) text:@"31   18" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight];
    [_cityView addSubview:_lowHighLabel];
    
    [_mainScroll addSubview:_cityView];
}

- (void)createTabView
{
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, _cityView.frame.size.height, kScreenWidth, kScreenHeight-44) style:UITableViewStylePlain];
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
    cityCtrl.delegate = self;
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

#pragma mark --添加城市返回的代理
- (void)didSelectedWithCityInfo:(NSDictionary *)cityDic
{
    _cityNameLabel.text = cityDic[kCityName];
    _cityTemptLabel.text = [NSString stringWithFormat:@"%@°",cityDic[kTemp]];
}



@end























