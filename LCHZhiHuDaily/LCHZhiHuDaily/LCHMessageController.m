//
//  LCHMessageController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHMessageController.h"
#import "LCHMessageConfig.h"

@interface LCHMessageController ()

@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *noMessageIcon;
@property (nonatomic, strong) UILabel *noMessageLabel;

- (void)handleBack:(UIButton *)sender;
- (void)configConstraints;

@end

@implementation LCHMessageController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.noMessageIcon];
    [self.view addSubview:self.noMessageLabel];
    
    [self configConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    
    WeakObject(weakNoMessageIcon, self.noMessageIcon);
 
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.offset(0);
        make.height.mas_equalTo(kHeight(kMessagePageTopBarHeight));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(kHeight(kMessagePageBackButtonTopPadding));
        make.left.offset(kWidth(kMessagePageBackButtonLeftPadding));
        make.width.mas_equalTo(kWidth(kMessagePageBackButtonWidth));
        make.height.mas_equalTo(kHeight(kMessagePageBackButtonHeight));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(kHeight(kMessagePageTitleLabelTopPadding));
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];

    [self.noMessageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(kHeight(kMessagePageNoMessageIconTopPadding));
        make.width.mas_equalTo(kWidth(kMessagePageNoMessageIconWidth));
        make.height.mas_equalTo(kHeight(kMessagePageNoMessageIconHeight));
    }];
    
    [self.noMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(weakNoMessageIcon.mas_bottom).offset(kHeight(kMessagePageNoMessageLabelTopPadding));
    }];
}

- (void)handleBack:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [_backButton setImage:[UIImage imageNamed:kMessagePageBackButtonImageName] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(handleBack:) forControlEvents:UIControlEventTouchUpInside];
    
    return _backButton;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel) {
        
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:kMessagePageTitleLabelFontSize];
    _titleLabel.text = @"消息";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    return _titleLabel;
}

- (UIImageView *)noMessageIcon {
    
    if (_noMessageIcon) {
        
        return _noMessageIcon;
    }
    _noMessageIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kMessagePageNoMessageIconImageName]];
    _noMessageIcon.layer.opacity = 0.3;
    
    return _noMessageIcon;
}

- (UILabel *)noMessageLabel {
    
    if (_noMessageLabel) {
        
        return _noMessageLabel;
    }
    _noMessageLabel = [[UILabel alloc] init];
    _noMessageLabel.textColor = [UIColor lightGrayColor];
    _noMessageLabel.font = [UIFont systemFontOfSize:kMessagePageNoMessageLabelFontSize];
    _noMessageLabel.text = @"呦，还没有新消息哦~";
    _noMessageLabel.textAlignment = NSTextAlignmentCenter;
    _noMessageLabel.layer.opacity = 0.3;
    
    return _noMessageLabel;
}


@end
