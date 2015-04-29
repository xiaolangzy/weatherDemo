//
//  CityViewController.h
//  weatherDemo
//
//  Created by xiaolang on 15/4/27.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityViewControllerDelegate <NSObject>

- (void)didSelectedWithCityInfo:(NSInteger )index data:(NSMutableArray *)dataArray;

@end

@interface CityViewController : UIViewController

@property (nonatomic,weak)id<CityViewControllerDelegate>delegate;

@end
