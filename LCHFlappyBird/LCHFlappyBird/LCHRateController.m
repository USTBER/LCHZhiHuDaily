//
//  LCHRateController.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHRateController.h"


@interface LCHRateController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *titleView;

@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray *difficulities;

- (void)configConstrains;

@end

@implementation LCHRateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.tableView];
    [self configConstrains];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configConstrains {
    
    WeakSelf(weakSelf);
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view).offset(kTopPadding);
        make.width.mas_equalTo(weakSelf.view).multipliedBy(1/kTitleViewWidthRate);
        make.height.mas_equalTo(weakSelf.view).multipliedBy(1/kTitleViewHeightRate);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.titleView).offset(kTopPadding);
        make.width.mas_equalTo(weakSelf.view).multipliedBy(1/kRateLabelWidthRate);
        make.height.mas_equalTo(weakSelf.view).multipliedBy(1/kRateLabelHeightRate);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view).multipliedBy(kRateTableViewWidthRate);
        make.height.equalTo(weakSelf.view).multipliedBy(kRateTableViewHeightRate);
        make.top.equalTo(weakSelf.view).offset(kRateTableViewHeightPadding);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.difficulities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRateCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRateCellReuseIdentifier];
    }
    cell.textLabel.text = self.difficulities[[indexPath row]];
    cell.textLabel.font = [UIFont fontWithName:@"Marker Felt" size:18];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == self.gameInfo.gameDegree) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.gameInfo.gameDegree = indexPath.row;
    [tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{        
        if ([self.delegate respondsToSelector:@selector(finishCurrentController:)]) {
            [self.delegate finishCurrentController:self];
        }
    });
    
    
}

- (UIImageView *)titleView {
    
    if (_titleView) {
        
        return _titleView;
    }
    
    _titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main"]];
    return _titleView;
}



- (UILabel *)tipLabel {
    
    if (_tipLabel) {
        
        return _tipLabel;
    }
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.text = @"The game difficulty";
    _tipLabel.font = [UIFont fontWithName:@"Marker Felt" size:25];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.textColor = [UIColor orangeColor];
    return _tipLabel;
}

- (UITableView *)tableView {
    
    if (_tableView) {
        
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    return _tableView;
}

- (NSArray *)difficulities {
    
    if (_difficulities) {
        
        return _difficulities;
    }
    _difficulities = @[@"crazy", @"hard", @"difficult", @"general", @"ordinary"];
    
    return _difficulities;
}



@end
