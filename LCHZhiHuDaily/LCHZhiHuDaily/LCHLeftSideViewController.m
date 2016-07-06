//
//  LCHLeftSideViewController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHLeftSideViewController.h"
#import "LCHLeftSideDrawerConfig.h"
#import "LCHThemeModel.h"
#import "LCHLeftSideDrawerCell.h"
#import "LCHLoginController.h"
#import "LCHMessageController.h"
#import "LCHSettingController.h"

@interface LCHLeftSideViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *collectionButton;
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UIButton *downloadButton;
@property (nonatomic, strong) UIButton *nightButton;
@property (nonatomic, strong) UITableView *tableView;


- (void)handleLogin:(UIButton *)sender;
- (void)handleCollection:(UIButton *)sender;
- (void)handleMessage:(UIButton *)sender;
- (void)handleSetting:(UIButton *)sender;
- (void)handleDownload:(UIButton *)sender;
- (void)handleNight:(UIButton *)sender;

- (void)configConstraints;
- (void)getThemesData;

@property (nonatomic, strong) NSMutableArray *themes;

@end

@implementation LCHLeftSideViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k18WhiteColor;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.collectionButton];
    [self.view addSubview:self.messageButton];
    [self.view addSubview:self.settingButton];
    [self.view addSubview:self.downloadButton];
    [self.view addSubview:self.nightButton];
    
    [self configConstraints];
    [self getThemesData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    
    WeakObject(weakSelf, self);
    WeakObject(weakLoginButton, self.loginButton);
    WeakObject(weakCollectionButton, self.collectionButton);
    WeakObject(weakMessageButton, self.messageButton);
    WeakObject(weakDownloadButton, self.downloadButton);
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(kHeight(kLoginButtonTopPadding));
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(kHeight(kLoginButtonHeight));
    }];
    
    [self.collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakLoginButton.mas_bottom);
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(1/3.f);
        make.left.equalTo(weakSelf.view);
        make.height.mas_equalTo(kHeight(kCollectionButtonHeight));
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakLoginButton.mas_bottom);
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(1/3.f);
        make.left.equalTo(weakCollectionButton.mas_right);
        make.height.mas_equalTo(kHeight(kMessageButtonHeight));
    }];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakLoginButton.mas_bottom);
        make.width.equalTo(weakSelf.view.mas_width).multipliedBy(1/3.f);
        make.left.equalTo(weakMessageButton.mas_right);
        make.height.mas_equalTo(kHeight(kSettingButtonHeight));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakCollectionButton.mas_bottom);
        make.bottom.equalTo(weakDownloadButton.mas_top);
        make.width.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
    }];
    
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view).multipliedBy(1/2.f);
        make.height.mas_equalTo(kHeight(kDownloadButtonHieght));
    }];
    
    [self.nightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view).multipliedBy(1/2.f);
        make.height.mas_equalTo(kHeight(kNightButtonHieght));
    }];
}

- (void)getThemesData {
    
    [LCHDataManager getLeftSideDrawerThemes:kThemesAPI success:^(NSMutableArray *models) {
        
        [self.themes addObjectsFromArray:models];
        [self.tableView reloadData];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - target action

- (void)handleLogin:(UIButton *)sender {
    
    LCHLoginController *loginController = [[LCHLoginController alloc] init];
    [self presentViewController:loginController animated:YES completion:nil];
}

- (void)handleCollection:(UIButton *)sender {
    LCHLoginController *loginController = [[LCHLoginController alloc] init];
    [self presentViewController:loginController animated:YES completion:nil];
    
}

- (void)handleMessage:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(switchToMessage)]) {
        [self.delegate switchToMessage];
    } else {
        LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
    }
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathsForSelectedRows][0] animated:NO];
}

- (void)handleSetting:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(switchToSetting)]) {
        [self.delegate switchToSetting];
    } else {
        LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
    }
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathsForSelectedRows][0] animated:NO];
}

- (void)handleDownload:(UIButton *)sender {
    
    
}

- (void)handleNight:(UIButton *)sender {
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.themes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCHLeftSideDrawerCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeftSideDrawerCellIdentifier];
    LCHThemeModel *themeModel = self.themes[indexPath.row];
    if (themeModel) {
        cell.themeLabel.text = themeModel.name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        if ([self.delegate respondsToSelector:@selector(switchToHome)]) {
            [self.delegate switchToHome];
        } else {
            LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
        }
        
    } else {
        
        if ([self.delegate respondsToSelector:@selector(switchToOtherTheme:)]) {
            LCHThemeModel *themeModel = self.themes[indexPath.row];
            [self.delegate switchToOtherTheme:themeModel];
        } else {
            LCH_LOG_DELEGATE_DID_NOT_RESPONSE_ERROR;
        }
    }
}

