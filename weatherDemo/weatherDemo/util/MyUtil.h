//
//  MyUtil.h
//  weatherDemo
//
//  Created by xiaolang on 15/4/27.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUtil : NSObject
+ (UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title bgImage:(NSString *)bgImageName image:(NSString *)imageName target:(id)target action:(SEL)action;

@end
