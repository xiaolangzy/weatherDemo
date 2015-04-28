//
//  CityInfo.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/28.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "CityInfo.h"

@implementation CityInfo

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //日期
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 10)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        //城市
        _cityName = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 200, 30)];
        _cityName.font = [UIFont systemFontOfSize:20];
        //温度
        _tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-70, 10, 60, 60)];
        _tempLabel.font = [UIFont systemFontOfSize:30];
        
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_cityName];
        [self.contentView addSubview:_tempLabel];
    }
    
    return self;
}

- (void)configData:(CityInfoModel *)cityInfoModel
{
    
}

@end
