//
//  SearchCityController.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/28.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "SearchCityController.h"

@interface SearchCityController ()<UISearchBarDelegate>
{
    UISearchController *_searchCtrl;
    
}
@end

@implementation SearchCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiInit];
    [self createSearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)uiInit
{
    UIImageView *weatherBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weatherBG.jpeg"]];
    weatherBG.frame = self.view.bounds;
    weatherBG.alpha = 0.5;
    [self.view addSubview:weatherBG];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 20)];
    titleLabel.text = @"输入城市、邮政编码或机场位置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:titleLabel];
}

- (void)createSearch
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 40, kScreenWidth-50, 30)];
    [_searchBar setDelegate:self];
    [_searchBar setShowsCancelButton:NO];
    [self.view addSubview:_searchBar];
    
    UIButton *cancelBtn = [MyUtil createBtnFrame:CGRectMake(kScreenWidth-45, 40, 40, 30) title:@"取消" bgImage:nil image:nil target:self action:@selector(cancelAction)];
    [_searchBar becomeFirstResponder];
    [self.view addSubview:cancelBtn];
}

#pragma mark --btnAction
- (void)cancelAction
{
   [self dismissViewControllerAnimated:YES completion:^{
       
   }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/cityName.plist"];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
    [array addObject:searchBar.text];
    [array writeToFile:path atomically:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

@end






















