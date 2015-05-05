//
//  CityViewController.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/27.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//
#define kcellHeight 70
#import "CityViewController.h"
#import "CityInfo.h"
#import "SearchCityController.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_cityTab;
    //城市名
    NSMutableArray *_cityArray;
    NSString *_cityNamePath;
    //删除
    NSMutableArray *_deleteArray;
    //温度按钮
    UIButton *_leftBtn;
    //温度信息
    NSMutableArray *_tempArray;
    //添加按钮
    UIButton *_rightBtn;
    //当前时间
    NSDateComponents *_dateComponent;
    //文件路径
    NSString *_path;
    //判断是否为°F
    NSInteger _isF;
}
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self uiInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
    }
}

- (void)prepareData
{
    _cityNamePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/cityName.plist"];
    _cityArray = [NSMutableArray arrayWithContentsOfFile:_cityNamePath];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    _dateComponent = [calendar components:unitFlags fromDate:now];
    //当前温度设置
    _tempArray = [NSMutableArray array];
    for (int i=0;i<_dataArray.count;i++) {
        NSDictionary *subDic = _dataArray[i];
        NSDictionary *skDic = subDic[@"sk"];
        NSString *tempStr = skDic[@"temp"];
        [_tempArray addObject:tempStr];
    }
}

- (void)uiInit
{
    //_isF = [_dataArray[0][kIsF] intValue];
    UIImageView *weatherBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weatherBG.jpeg"]];
    weatherBG.frame = self.view.bounds;
    weatherBG.alpha = 0.5;
    [self.view addSubview:weatherBG];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTabView];
    [self createFootBtn];
}

- (void)createTabView
{
    _cityTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _cityTab.delegate = self;
    _cityTab.dataSource = self;
    _cityTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    _cityTab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_cityTab];
}

- (void)createFootBtn
{
    //温度改变按钮
    _leftBtn = [MyUtil createBtnFrame:CGRectMake(20, 0, 100, 50) title:@"°C/°F" bgImage:nil image:nil target:self action:@selector(changeTemp:)];
    _leftBtn.contentHorizontalAlignment= UIControlContentHorizontalAlignmentLeft;
    //搜索按钮
    _rightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    _rightBtn.frame = CGRectMake(kScreenWidth-70, 0, 70, 50);
    [_rightBtn addTarget:self action:@selector(addCity:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - uitableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cityArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _cityArray.count ) {
        static NSString *footCell = @"footId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:footCell];
        }
        [cell.contentView addSubview:_leftBtn];
        [cell.contentView addSubview:_rightBtn];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else {
        static NSString *cellId = @"cellId";
        CityInfo *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[CityInfo alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        if (_dataArray.count == _cityArray.count) {
            cell.tempLabel.text = [NSString stringWithFormat:@"%@°",_tempArray[indexPath.row]];
        }
        if ([_dateComponent hour] < 12) {
            cell.timeLabel.text = [NSString stringWithFormat:@"上午%ld:%ld",[_dateComponent hour],[_dateComponent minute]];
        }
        else {
            cell.timeLabel.text = [NSString stringWithFormat:@"下午%ld:%ld",[_dateComponent hour]-12,[_dateComponent minute]];
        }
        cell.cityName.text = _cityArray[indexPath.row];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != _cityArray.count) {
        if (self.delegate) {
//            NSDictionary *dic = _dataArray[indexPath.row];
            [self.delegate didSelectedWithCityInfo:indexPath.row data:_dataArray];
        }
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _cityArray.count) {
        return 50;
    }
    return kcellHeight;
}
// 删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _cityArray.count || indexPath.row == 0) {
        return NO;
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_cityArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_cityArray writeToFile:_cityNamePath atomically:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark --lifeCycle
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _cityNamePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/cityName.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:_cityNamePath];
    NSLog(@"%@",_cityNamePath);
    if (array.count > 0) {
        [_cityArray removeAllObjects];
        [_cityArray addObjectsFromArray:array];
        [_cityTab reloadData];
    }
}

#pragma mark --btnAction
- (void)changeTemp:(UIButton *)btn
{
    if (!_isF) {
        for (int i=0;i<_tempArray.count;i++) {
            int fTemp = [_tempArray[i] intValue]*2+32;
            NSString *f = [NSString stringWithFormat:@"%d",fTemp];
            [_tempArray replaceObjectAtIndex:i withObject:f];
        }
        [_cityTab reloadData];
        _isF = YES;
        [btn setTitle:@"°F" forState:UIControlStateNormal];
    }
    else{
        for (int i=0;i<_tempArray.count;i++) {
            int cTemp = (([_tempArray[i]intValue] - 32)/2);
            NSString *c = [NSString stringWithFormat:@"%d",cTemp];
            [_tempArray replaceObjectAtIndex:i withObject:c];
        }
        [_cityTab reloadData];
        _isF = NO;
        [btn setTitle:@"°C" forState:UIControlStateNormal];
    }
}

- (void)addCity:(UIButton *)btn
{
    SearchCityController *searchCtrl = [[SearchCityController alloc]init];
    [self presentViewController:searchCtrl animated:YES completion:^{
        
    }];
}

@end




















