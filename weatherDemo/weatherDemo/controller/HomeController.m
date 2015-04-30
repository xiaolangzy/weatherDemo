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
#import <CoreLocation/CoreLocation.h>

@interface HomeController ()<CityViewControllerDelegate,UIScrollViewDelegate,CLLocationManagerDelegate,DownloadManagerDelegate>
{
    UIView *_footView;
    UIScrollView *_mainScroll;
    UIPageControl *_pageCtrl;
    //天气数据
    NSMutableArray *_dataArray;
    //城市数据
    NSMutableArray *_cityArray;
    //page位置
    NSInteger _curIndex;
    //定位
    CLLocationManager *_manager;
    NSMutableDictionary *_locationDic;
    //城市名本地文件
    NSString *_cityNamePath;
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
    _cityArray = [NSMutableArray array];
    _cityNamePath = [NSHomeDirectory() stringByAppendingPathComponent:@"cityName.plist"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"data.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:_cityNamePath];
    if (array.count > 0) {
        [_cityArray removeAllObjects];
        [_cityArray addObjectsFromArray:array];
        for (NSString *cityName in _cityArray) {
            [self loadDataWithCity:cityName];
        }
    }
    else {
        //开始定位
        _locationDic = [NSMutableDictionary dictionary];
        [self createLocation];
        [_manager startUpdatingLocation];
    }
    
    [self createScrollView];
    [self createFootView];
}
//加载定位数据
- (void)loadDataWithLocation
{
    NSString *urlString = [NSString stringWithFormat:kLocationWeatherUrl,_locationDic[kLon],_locationDic[kLat],kWeatherKey];
    DownloadManager *downloader = [[DownloadManager alloc] init];
    downloader.delegate = self;
    downloader.type = 100;
    [downloader downloadWithUrlString:urlString];
}
//加载其他城市数据
- (void)loadDataWithCity:(NSString *)cityName
{
    NSString *urlString = [NSString stringWithFormat:kWeatherUrl,cityName,kWeatherKey];
    DownloadManager *downloader = [[DownloadManager alloc] init];
    downloader.delegate = self;
    downloader.type = 200;
    [downloader downloadWithUrlString:urlString];
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
//待处理数据
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

- (void)createLocation
{
    _manager = [[CLLocationManager alloc] init];
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    _manager.distanceFilter = 50;
    _manager.delegate = self;
    [_manager requestWhenInUseAuthorization];

}

#pragma mark -按钮动作
- (void)gotoWeatherWeb
{
    NSURL* url = [[ NSURL alloc ] initWithString :@"http://weather.com"];
    //[[UIApplication sharedApplication ] openURL: url];
    [_manager startUpdatingLocation];
}

- (void)addCity
{
    CityViewController *cityCtrl = [[CityViewController alloc]init];
    cityCtrl.delegate = self;
    cityCtrl.dataArray = _dataArray;
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

#pragma mark --scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算当前的滚动视图到了第几页
    int index = (_mainScroll.contentOffset.x+kScreenWidth/2)/kScreenWidth;
    _pageCtrl.currentPage = index;
    //修改_curIndex的值
    _curIndex = index;
}

#pragma mark --定位代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (locations.count > 0) {
        //经纬度
        CLLocation *loc = locations[0];
        CLLocationCoordinate2D coor = loc.coordinate;
        NSLog(@"latitude:%lf,longitude:%lf",coor.latitude,coor.longitude);
        [_manager stopUpdatingLocation];
        [_locationDic setObject:[NSString stringWithFormat:@"%lf",coor.latitude] forKey:kLat];
        [_locationDic setObject:[NSString stringWithFormat:@"%lf",coor.longitude] forKey:kLon];
    }
    else {
        [_locationDic setObject:[NSString stringWithFormat:@"31.22"] forKey:kLat];
        [_locationDic setObject:[NSString stringWithFormat:@"121.22"] forKey:kLon];
    }
    
    [self loadDataWithLocation];
}

#pragma mark --下载代理
- (void)downloadFinish:(DownloadManager *)downloader
{
    //下载数据
    id result = [NSJSONSerialization JSONObjectWithData:downloader.receiveData options:NSJSONReadingMutableContainers error:nil];
    if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = result;
        NSArray *array = dict[@"result"];
        if (downloader.type == 100) {
            NSDictionary *dic = array[1];
            NSString *cityName = dic[@"city"];
            [_cityArray replaceObjectAtIndex:0 withObject:cityName];
            [_cityArray writeToFile:_cityNamePath atomically:YES];
        }
        [_dataArray addObject:array];
    }
}

- (void)downloadError:(NSError *)error
{
    NSLog(@"%@",error);
}
@end























