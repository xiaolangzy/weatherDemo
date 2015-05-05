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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _infoLabel = [MyUtil createLabelFrame:CGRectMake(10, 0, kScreenWidth-10, 0) text:nil font:[UIFont systemFontOfSize:17] textAlignment:NSTextAlignmentLeft];
        _infoLabel.numberOfLines = 0;
        [self.contentView addSubview:_infoLabel];
    }
    return self;
}

- (void)configTodayCell:(NSString *)infoString
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    CGFloat h = [infoString boundingRectWithSize:CGSizeMake(kScreenWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size.height;
    _infoLabel.text = infoString;
    _infoLabel.frame = CGRectMake(10, 0, kScreenWidth-10, h);
}
@end
