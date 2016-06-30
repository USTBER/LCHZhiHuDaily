//
//  LCHLaunchViewController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHLaunchViewController.h"
#import "LCHLaunchConfig.h"
#import "LCHLaunchModel.h"

@interface LCHLaunchViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)adjustConstraints;
- (void)updateBackgroundImage;

@end

@implementation LCHLaunchViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.titleLabel];
    
    [self adjustConstraints];
    [self updateBackgroundImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)adjustConstraints {
    
    WeakObject(weakSelf, self);
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.equalTo(weakSelf.view);
    }];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kWidth(kLogoImageWidth));
        make.height.mas_equalTo(kHeight(kLogoImageHeight));
        make.top.mas_equalTo(kHeight(kLogoTopPadding));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.bottom.mas_equalTo(-kHeight(kTitleLabelBottomPadding));
        make.width.mas_greaterThanOrEqualTo(@0.1);
        make.height.mas_greaterThanOrEqualTo(@0.1);
    }];
}

- (void)updateBackgroundImage {
    
    [LCHDataManager getLanchPageResouce:kResourceAPI success:^(NSMutableArray *tem) {
        
        LCHLaunchModel *launchModel = [tem objectAtIndex:0];
        self.titleLabel.text = launchModel.launchTitle;
        [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:launchModel.launchImageURL]];
        
        [self.titleLabel sizeToFit];
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.backgroundImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
        }];
        
    } failed:^(NSError *error) {
        [self.view removeFromSuperview];
//        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}

#pragma mark - lazy loading

- (UIImageView *)backgroundImageView {
    
    if (_backgroundImageView) {
        
        return _backgroundImageView;
    }
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kBackgroundImageName]];
    
    return _backgroundImageView;
}

- (UIImageView *)logoImageView {
    
    if (_logoImageView) {
        
        return _logoImageView;
    }
    _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:KLogoImageName]];
    
    return _logoImageView;
}

- (UILabel *)titleLabel {
    
    if (_titleLabel) {
        
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:kTitleFontSize];
    
    return _titleLabel;
}

@end
