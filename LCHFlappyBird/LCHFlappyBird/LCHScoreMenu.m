//
//  LCHScoreMenu.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHScoreMenu.h"
#import "Common.h"
#import <Masonry.h>

@interface LCHScoreMenu ()

@property (nonatomic, strong) UIImageView *scoreMenuImageView;

@property (nonatomic, strong) UILabel *currentScoreLabel;

@property (nonatomic, strong) UILabel *bestScoreLabel;

@end

@implementation LCHScoreMenu

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _scoreMenuImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"score"]];
        [self addSubview:_scoreMenuImageView];
        
        
        _currentScoreLabel = [[UILabel alloc] init];
        _currentScoreLabel.textAlignment = NSTextAlignmentCenter;
        _currentScoreLabel.font = [UIFont fontWithName:@"Marker Felt" size:16];
        _currentScoreLabel.textColor = [UIColor orangeColor];
        _currentScoreLabel.text = @"0";
        _currentScoreLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_currentScoreLabel];
        
        _bestScoreLabel = [[UILabel alloc] init];
        _bestScoreLabel.textAlignment = NSTextAlignmentCenter;
        _bestScoreLabel.font = [UIFont fontWithName:@"Marker Felt" size:16];
        _bestScoreLabel.textColor = [UIColor orangeColor];
        _bestScoreLabel.backgroundColor = [UIColor clearColor];
        _bestScoreLabel.text= @"0";
        [self addSubview:_bestScoreLabel];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (void)showBestScore:(NSNumber *)score {
    
    self.bestScoreLabel.text = [NSString stringWithFormat:@"%@", score];
}

- (void)showCurrentScore:(NSNumber *)score {
    
    self.currentScoreLabel.text = [NSString stringWithFormat:@"%@", score];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    WeakSelf(weakSelf);
    [self.scoreMenuImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf);
        make.height.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf);
    }];
    
    [self.currentScoreLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weakSelf).multipliedBy(1/8.f);
        make.width.equalTo(weakSelf).multipliedBy(1/5.f);
        make.left.mas_equalTo(weakSelf.width * 5/7.f).priorityHigh();
        make.top.mas_equalTo(weakSelf.height * 8/27.f).priorityHigh();
    }];
    
    [self.bestScoreLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(weakSelf).multipliedBy(1/8.f);
        make.width.equalTo(weakSelf).multipliedBy(1/5.f);
        make.left.mas_equalTo(weakSelf.width * 5/7.f).priorityLow();
        make.top.mas_equalTo(weakSelf.height * 2/3.f).priorityLow();
    }];
    
    
}

@end
