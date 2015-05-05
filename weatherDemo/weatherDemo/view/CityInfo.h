//
//  CityInfo.h
//  weatherDemo
//
//  Created by xiaolang on 15/4/28.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityInfoModel.h"
//城市简略信息
@interface CityInfo : UITableViewCell

@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *cityName;
@property (nonatomic,strong)UILabel *tempLabel;

- (void)configData:(CityInfoModel *)cityInfoModel;

@end
