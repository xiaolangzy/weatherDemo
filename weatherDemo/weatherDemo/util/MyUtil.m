//
//  MyUtil.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/27.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "MyUtil.h"

@implementation MyUtil

+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImage:(NSString *)bgImageName image:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (title)
    {
       [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    if (bgImageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    if (imageName)
    {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (target && action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return btn;
}

@end