#pragma mark - lazy loading

- (UIButton *)loginButton {
    
    if (_loginButton) {
        
        return _loginButton;
    }
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:kLoginButtonFontSize];
    [_loginButton setTitle:kLoginButtonText forState:UIControlStateNormal];
    [_loginButton setImage:[UIImage imageNamed:kLoginButtonImageName] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(handleLogin:) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _loginButton.contentEdgeInsets = UIEdgeInsetsMake(0, kWidth(15), 0, 0);
    _loginButton.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(15), 0, 0);
    
    return _loginButton;
    
}

- (UIButton *)collectionButton {
    
    if (_collectionButton) {
        
        return _collectionButton;
    }
    _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectionButton.titleLabel.font = [UIFont systemFontOfSize:kCollectionButtonFontSize];
    [_collectionButton setTitle:kCollectionButtonText forState:UIControlStateNormal];
    [_collectionButton setImage:[UIImage imageNamed:kCollectionButtonImageName] forState:UIControlStateNormal];
    [_collectionButton addTarget:self action:@selector(handleCollection:) forControlEvents:UIControlEventTouchUpInside];
    _collectionButton.contentEdgeInsets = UIEdgeInsetsMake(kHeight(5), kWidth(5), 0, 0);
    _collectionButton.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(5), 0, 0);
    
    return _collectionButton;
}

- (UIButton *)messageButton {
    
    if (_messageButton) {
        
        return _messageButton;
    }
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _messageButton.titleLabel.font = [UIFont systemFontOfSize:kMessageButtonFontSize];
    [_messageButton setTitle:kMessageButtonText forState:UIControlStateNormal];
    [_messageButton setImage:[UIImage imageNamed:kMessageButtonImageName] forState:UIControlStateNormal];
    [_messageButton addTarget:self action:@selector(handleMessage:) forControlEvents:UIControlEventTouchUpInside];
    _messageButton.contentEdgeInsets = UIEdgeInsetsMake(kHeight(5), kWidth(5), 0, 0);
    _messageButton.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(5), 0, 0);
    
    return _messageButton;
}

- (UIButton *)settingButton {
    
    if (_settingButton) {
        
        return _settingButton;
    }
    _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingButton.titleLabel.font = [UIFont systemFontOfSize:kSettingButtonFontSize];
    [_settingButton setTitle:kSettingButtonText forState:UIControlStateNormal];
    [_settingButton setImage:[UIImage imageNamed:kSettingButtonImageName] forState:UIControlStateNormal];
    [_settingButton addTarget:self action:@selector(handleSetting:) forControlEvents:UIControlEventTouchUpInside];
    _settingButton.contentEdgeInsets = UIEdgeInsetsMake(kHeight(5), kWidth(5), 0, 0);
    _settingButton.titleEdgeInsets = UIEdgeInsetsMake(0, kWidth(5), 0, 0);
    
    return _settingButton;
}

- (UIButton *)downloadButton {
    
    if (_downloadButton) {
        
        return _downloadButton;
    }
    _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _downloadButton.titleLabel.font = [UIFont systemFontOfSize:kDownloadButtonFontSize];
    [_downloadButton setTitle:kDownloadButtonText forState:UIControlStateNormal];
    [_downloadButton setImage:[UIImage imageNamed:kDownloadButtonImageName] forState:UIControlStateNormal];
    [_downloadButton addTarget:self action:@selector(handleDownload:) forControlEvents:UIControlEventTouchUpInside];
    _downloadButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _downloadButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    
    return _downloadButton;
}

- (UIButton *)nightButton {
    
    if (_nightButton) {
        
        return _nightButton;
    }
    _nightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nightButton.titleLabel.font = [UIFont systemFontOfSize:kNightButtonFontSize];
    [_nightButton setTitle:kNightButtonText forState:UIControlStateNormal];
    [_nightButton setImage:[UIImage imageNamed:kNightButtonImageName] forState:UIControlStateNormal];
    [_nightButton addTarget:self action:@selector(handleNight:) forControlEvents:UIControlEventTouchUpInside];
    _nightButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    _nightButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    
    
    return _nightButton;
}

- (UITableView *)tableView {
    
    if (_tableView) {
        
        return _tableView;
    }
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = k18WhiteColor;
    [_tableView registerClass:[LCHLeftSideDrawerCell class] forCellReuseIdentifier:kLeftSideDrawerCellIdentifier];
    
    return _tableView;
}

- (NSMutableArray *)themes {
    
    if (_themes) {
        
        return _themes;
    }
    _themes = [[NSMutableArray alloc] init];
    LCHThemeModel *theme = [[LCHThemeModel alloc] init];
    theme.name = @"首页";
    [_themes addObject:theme];
    
    return _themes;
}

@end
