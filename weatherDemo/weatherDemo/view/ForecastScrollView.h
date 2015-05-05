//
//  ForecastScrollView.h
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>
//各时间温度信息
@interface ForecastScrollView : UIScrollView

@end

@interface TimeInfo : UIView
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)UILabel *weatherLabel;
@end