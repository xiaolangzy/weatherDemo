//
//  WeekCell.h
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekCell : UITableViewCell
- (void)configWeekCellWith:(NSArray *)weekArray week:(NSDateComponents *)dateComponent;
@end

@interface WeekView : UIView
//星期几
@property (nonatomic,strong)UILabel *weekLabel;
//图片
@property (nonatomic,strong)UIImageView *weekImage;
//最低最高温
@property (nonatomic,strong)UILabel *weekHighLow;
@end