//
//  MainView.h
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView
@property (nonatomic,strong)UILabel *cityNameLabel;
@property (nonatomic,strong)UILabel *cityTemptLabel;
@property (nonatomic,strong)UILabel *weatherInfoLabel;
@property (nonatomic,strong)UILabel *lowHighLabel;
//加载数据
- (void)configWeatherInfo:(NSDictionary *)dataDic;
@end
