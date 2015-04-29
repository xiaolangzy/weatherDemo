//
//  TodayDetailCell.h
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayDetailCell : UITableViewCell
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

- (void)configTodayDetail;
@end
