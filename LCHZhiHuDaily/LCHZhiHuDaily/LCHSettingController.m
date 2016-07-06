//
//  LCHSettingController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHSettingController.h"
#import "LCHSettingPageConfig.h"
#import "LCHSettingUserCell.h"
#import "LCHSettingWithSwitchCell.h"
#import "LCHSettingWithIndicatorCell.h"

@class UITableViewCell;
typedef UITableViewCell* (^CellSettingBlock)(UITableView *tableView, NSIndexPath *indexpath);

@interface LCHSettingController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *info;
@property (nonatomic, strong) NSMutableArray *cellSettingBlocks;

- (void)handleBack:(UIButton *)sender;
- (void)configConstraints;

@end

@implementation LCHSettingController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.tableView];
    
    [self configConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    
    WeakObject(weakTopBar, self.topBar);
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.offset(0);
        make.height.mas_equalTo(kHeight(kSettingPageTopBarHeight));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(kSettingPageBackButtonTopPadding));
        make.left.offset(kWidth(kSettingPageBackButtonLeftPadding));
        make.width.mas_equalTo(kWidth(kSettingPageBackButtonWidth));
        make.height.mas_equalTo(kHeight(kSettingPageBackButtonHeight));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(kHeight(kSettingPageTitleLabelTopPadding));
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.offset(0);
        make.top.equalTo(weakTopBar.mas_bottom);
    }];
}

- (void)handleBack:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.info.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *array = self.info[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellSettingBlock block = self.cellSettingBlocks[indexPath.section];
    UITableViewCell *cell = block(tableView, indexPath);
    if ([cell isMemberOfClass:[LCHSettingUserCell class]]) {
        LCHSettingUserCell *userCell = (LCHSettingUserCell *)cell;
//        [userCell.avatar roundRectImageView];
        
        return userCell;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return kSettingTableFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kSettingTableFooterReuseIdentifier];
    if (!view) {
        
        view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kSettingCellHeight;
}

#pragma mark - lazy loading

- (UIView *)topBar {
    
    if (_topBar) {
        
        return _topBar;
    }
    _topBar = [[UIView alloc] init];
    _topBar.backgroundColor = kColor(23, 144, 211, 1);
    
    return _topBar;
}

- (UIButton *)backButton {
    
    if (_backButton) {
        
        return _backButton;
    }
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:kSettingPageBackButtonImageName] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    
    return _backButton;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel) {
        
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:kSettingPageTitleLabelFontSize];
    _titleLabel.text = @"设置";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return _titleLabel;
}

- (UITableView *)tableView {
    
    if (_tableView) {
        
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[LCHSettingUserCell class] forCellReuseIdentifier:kSettingUserCellReuseIndentifier];
    [_tableView registerClass:[LCHSettingWithSwitchCell class] forCellReuseIdentifier:kSettingWithSwitchCellReuseIndentifier];
    [_tableView registerClass:[LCHSettingWithIndicatorCell class] forCellReuseIdentifier:kSettingWithIndicatorCellReuseIndentifier];
    _tableView.contentInset = UIEdgeInsetsMake(kSettingTableFooterHeight, 0, 0, 0);
    _tableView.contentOffset = CGPointMake(0, -kSettingTableFooterHeight);
    _tableView.backgroundColor = [UIColor colorWithWhite:0.95f alpha:0.8];
    
    return _tableView;
}

- (NSMutableArray *)info {
    
    if (_info) {
        
        return _info;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Setting" ofType:@"plist"];
    _info = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    return _info;
}

- (NSMutableArray *)cellSettingBlocks {
    
    if (_cellSettingBlocks) {
        
        return _cellSettingBlocks;
    }
    _cellSettingBlocks = [[NSMutableArray alloc] init];
    WeakObject(weakSelf, self);
    
    CellSettingBlock firstBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        LCHSettingUserCell *userCell = [tableView dequeueReusableCellWithIdentifier:kSettingUserCellReuseIndentifier forIndexPath:indexPath];
        userCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSMutableArray *arr = weakSelf.info[indexPath.section];
        userCell.actionLabel.text = arr[indexPath.row];
        [userCell.avatar setImage:[UIImage imageNamed:kSettingCellAvatarImageName]];
        //        [userCell.avatar roundRectImageView];
        
        return userCell;
    };
    
    CellSettingBlock secondBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
        LCHSettingWithSwitchCell *switchCell = [tableView dequeueReusableCellWithIdentifier:kSettingWithSwitchCellReuseIndentifier forIndexPath:indexPath];
        NSMutableArray *arr = weakSelf.info[indexPath.section];
        switchCell.actionLabel.text = arr[indexPath.row];
        
        return switchCell;
    };
    
    CellSettingBlock thirdBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
        LCHSettingWithIndicatorCell *indicatorCell = [tableView dequeueReusableCellWithIdentifier:kSettingWithIndicatorCellReuseIndentifier forIndexPath:indexPath];
        NSMutableArray *arr = weakSelf.info[indexPath.section];
        indicatorCell.actionLabel.text = arr[indexPath.row];
        indicatorCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return indicatorCell;
    };
    
    CellSettingBlock forthBlock = ^(UITableView *tableView, NSIndexPath *indexPath) {
        
        LCHSettingWithIndicatorCell *indicatorCell = [tableView dequeueReusableCellWithIdentifier:kSettingWithIndicatorCellReuseIndentifier forIndexPath:indexPath];
        NSMutableArray *arr = weakSelf.info[indexPath.section];
        indicatorCell.actionLabel.text = arr[indexPath.row];
        indicatorCell.accessoryType = UITableViewCellAccessoryNone;
        
        return indicatorCell;
    };
    [_cellSettingBlocks addObject:firstBlock];
    [_cellSettingBlocks addObject:secondBlock];
    [_cellSettingBlocks addObject:secondBlock];
    [_cellSettingBlocks addObject:secondBlock];
    [_cellSettingBlocks addObject:thirdBlock];
    [_cellSettingBlocks addObject:forthBlock];
    
    return _cellSettingBlocks;
}


@end
