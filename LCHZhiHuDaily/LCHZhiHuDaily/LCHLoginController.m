//
//  LCHLoginController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHLoginController.h"
#import "LCHLoginPageConfig.h"

@interface LCHLoginController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *loginLabel;
@property (nonatomic, strong) UIButton *sinaButton;
@property (nonatomic, strong) UIButton *tencentButton;
@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *expLabel;
@property (nonatomic, strong) UILabel *sinaLabel;
@property (nonatomic, strong) UILabel *tencentLabel;

- (void)configConstraints;
- (void)handleBack:(UIButton *)sender;
- (void)handleSinaLogin:(UIButton *)sender;
- (void)handleTencentLogin:(UIButton *)sender;

@end

@implementation LCHLoginController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.avatarImageView];
    [self.view addSubview:self.loginLabel];
    [self.view addSubview:self.sinaButton];
    [self.view addSubview:self.tencentButton];
    [self.view addSubview:self.expLabel];
    [self.sinaButton addSubview:self.sinaLabel];
    [self.tencentButton addSubview:self.tencentLabel];
    
    [self configConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)dealloc {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    
    WeakObject(weakLoginLabel, self.loginLabel);
    WeakObject(weakSinaButton, self.sinaButton);
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.offset(0);
    }];
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.offset(0);
        make.height.mas_equalTo(kHeight(kLoginPageTopBarHeight));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(kLoginPageBackButtonTopPadding));
        make.left.offset(kWidth(kLoginPageBackButtonLeftPadding));
        make.width.mas_equalTo(kWidth(kLoginPageBackButtonWidth));
        make.height.mas_equalTo(kHeight(kLoginPageBackButtonHeight));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(kHeight(kLoginPageTitleLabelTopPadding));
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(kLoginPageAvatarImageViewTopPadding));
        make.centerX.offset(0);
        make.width.mas_equalTo(kWidth(kLoginPageAvatarImageViewWidth));
        make.height.mas_equalTo(kHeight(kLoginPageAvatarImageViewHeight));
    }];
    
    [self.loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(kHeight(kLoginPageLoginLabelTopPadding));
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [self.sinaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakLoginLabel.mas_bottom).offset(kHeight(kLoginPageSinaButtonTopPadding));
        make.centerX.offset(0);
        make.width.mas_equalTo(kWidth(kLoginPageSinaButtonWidth));
        make.height.mas_equalTo(kHeight(kLoginPageSinaButtonHeight));
    }];
    
    [self.tencentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSinaButton.mas_bottom).offset(kHeight(kLoginPageTencentButtonTopPadding));
        make.centerX.offset(0);
        make.width.mas_equalTo(kWidth(kLoginPageTencentButtonWidth));
        make.height.mas_equalTo(kHeight(kLoginPageTencentButtonHeight));
    }];
    
    [self.sinaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.offset(0);
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [self.tencentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.offset(0);
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [self.expLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.offset(-kHeight(kLoginPageExpLabelBottomPadding));
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
}

- (void)handleBack:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)handleSinaLogin:(UIButton *)sender {
    
    
}

- (void)handleTencentLogin:(UIButton *)sender {
    
    
}
#pragma mark - lazy loading

- (UIImageView *)backgroundImageView {
    
    if (_backgroundImageView) {
        
        return _backgroundImageView;
    }
    _backgroundImageView = [[UIImageView alloc] init];
    [_backgroundImageView setImage:[UIImage imageNamed:kLoginPageBackgroundViewImageName]];
    
    return _backgroundImageView;
}


- (UIView *)topBar {
    
    if (_topBar) {
        
        return _topBar;
    }
    _topBar = [[UIView alloc] init];
    _topBar.backgroundColor = [UIColor whiteColor];
    
    return _topBar;
}


- (UIButton *)backButton {
    
    if (_backButton) {
        
        return _backButton;
    }
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:kLoginPageBackButtonImageName] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    
    return _backButton;
}


- (UILabel *)titleLabel {
    
    if (_titleLabel) {
        
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:kLoginPageTitleLabelFontSize];
    _titleLabel.text = @"登录";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return _titleLabel;
}

- (UIImageView *)avatarImageView {
    
    if (_avatarImageView) {
        
        return _avatarImageView;
    }
    _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kLoginPageAvatarImageViewImageName]];
    
    return _avatarImageView;
}

- (UILabel *)loginLabel {
    
    if (_loginLabel) {
        
        return _loginLabel;
    }
    _loginLabel = [[UILabel alloc] init];
    _loginLabel.textColor = [UIColor whiteColor];
    _loginLabel.font = [UIFont systemFontOfSize:kLoginPageLoginLabelFontSize];
    _loginLabel.textAlignment = NSTextAlignmentCenter;
    _loginLabel.text = @"使用微博登录";
    
    return _loginLabel;
}

- (UIButton *)sinaButton {
    
    if (_sinaButton) {
        
        return _sinaButton;
    }
    _sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sinaButton setImage:[UIImage imageNamed:kLoginPageSinaButtonImageName] forState:UIControlStateNormal];
    [_sinaButton addTarget:self action:@selector(handleSinaLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    return _sinaButton;
}

- (UIButton *)tencentButton {
    
    if (_tencentButton) {
        
        return _tencentButton;
    }
    _tencentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tencentButton setImage:[UIImage imageNamed:kLoginPageTencentImageName] forState:UIControlStateNormal];
    [_tencentButton addTarget:self action:@selector(handleTencentLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    return _tencentButton;
}

- (UILabel *)sinaLabel {
    
    if (_sinaLabel) {
        
        return _sinaLabel;
    }
    _sinaLabel = [[UILabel alloc] init];
    _sinaLabel.textColor = [UIColor blackColor];
    _sinaLabel.font = [UIFont systemFontOfSize:kLoginPageSinaLabelFontSize];
    _sinaLabel.textAlignment = NSTextAlignmentCenter;
    _sinaLabel.text = @"新浪微博";
    
    return _sinaLabel;
}

- (UILabel *)tencentLabel {
    
    if (_tencentLabel) {
        
        return _tencentLabel;
    }
    _tencentLabel = [[UILabel alloc] init];
    _tencentLabel.textColor = [UIColor blackColor];
    _tencentLabel.font = [UIFont systemFontOfSize:kLoginPageTencentLabelFontSize];
    _tencentLabel.textAlignment = NSTextAlignmentCenter;
    _tencentLabel.text = @"腾讯微博";
    
    return _tencentLabel;
}


- (UILabel *)expLabel {
    
    if (_expLabel) {
        
        return _expLabel;
    }
    _expLabel = [[UILabel alloc] init];
    _expLabel.textColor = [UIColor blueColor];
    _expLabel.font = [UIFont systemFontOfSize:kLoginPageExpLabelFontSize];
    _expLabel.textAlignment = NSTextAlignmentCenter;
    _expLabel.text = @"知乎日报不会未经同意通过你的微博账号发布任何信息";
    
    return _expLabel;
}

@end
