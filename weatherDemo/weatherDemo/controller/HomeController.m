//
//  HomeController.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/27.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "HomeController.h"
#import "CityViewController.h"
#import "MainView.h"

@interface HomeController ()<CityViewControllerDelegate,UIScrollViewDelegate>
{
    UIView *_footView;
    UIScrollView *_mainScroll;
    UIPageControl *_pageCtrl;
    //城市数据
    NSMutableArray *_dataArray;
    //page位置
    NSInteger _curIndex;
}

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --UI
- (void)uiInit
{
    _curIndex = 0;
    _dataArray = [NSMutableArray array];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"data.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    if (array.count > 0) {
        [_dataArray addObjectsFromArray:array];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createScrollView];
    [self createFootView];
}

- (void)createScrollView
{
    _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-44)];
    _mainScroll.showsHorizontalScrollIndicator = NO;
    _mainScroll.showsVerticalScrollIndicator = NO;
    _mainScroll.backgroundColor = [UIColor clearColor];
    _mainScroll.contentSize = CGSizeMake(_dataArray.count*kScreenWidth, 0);
    _mainScroll.pagingEnabled = YES;
    _mainScroll.delegate = self;
    [self.view addSubview:_mainScroll];
    [self createMainView];
}

- (void)createMainView
{
    for (int i=0; i<_dataArray.count; i++) {
        MainView *mainView = [[MainView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, _mainScroll.frame.size.height)];
        mainView.cityNameLabel.text = _dataArray[i][kCityName];
        mainView.cityTemptLabel.text = [NSString stringWithFormat:@"%@°",_dataArray[i][kTemp]];
        [_mainScroll addSubview:mainView];
    }
}

- (void)createFootView
{
    _footView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-44, kScreenWidth, 44)];
    //pageCtrl
    _pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _pageCtrl.currentPage = 0;
    _pageCtrl.numberOfPages = _dataArray.count;
    _pageCtrl.backgroundColor = [UIColor grayColor];
    _pageCtrl.backgroundColor = [_pageCtrl.backgroundColor colorWithAlphaComponent:0.2];
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
    if (_curIndex > 0) {
        _curIndex --;
        //改变scrollView的偏移量
        _mainScroll.contentOffset = CGPointMake(kScreenWidth*_curIndex, 0);
        //改变pageControl的当前也
        _pageCtrl.currentPage = _curIndex;
    }
}

- (void)rightAction
{
    if (_curIndex < _dataArray.count - 1) {
        _curIndex ++;
        _mainScroll.contentOffset = CGPointMake(kScreenWidth*_curIndex, 0);
        _pageCtrl.currentPage = _curIndex;
    }
}

#pragma mark --添加城市返回的代理
- (void)didSelectedWithCityInfo:(NSInteger)index data:(NSMutableArray *)dataArray
{
//    _cityNameLabel.text = cityDic[kCityName];
//    _cityTemptLabel.text = [NSString stringWithFormat:@"%@°",cityDic[kTemp]];
    //_dataArray = dataArray;
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self viewDidLoad];
    _curIndex = index;
    _mainScroll.contentOffset = CGPointMake(kScreenWidth*_curIndex, 0);
    _pageCtrl.currentPage = _curIndex;
}

#pragma mark scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算当前的滚动视图到了第几页
    int index = (_mainScroll.contentOffset.x+kScreenWidth/2)/kScreenWidth;
    _pageCtrl.currentPage = index;
    //修改_curIndex的值
    _curIndex = index;
}

@end























