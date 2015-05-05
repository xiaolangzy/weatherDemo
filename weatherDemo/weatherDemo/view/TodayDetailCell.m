//
//  TodayDetailCell.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "TodayDetailCell.h"

@implementation TodayDetailCell
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _sunriseLabel = [MyUtil createLabelFrame:CGRectMake(0, 0, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_sunriseLabel];
        _sunsetLabel = [MyUtil createLabelFrame:CGRectMake(0, 20, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_sunsetLabel];
        _rainfallLabel = [MyUtil createLabelFrame:CGRectMake(0, 60, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_rainfallLabel];
        _humidityLabel = [MyUtil createLabelFrame:CGRectMake(0, 80, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_humidityLabel];
        _windSpeedLabel = [MyUtil createLabelFrame:CGRectMake(0, 120, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_windSpeedLabel];
        _feltLabel = [MyUtil createLabelFrame:CGRectMake(0, 140, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_feltLabel];
        _rainLabel = [MyUtil createLabelFrame:CGRectMake(0, 180, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_rainLabel];
        _airLabel = [MyUtil createLabelFrame:CGRectMake(0, 200, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_airLabel];
        _visibilityLabel = [MyUtil createLabelFrame:CGRectMake(0, 240, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_visibilityLabel];
        _rayLabel = [MyUtil createLabelFrame:CGRectMake(0, 260, kScreenWidth, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:_rayLabel];
    }
    return self;
}

- (void)configTodayDetail:(NSDictionary *)todayDic andSkDic:(NSDictionary *)skDic
{
    self.sunriseLabel.text = @"日出:  上午5:14";
    self.sunsetLabel.text = @"日落:  下午6:35";
    self.rainfallLabel.text = @"降雨概率:  0%";
    self.humidityLabel.text = [NSString stringWithFormat:@"湿度:  %@%%",skDic[@"humidity"]];
    self.windSpeedLabel.text = [NSString stringWithFormat:@"风速:  %@  %@",skDic[@"wind_direction"],skDic[@"wind_strength"]];
    self.feltLabel.text = [NSString stringWithFormat:@"体感:  %@",todayDic[@"dressing_index"]];
    self.rainLabel.text = @"降雨量: 0.9厘米";
    self.airLabel.text = @"气压:  1013百帕";
    self.visibilityLabel.text = @"能见度: 16.1公里";
    self.rayLabel.text = [NSString stringWithFormat:@"紫外线指数:  %@",todayDic[@"uv_index"]];
}
@end













