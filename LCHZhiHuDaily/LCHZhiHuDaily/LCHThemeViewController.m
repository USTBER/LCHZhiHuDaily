//
//  LCHThemeViewController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHThemeViewController.h"
#import "LCHTopImageView.h"
#import "LCHThemeNewsModel.h"
#import "LCHThemePageConfig.h"
#import "LCHThemeNewsCell.h"
#import "CircleRefreshView.h"

@interface LCHThemeViewController ()
<UITableViewDataSource, UITableViewDelegate>

//控件
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) LCHTopImageView *topImageView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) CircleRefreshView *refreshView;

//数据源
@property (nonatomic, strong) NSMutableArray *themeNewsModels;

- (void)configConstraints;
- (void)getThemeNewsData;

//target - action
- (void)handleBack:(UIButton *)sender;
- (void)handleAdd:(UIButton *)sender;
- (void)handleRefresh;

@end

@implementation LCHThemeViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.refreshView];
    
    [self configConstraints];
    [self getThemeNewsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    
    WeakObject(weakSelf, self);
    WeakObject(weakTableView, self.tableView);
    WeakObject(weakTitleLabel, self.titleLabel);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(kHeight(kTableViewTopPadding));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(kHeight(kTitleLabelTopPadding));
        make.width.mas_greaterThanOrEqualTo(@0.1);
        make.height.mas_greaterThanOrEqualTo(@0.1);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(kHeight(kBackButtonTopPadding));
        make.left.equalTo(weakSelf.view).offset(kWidth(kBackButtonLeftPadding));
        make.width.mas_equalTo(kWidth(kBackButtonWidth));
        make.height.mas_equalTo(kHeight(kBackButtonHeight));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(kHeight(kAddButtonTopPadding));
        make.right.equalTo(weakSelf.view).offset(-kWidth(kAddButtonRightPadding));
        make.width.mas_equalTo(kWidth(kAddButtonWidth));
        make.height.mas_equalTo(kHeight(kAddButtonHeight));
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakTableView.mas_top);
        make.height.mas_equalTo(kHeight(kTopImageViewHeight));
        make.left.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view);
    }];
    
    [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakTitleLabel.mas_bottom);
        make.right.equalTo(weakTitleLabel.mas_left).offset(-kWidth(kRefreshViewRightPadding));
        make.width.mas_equalTo(kWidth(kRefreshViewWidth));
        make.height.mas_equalTo(kHeight(kRefreshViewHeight));
    }];
}

- (void)getThemeNewsData {
    
    NSString *url = [KThemeNewsAPI stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)self.themeModel.themeID]];
    
    [LCHDataManager getThemeNews:url success:^(NSMutableArray *models) {
        self.themeNewsModels = models;
        [self.tableView reloadData];
        [self.refreshView endRefreshing];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - target action

- (void)handleBack:(UIButton *)sender {
    
    
}

- (void)handleAdd:(UIButton *)sender {
    
    
}

- (void)handleRefresh {
    
    [self getThemeNewsData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.themeNewsModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCHThemeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:KThemeNewsCellIdenfitier];
    LCHThemeNewsModel *themeNewsModel = self.themeNewsModels[indexPath.row];
    if (themeNewsModel) {
        cell.titleLabel.text = themeNewsModel.title;
        cell.iconImageViewURL = themeNewsModel.images[0];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kHeight(kThemeNewsCellHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

#pragma mark - lazy loading

- (UITableView *)tableView {
    
    if (_tableView) {
        
        return _tableView;
    }
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[LCHThemeNewsCell class] forCellReuseIdentifier:KThemeNewsCellIdenfitier];
    
    return _tableView;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel) {
        
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return _titleLabel;
}

- (LCHTopImageView *)topImageView {
    
    if (_topImageView) {
        
        return _topImageView;
    }
    _topImageView = [LCHTopImageView attachToTableView:self.tableView];
    
    return _topImageView;
}

- (UIButton *)backButton {
    
    if (_backButton) {
        
        return _backButton;
    }
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setImage:[UIImage imageNamed:KBackButtonImageName] forState:UIControlStateNormal];
    
    return _backButton;
}

- (UIButton *)addButton {
    
    if (_addButton) {
        
        return _addButton;
    }
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addButton addTarget:self action:@selector(handleAdd:) forControlEvents:UIControlEventTouchUpInside];
    [_addButton setImage:[UIImage imageNamed:KAddButtonImageName] forState:UIControlStateNormal];
    
    return _addButton;
}

- (CircleRefreshView *)refreshView {
    
    if (_refreshView) {
        
        return _refreshView;
    }
    _refreshView = [CircleRefreshView attachObserveToScrollView:self.tableView target:self action:@selector(handleRefresh)];
    
    return _refreshView;
}

- (NSMutableArray *)themeNewsModels {
    
    if (_themeNewsModels) {
        
        return _themeNewsModels;
    }
    _themeNewsModels = [[NSMutableArray alloc] init];
    
    return _themeNewsModels;
}

- (void)setThemeModel:(LCHThemeModel *)themeModel {
    
    if (_themeModel == themeModel) {
        
        return;
    }
    _themeModel = themeModel;
    self.titleLabel.text = themeModel.name;
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:themeModel.thumbnail]];
    [self getThemeNewsData];
}
@end
