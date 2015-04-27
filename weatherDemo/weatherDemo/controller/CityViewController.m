//
//  CityViewController.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/27.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_cityTab;
}
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uiInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTabView];
}

- (void)createTabView
{
    _cityTab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _cityTab.delegate = self;
    _cityTab.dataSource = self;
    _cityTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_cityTab];
}

#pragma mark - uitableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

@end
