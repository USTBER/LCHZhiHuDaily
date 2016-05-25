//
//  ViewController.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LCHScoreMenu.h"
#import "Common.h"
#import "LCHGameController.h"
#import "LCHRankController.h"
#import "LCHRateController.h"

@interface ViewController ()
<LCHFinishControllerDelegate, LCHBackToMenuDelegate>

@property (nonatomic, strong) UIImageView *titleView;

@property (nonatomic, strong) UIImageView *birdView;

@property (nonatomic, strong) LCHScoreMenu *scoreMenu;

@property (nonatomic, strong) UIButton *rateButton;

@property (nonatomic, strong) UIButton *gameButton;

@property (nonatomic, strong) UIButton *rankButton;

- (void)configConstrains;

- (void)handleRateButton:(UIButton *)sender;
- (void)handleGameButton:(UIButton *)sender;
- (void)handleRankButton:(UIButton *)rankButton;

@end

@implementation ViewController

#pragma life circle of viewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.birdView];
    [self.view addSubview:self.scoreMenu];
    [self.view addSubview:self.rateButton];
    [self.view addSubview:self.gameButton];
        [self.view addSubview:self.rankButton];
    [self configConstrains];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSNumber *num = [[LCHGameInfo sharedGameInfo] topFiveScore][0];    
    [self.scoreMenu showBestScore:num];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    WeakSelf(weakSelf);
    [self.gameButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(-weakSelf.gameButton.width);
    }];
    
    [self.rankButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(weakSelf.rankButton.width);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma privateMethod

- (void)configConstrains {
    
    WeakSelf(weakSelf);
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.view).offset(kTopPadding);
        make.width.mas_equalTo(weakSelf.view).multipliedBy(1/kTitleViewWidthRate);
        make.height.mas_equalTo(weakSelf.view).multipliedBy(1/kTitleViewHeightRate);
    }];
    
    [self.birdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.titleView.mas_bottom).offset(kPadding);
        make.width.mas_equalTo(weakSelf.view).multipliedBy(1/kBirdWidthRate);
        make.height.mas_equalTo(weakSelf.birdView.mas_width).priorityLow();
    }];
    
    [self.scoreMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.birdView.mas_bottom).offset(kPadding);
        make.width.mas_equalTo(weakSelf.view).multipliedBy(1/kScoreMenuWidthRate);
        make.height.mas_equalTo(weakSelf.view).multipliedBy(1/kScoreMenuHeightRate);
    }];
    
    [self.rateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.scoreMenu.mas_bottom).offset(kPadding);
        make.width.mas_equalTo(weakSelf.view).multipliedBy(1/kRateButtonWidthRate);
        make.height.mas_equalTo(weakSelf.view).multipliedBy(1/kRateButtonHeightRate);
    }];
    
    [self.gameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.rateButton.mas_bottom).offset(kPadding);
        make.width.mas_equalTo(weakSelf.view).multipliedBy(1/kGameButtonWidthRate);
        make.height.mas_equalTo(weakSelf.view).multipliedBy(1/kGameButtonHeightRate);
    }];
    
    [self.rankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.rateButton.mas_bottom).offset(kPadding);
        make.width.mas_equalTo(weakSelf.view).multipliedBy(1/kRankButtonWidthRate);
        make.height.mas_equalTo(weakSelf.view).multipliedBy(1/kRankButtonHeightRate);
        
    }];
    
}

#pragma LCHFinishControllerDelegate

- (void)finishCurrentController:(LCHBaseController *)controller {
    
    [controller dismissViewControllerAnimated:YES completion:^ {
        
        
    }];
}

#pragma LCHBackToMenuDelegate

- (void)finishController:(LCHGameController *)gameController reloadCurrentScore:(NSNumber *)currentScore {
    
    [gameController dismissViewControllerAnimated:YES completion:nil];
    [self.scoreMenu showCurrentScore:currentScore];
}

#pragma target-action

- (void)handleRateButton:(UIButton *)sender {
    
    LCHRateController *rateController = [[LCHRateController alloc] init];
    rateController.delegate = self;
    [self presentViewController:rateController animated:YES completion:nil];
}

- (void)handleGameButton:(UIButton *)sender {
    
    LCHGameController *gameController = [[LCHGameController alloc] init];
    gameController.delegate = self;
    [self presentViewController:gameController animated:YES completion:nil];
}

- (void)handleRankButton:(UIButton *)rankButton {
    
    LCHRankController *rankController = [[LCHRankController alloc] init];
    rankController.delegate = self;
    [self presentViewController:rankController animated:YES completion:nil];
}


#pragma lazy loading

- (UIImageView *)titleView {
    
    if (_titleView) {
        
        return _titleView;
    }
    
    _titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main"]];
    return _titleView;
}

- (UIImageView *)birdView {
    
    if (_birdView) {
        
        return _birdView;
    }
    
    _birdView = [[UIImageView alloc] init];
    NSMutableArray *birds = [[NSMutableArray alloc] initWithCapacity:3];
    for (int i = 1; i <= 3; i ++) {
        NSString *imageName = [NSString stringWithFormat:@"bird%zi", i];
        UIImage *bird = [UIImage imageNamed:imageName];
        [birds addObject:bird];
    }
    _birdView.animationImages = birds;
    _birdView.animationDuration = 1;
    _birdView.animationRepeatCount = 0;
    [_birdView startAnimating];
    
    return _birdView;
}

- (LCHScoreMenu *)scoreMenu {
    
    if (_scoreMenu) {
        
        return _scoreMenu;
    }
    _scoreMenu = [[LCHScoreMenu alloc] init];
    return _scoreMenu;
}

- (UIButton *)rateButton {
    
    if (_rateButton) {
        
        return _rateButton;
    }
    _rateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rateButton addTarget:self action:@selector(handleRateButton:) forControlEvents:UIControlEventTouchUpInside];
    [_rateButton setImage:[UIImage imageNamed:@"rate"] forState:UIControlStateNormal];
    return _rateButton;
}

- (UIButton *)rankButton {
    
    if (_rankButton) {
        
        return _rankButton;
    }
    _rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rankButton addTarget:self action:@selector(handleRankButton:) forControlEvents:UIControlEventTouchUpInside];
    [_rankButton setImage:[UIImage imageNamed:@"rank"] forState:UIControlStateNormal];
    return _rankButton;
}

- (UIButton *)gameButton {
    
    if (_gameButton) {
        
        return _gameButton;
    }
    _gameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_gameButton addTarget:self action:@selector(handleGameButton:) forControlEvents:UIControlEventTouchUpInside];
    [_gameButton setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    return _gameButton;
}

@end
