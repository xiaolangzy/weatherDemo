//
//  MainView.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "MainView.h"
#import "ForecastScrollView.h"
#import "WeekCell.h"
#import "TodayInfoCell.h"
#import "TodayDetailCell.h"

@interface MainView()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tabView;
    NSMutableArray *_dataArray;
    //城市信息
    UIView *_cityView;
    //时间信息
    NSArray *_arrWeek;
    NSDateComponents *_dateComponent;
}
@end

@implementation MainView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self uiInit];
    }
    return self;
}

- (void)uiInit
{
    _arrWeek =[NSArray arrayWithObjects:@"星期六",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五", nil];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self createCityView];
    [self createTabView];
}

- (void)createCityView
{
    _cityView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
    _cityView.backgroundColor = [UIColor grayColor];
    //城市名
    _cityNameLabel = [MyUtil createLabelFrame:CGRectMake(0, 10, kScreenWidth, 30) text:@"上海直辖市" font:[UIFont systemFontOfSize:20] textAlignment:NSTextAlignmentCenter];
    [_cityView addSubview:_cityNameLabel];
    //当前天气信息
    _weatherInfoLabel = [MyUtil createLabelFrame:CGRectMake(0, 40, kScreenWidth, 15) text:@"晴间多云" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter];
    [_cityView addSubview:_weatherInfoLabel];
    //温度
    _cityTemptLabel = [MyUtil createLabelFrame:CGRectMake(0, _weatherInfoLabel.frame.origin.y + 15 + 5, kScreenWidth, 80) text:@"10°" font:[UIFont systemFontOfSize:80] textAlignment:NSTextAlignmentCenter];
    [_cityView addSubview:_cityTemptLabel];
    //今天信息
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday;
    _dateComponent = [calendar components:unitFlags fromDate:now];
    UILabel *today = [MyUtil createLabelFrame:CGRectMake(20, _cityView.frame.size.height-20,100 , 20) text:[NSString stringWithFormat:@"%@  今天",[_arrWeek objectAtIndex:[_dateComponent weekday]]] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft];
    [_cityView addSubview:today];
    //最高最低温度
    _lowHighLabel = [MyUtil createLabelFrame:CGRectMake(kScreenWidth-20-100, _cityView.frame.size.height-20, 100, 20) text:@"31   18" font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight];
    [_cityView addSubview:_lowHighLabel];
    [self addSubview:_cityView];
}

- (void)createTabView
{
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, _cityView.frame.size.height, kScreenWidth, kScreenHeight-44-_cityView.frame.size.height-20) style:UITableViewStylePlain];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    _tabView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tabView];
}

#pragma mark - UITabViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 65;
    }
    else {
        if (indexPath.row == 0) {
            return 180;
        }
        else if (indexPath.row == 1) {
            return 50;
        }
        else {
            return 280;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *sectionOne = @"sectionOneId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionOne];
        for (int i = 0; i<[cell.contentView.subviews count]; i++) {
            [[cell.contentView.subviews objectAtIndex:i] removeFromSuperview];
        }
        if (!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sectionOne];
        }
        [cell.contentView addSubview:[self createTimeInfo]];
        return cell;
        
    }
    else {
        if (indexPath.row == 0) {
            static NSString *weekCell = @"weekCellId";
            WeekCell *cell = [tableView dequeueReusableCellWithIdentifier:weekCell];
            if (!cell) {
                cell = [[WeekCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weekCell];
            }
            [cell configWeekCellWith:_arrWeek week:_dateComponent];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        else if (indexPath.row == 1) {
            static NSString *todayInfoCell = @"todayInfoCellId";
            TodayInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:todayInfoCell];
            if (!cell) {
                cell = [[TodayInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:todayInfoCell];
            }
            [cell configTodayCell];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        else {
            static NSString *todayDetailCell = @"todayDetailId";
            TodayDetailCell *cell = [tableView   dequeueReusableCellWithIdentifier:todayDetailCell];
            if (!cell) {
                cell = [[TodayDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:todayDetailCell];
            }
            [cell configTodayDetail];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }
}

#pragma mark --创建各个Cell
- (ForecastScrollView *)createTimeInfo
{
    ForecastScrollView *timeScroll = [[ForecastScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    
    int width = kScreenWidth/5;
    for (int i=0; i<26; i++) {
        TimeInfo *timeInfo = [[TimeInfo alloc]initWithFrame:CGRectMake(i*width, 0, width,timeScroll.frame.size.height)];
        NSInteger time = [_dateComponent hour]+i;
        (time > 12)?(time > 24)?(time >36)?(timeInfo.timeLabel.text = [NSString stringWithFormat:@"下午%ld时",time-36]):(timeInfo.timeLabel.text = [NSString stringWithFormat:@"上午%ld时",time-24]):(timeInfo.timeLabel.text = [NSString stringWithFormat:@"下午%ld时",time-12]):(timeInfo.timeLabel.text = [NSString stringWithFormat:@"上午%ld时",time]);
        if (time%12==0 && time%24!=0) {
            timeInfo.timeLabel.text = @"下午12时";
        }
        else if (i==0){
            timeInfo.timeLabel.text = @"现在";
        }
        else if (time%24==0){
            timeInfo.timeLabel.text = @"上午12时";
        }
        timeInfo.weatherLabel.text = [NSString stringWithFormat:@"%d",21+i];
        [timeScroll addSubview:timeInfo];
    }
    return timeScroll;
}

@end
