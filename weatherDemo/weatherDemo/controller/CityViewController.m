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
    //数据源
    NSMutableArray *_dataArray;
    //删除
    NSMutableArray *_deleteArray;
    //温度按钮
    UIButton *_leftBtn;
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
    // Dispose of any resources that can be recreated.
}

- (void)prepareData
{
    _dataArray = [NSMutableArray array];
    _path = [NSHomeDirectory() stringByAppendingPathComponent:@"data.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:_path];
    if (array.count > 0) {
        [_dataArray addObjectsFromArray:array];
    }else{
        
        for (int i=0; i<2; i++) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSString stringWithFormat:@"city%d",i] forKey:kCityName];
            [dict setObject:@"28" forKey:kTemp];
            [dict setObject:@"0" forKey:kIsF];
            [_dataArray addObject:dict];
        }
        if (_dataArray.count > 0) {
            [_dataArray writeToFile:_path atomically:YES];
        }
    }
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    _dateComponent = [calendar components:unitFlags fromDate:now];
    
}

- (void)uiInit
{
    _isF = [_dataArray[0][kIsF] intValue];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTabView];
    [self createFootBtn];
}

- (void)createTabView
{
    _cityTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _cityTab.delegate = self;
    _cityTab.dataSource = self;
    //_cityTab.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return _dataArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _dataArray.count )
    {
        static NSString *footCell = @"footId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:footCell];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:footCell];
        }
        [cell.contentView addSubview:_leftBtn];
        [cell.contentView addSubview:_rightBtn];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else
    {
        static NSString *cellId = @"cellId";
        CityInfo *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell)
        {
            cell = [[CityInfo alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        }
        
        NSDictionary *dict = _dataArray[indexPath.row];
        cell.cityName.text = dict[kCityName];
        cell.tempLabel.text = [NSString stringWithFormat:@"%@°",dict[kTemp]];
        if ([_dateComponent hour] < 12)
        {
            cell.timeLabel.text = [NSString stringWithFormat:@"上午%ld:%ld",[_dateComponent hour],[_dateComponent minute]];
        }
        else
        {
            cell.timeLabel.text = [NSString stringWithFormat:@"下午%ld:%ld",[_dateComponent hour]-12,[_dateComponent minute]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != _dataArray.count)
    {
        if (self.delegate)
        {
//            NSDictionary *dic = _dataArray[indexPath.row];
            [self.delegate didSelectedWithCityInfo:indexPath.row data:_dataArray];
        }
        [self dismissViewControllerAnimated:NO completion:^{
            
        }];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _dataArray.count)
    {
        return 50;
    }
    return kcellHeight;
}

// 删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _dataArray.count || indexPath.row == 0)
    {
        return NO;
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
      [_dataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_dataArray writeToFile:_path atomically:YES];
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
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"data.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@",path);
    
    if (array.count > 0) {
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:array];
        [_cityTab reloadData];
    }
    
}

#pragma mark --btnAction
- (void)changeTemp:(UIButton *)btn
{
    if (!_isF)
    {
        for (NSMutableDictionary *dic in _dataArray){
            NSString *temp = dic[kTemp];
            int fTemp = temp.intValue*2+32;
            NSString *f = [NSString stringWithFormat:@"%d",fTemp];
            [dic setObject:f forKey:kTemp];
            [dic setObject:@"1" forKey:kIsF];
            [_dataArray writeToFile:_path atomically:YES];
        }
        [_cityTab reloadData];
        _isF = YES;
        [btn setTitle:@"°F" forState:UIControlStateNormal];
    }
    else{
        for (NSMutableDictionary *dic in _dataArray){
            NSString *temp = dic[kTemp];
            int cTemp = ((temp.intValue - 32)/2);
            NSString *c = [NSString stringWithFormat:@"%d",cTemp];
            [dic setObject:c forKey:kTemp];
            [dic setObject:@"0" forKey:kIsF];
            [_dataArray writeToFile:_path atomically:YES];
        }
        [_cityTab reloadData];
        _isF = NO;
        [btn setTitle:@"°C" forState:UIControlStateNormal];
    }
}

- (void)addCity:(UIButton *)btn
{
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"SH" forKey:kCityName];
    if (!_isF) {
        [dic setValue:@"35" forKey:kTemp];
    }
    else {
        [dic setValue:@"102" forKey:kTemp];
    }
    
    [_dataArray addObject:dic];
    [_dataArray writeToFile:_path atomically:YES];
    SearchCityController *searchCtrl = [[SearchCityController alloc]init];
    [self presentViewController:searchCtrl animated:YES completion:^{
        
    }];
}

@end




















