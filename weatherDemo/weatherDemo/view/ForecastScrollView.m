//
//  ForecastScrollView.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "ForecastScrollView.h"

@implementation ForecastScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.contentSize = CGSizeMake(kScreenWidth/5*26, 0);
    }
    return self;
}

@end

@implementation TimeInfo

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        //时间
        _timeLabel = [MyUtil createLabelFrame:CGRectMake(0, 0, self.frame.size.width, 20) text:nil font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter];
        [self addSubview:_timeLabel];
        //天气图标
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(40, 20, 20, 20)];
        [self addSubview:_image];
        //温度
        _weatherLabel = [MyUtil createLabelFrame:CGRectMake(0, 40, self.frame.size.width, 20) text:nil font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter];
        [self addSubview:_weatherLabel];
    }
    return self;
}

@end