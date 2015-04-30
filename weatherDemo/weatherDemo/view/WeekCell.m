//
//  WeekCell.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "WeekCell.h"

@implementation WeekCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createWeekView];
    }
    return self;
}

- (void)createWeekView
{
    for (int i=0; i<9; i++) {
        WeekView *weekView = [[WeekView alloc]initWithFrame:CGRectMake(0, i*20, kScreenWidth, 20)];
        [self.contentView addSubview:weekView];
    }
}

- (void)configWeekCellWith:(NSArray *)weekArray week:(NSDateComponents *)dateComponent
{
    for (int i = 0; i<[self.contentView.subviews count]; i++) {
        //星期几
       WeekView *view = [self.contentView.subviews objectAtIndex:i];
        long week = [dateComponent weekday];
        ((week + i + 1) > 6)?((week + i + 1) > 13)?(view.weekLabel.text = [weekArray objectAtIndex:week + i - 13]):(view.weekLabel.text = [weekArray objectAtIndex:week + i - 6]):(view.weekLabel.text = [weekArray objectAtIndex:week + i + 1]);
        //最低最高温
        view.weekHighLow.text = [NSString stringWithFormat:@"%d  %d",i+20,i+25];
    }

}

@end

@implementation WeekView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _weekLabel = [MyUtil createLabelFrame:CGRectMake(0, 0, kScreenWidth/5, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self addSubview:_weekLabel];
        _weekImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-20, 0, 20, 20)];
        [self addSubview:_weekImage];
        _weekHighLow = [MyUtil createLabelFrame:CGRectMake(kScreenWidth-100, 0, 100, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self addSubview:_weekHighLow];
    }
    return self;
}

@end