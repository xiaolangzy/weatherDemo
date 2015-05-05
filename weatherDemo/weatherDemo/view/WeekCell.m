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
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
    for (int i=0; i<6; i++) {
        WeekView *weekView = [[WeekView alloc]initWithFrame:CGRectMake(0, i*25, kScreenWidth, 20)];
        [self.contentView addSubview:weekView];
    }
}

- (void)configWeekCellWith:(NSArray *)weekArray week:(NSDateComponents *)dateComponent withFutureInfo:(NSArray *)futureInfo
{
    for (int i = 0; i<[self.contentView.subviews count]; i++) {
        //星期几
       WeekView *view = [self.contentView.subviews objectAtIndex:i];
        long week = [dateComponent weekday];
        ((week + i + 1) > 6)?((week + i + 1) > 13)?(view.weekLabel.text = [weekArray objectAtIndex:week + i - 13]):(view.weekLabel.text = [weekArray objectAtIndex:week + i - 6]):(view.weekLabel.text = [weekArray objectAtIndex:week + i + 1]);
        //最低最高温
        NSString *temperInfo = futureInfo[i][@"temperature"];
        view.weekHighLow.text = temperInfo;
        if (![futureInfo[i][@"fa"] isEqualToString:futureInfo[i][@"fb"]]) {
            view.faImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",futureInfo[i][@"fa"]]];
            view.fbImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",futureInfo[i][@"fb"]]];
        }
        else {
            view.faImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",futureInfo[i][@"fa"]]];
            view.faImage.frame = CGRectMake(kScreenWidth/2-10, 0, 20, 20);
        }
    }
}

@end

@implementation WeekView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _weekLabel = [MyUtil createLabelFrame:CGRectMake(0, 0, kScreenWidth/5, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self addSubview:_weekLabel];
        _faImage = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-40, 0, 20, 20)];
        [self addSubview:_faImage];
        _fbImage = [[UIImageView alloc]initWithFrame:CGRectMake(_faImage.frame.origin.x + 60, 0, 20, 20)];
        [self addSubview:_fbImage];
        _weekHighLow = [MyUtil createLabelFrame:CGRectMake(kScreenWidth-100, 0, 100, 20) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentCenter];
        [self addSubview:_weekHighLow];
    }
    return self;
}

@end