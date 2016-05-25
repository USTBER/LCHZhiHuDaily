//
//  ViewController.m
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LCHFrontPageController.h"
#import <Masonry.h>
#import <NSLayoutConstraint+MASDebugAdditions.h>

@interface ViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *appIntroduceLabel;
@property (nonatomic, strong) UILabel *askForStarLabel;
@property (nonatomic, strong) UILabel *emailAdressLabel;
@property (nonatomic, copy) NSArray *pageInfos;
@property (nonatomic, copy) NSDictionary *pageDic;

- (void)configConstrains;

@end

@implementation ViewController

#pragma mark - lifeCircle of ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.appIntroduceLabel];
    [self.view addSubview:self.askForStarLabel];
    [self.view addSubview:self.emailAdressLabel];
    [self configConstrains];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"效果类型";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - overWrite

#pragma mark - privateMethod

- (void)configConstrains {
    
    WeakSelf(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view).multipliedBy(4/7.f);
        make.left.equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view.width * 1/15);
    }];
    
    [self.appIntroduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(20);
        make.right.equalTo(weakSelf.view).offset(-20);
        make.top.equalTo(self.tableView.mas_bottom).offset(10);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.pageInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rootTableViewCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.pageInfos[indexPath.row];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, cell.height - 2, cell.width - 30, 2)];
    lineView.backgroundColor = [UIColor blackColor];
    [cell.contentView addSubview:lineView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LCHFrontPageController *frontPageController = [[LCHFrontPageController alloc] init];
    [self.navigationController pushViewController:frontPageController animated:YES];
    
}

#pragma mark - lazyloading getter and setter

- (UITableView *)tableView {
    
    if (_tableView) {
        
        return _tableView;
    }
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = false;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rootTableViewCellIdentifier];
    
    return _tableView;
}

- (UILabel *)appIntroduceLabel {
    
    if (_appIntroduceLabel) {
        
        return _appIntroduceLabel;
    }
    _appIntroduceLabel = [[UILabel alloc] init];
    _appIntroduceLabel.numberOfLines = 0;
    _appIntroduceLabel.textAlignment = NSTextAlignmentLeft;
    NSString *info = [self.pageDic objectForKey:@"firstAppInfo"];
    if (info) {
        _appIntroduceLabel.text = info;
    } else {
        _appIntroduceLabel.text = @"App简介：敬请期待";
        LCH_LOG_NULL_ERROR;
    }
    
    return _appIntroduceLabel;
}

- (UILabel *)askForStarLabel {
    
    if (_askForStarLabel) {
        
        return _askForStarLabel;
    }
    _askForStarLabel = [[UILabel alloc] init];
    _askForStarLabel.numberOfLines = 0;
    _askForStarLabel.textAlignment = NSTextAlignmentLeft;
    NSString *info = [self.pageDic objectForKey:@"secondAppInfo"];
    if (info) {
        _askForStarLabel.text = info;
    } else {
        _askForStarLabel.text = @"求Star";
        LCH_LOG_NULL_ERROR;
    }

    return _askForStarLabel;
}

- (UILabel *)emailAdressLabel {
    
    if (_emailAdressLabel) {
        
        return _emailAdressLabel;
    }
    _emailAdressLabel = [[UILabel alloc] init];
    _emailAdressLabel.numberOfLines = 0;
    _emailAdressLabel.textAlignment = NSTextAlignmentLeft;
    NSString *info = [self.pageDic objectForKey:@"thirdAppInfo"];
    if (info) {
        _emailAdressLabel.text = info;
    } else {
        _emailAdressLabel.text = @"如有不懂，请联系我";
        LCH_LOG_NULL_ERROR;
    }
    
    return _emailAdressLabel;
}

- (NSArray *)pageInfos {
    
    if (_pageInfos) {
        
        return _pageInfos;
    }
    _pageInfos = [self.pageDic objectForKey:@"pageInfos"];
    if (!_pageInfos) {
        LCH_LOG_NULL_ERROR;
    }

    return _pageInfos;
}

- (NSDictionary *)pageDic {
    
    if (_pageDic) {
        
        return _pageDic;
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PageInfoList" ofType:@"plist"];
    _pageDic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    if (!_pageDic) {
        LCH_LOG_NULL_ERROR;
    }
    
    return _pageDic;
}

@end
