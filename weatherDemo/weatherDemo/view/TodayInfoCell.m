//
//  TodayInfoCell.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/29.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "TodayInfoCell.h"

@implementation TodayInfoCell

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
        _infoLabel = [MyUtil createLabelFrame:CGRectMake(20, 0, kScreenWidth, 50) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft];
        _infoLabel.numberOfLines = 2;
        //_infoLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        [self.contentView addSubview:_infoLabel];
    }
    return self;
}

- (void)configTodayCell
{
    self.infoLabel.text = @"今天: 现在大部多云。最高气温20°。今晚晴朗，最低气温14°";
}
@end
