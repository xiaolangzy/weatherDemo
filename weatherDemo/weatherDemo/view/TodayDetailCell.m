//
//  TodayDetailCell.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "TodayDetailCell.h"

@implementation TodayDetailCell
/*
 //日出
 @property (nonatomic,strong)UILabel *sunriseLabel;
 //日落
 @property (nonatomic,strong)UILabel *sunsetLabel;
 //降雨概率
 @property (nonatomic,strong)UILabel *rainfallLabel;
 //湿度
 @property (nonatomic,strong)UILabel *humidityLabel;
 //风速
 @property (nonatomic,strong)UILabel *windSpeedLabel;
 //体感温度
 @property (nonatomic,strong)UILabel *feltLabel;
 //降雨量
 @property (nonatomic,strong)UILabel *rainLabel;
 //气压
 @property (nonatomic,strong)UILabel *airLabel;
 //能见度
 @property (nonatomic,strong)UILabel *visibilityLabel;
 //紫外线指数
 @property (nonatomic,strong)UILabel *rayLabel;
 */
- (void)awakeFromNib {
    // Initialization code
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

- (void)configTodayDetail
{
    self.sunriseLabel.text = @"日出:  上午5:14";
    self.sunsetLabel.text = @"日落:  下午6:35";
    self.rainfallLabel.text = @"降雨概率:  0%";
    self.humidityLabel.text = @"湿度:  70%";
    self.windSpeedLabel.text = @"风速:  西北偏北5米/秒";
    self.feltLabel.text = @"体感温度:  19°";
    self.rainLabel.text = @"降雨量: 0.9厘米";
    self.airLabel.text = @"气压:  1013百帕";
    self.visibilityLabel.text = @"能见度: 16.1公里";
    self.rayLabel.text = @"紫外线指数:  2";
}
@end













