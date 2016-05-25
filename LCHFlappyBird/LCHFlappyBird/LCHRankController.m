//
//  LCHRankController.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHRankController.h"

@interface LCHRankController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *titleView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *titles;

@property (nonatomic, copy) NSArray *scores;


@property (nonatomic, strong) UITapGestureRecognizer *tap;

- (void)handleTap:(UITapGestureRecognizer *)tap;

- (void)configConstrains;

@end

@implementation LCHRankController

#pragma life circle of viewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tableView];
    [self.view addGestureRecognizer:self.tap];
    [self configConstrains];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma private method
- (void)configConstrains {
    
    WeakSelf(weakSelf);
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view).offset(kTopPadding);
        make.width.mas_equalTo(weakSelf.view).multipliedBy(1/kTitleViewWidthRate);
        make.height.mas_equalTo(weakSelf.view).multipliedBy(1/kTitleViewHeightRate);
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view).multipliedBy(kRankTableViewWidthRate);
        make.height.equalTo(weakSelf.view).multipliedBy(kRankTableViewHeightRate);
        make.top.equalTo(weakSelf.view).offset(kRankTableViewHeightPadding);
    }];
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(finishCurrentController:)]) {
        
        [self.delegate finishCurrentController:self];
    }
}


#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRankCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kRankCellReuseIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titles[[indexPath row]];
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:20];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.gameInfo.topFiveScore[indexPath.row]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Marker Felt" size:20];
    
    return cell;
}

#pragma UITableViewDelegate


#pragma lazy loading getter and setter
- (UITableView *)tableView {
    
    if (_tableView) {
        
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}

- (UIImageView *)titleView {
    
    if (_titleView) {
        
        return _titleView;
    }
    
    _titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main"]];
    return _titleView;
}


- (NSArray *)titles {
    
    if (_titles) {
        
        return _titles;
    }
    _titles = @[@"Top1", @"Top2", @"Top3", @"Top4", @"Top5"];
    
    return _titles;
}

- (NSArray *)scores {
    
    if (_scores) {
        
        return _scores;
    }
    
    return _scores;
}

- (UITapGestureRecognizer *)tap {
    
    if (_tap) {
        
        return _tap;
    }
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    return _tap;
}



@end
