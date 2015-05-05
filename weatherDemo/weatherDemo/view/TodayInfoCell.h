//
//  TodayInfoCell.h
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>
//今日温馨提示
@interface TodayInfoCell : UITableViewCell
@property (nonatomic,strong)UILabel *infoLabel;
- (void)configTodayCell:(NSString *)infoString;
@end
