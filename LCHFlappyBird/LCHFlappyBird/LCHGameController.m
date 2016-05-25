//
//  LCHGameController.m
//  LCHFlappyBird
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHGameController.h"
#import "LCHGameOverView.h"
#import "LCHFlounPipesLabel.h"
#import "LCHBird.h"

@interface LCHGameController ()
<LCHGameOverDelegate>

@property (nonatomic, strong) UIImageView *birdView;
@property (nonatomic, strong) UIImageView *roadView;
@property (nonatomic, strong) LCHBird *flappyBird;

@property (nonatomic, strong) UIImageView *topPipe;
@property (nonatomic, strong) UIImageView *bottonPipe;

@property (nonatomic, strong) NSTimer *forwardTimer;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@property (nonatomic, strong) LCHFlounPipesLabel *flounPipesLabel;

@property (nonatomic, strong) LCHGameOverView *gameOverView;


- (void)configConstrains;
- (void)createPipe;
- (void)handleForward;
- (void)handleTap:(UITapGestureRecognizer *)tap;
@end

@implementation LCHGameController


#pragma mark - life circle of viewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.birdView];
    [self.view addSubview:self.topPipe];
    [self.view addSubview:self.bottonPipe];
    [self.view addSubview:self.roadView];
    [self.view addSubview:self.flounPipesLabel];
    [self.view addSubview:self.gameOverView];
    [self.view addGestureRecognizer:self.tapGesture];
    [self configConstrains];
    [self createPipe];
    self.forwardTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(handleForward) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [self.forwardTimer invalidate];
    [self.flappyBird removeObserver:self forKeyPath:@"flownPipes" context:nil];
}

#pragma mark - rewrite super method

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"flownPipes"]) {
        NSNumber *flounPipeNumber = [change objectForKey:@"new"];
        self.flounPipesLabel.text = [NSString stringWithFormat:@"%@", flounPipeNumber];
    }
}

#pragma mark - private method

- (void)configConstrains {
    
    WeakSelf(weakSelf);
    
    [self.roadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view).offset(kGameControllerRoadRightOffset);
        make.bottom.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view).multipliedBy(kGameControllerRoadHeightRate);
    }];
    
    [self.topPipe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view).multipliedBy(kGameControllerPipeWidthRate);
    }];
    
    [self.bottonPipe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view).multipliedBy(kGameControllerPipeWidthRate);
    }];
    
}

- (void)createPipe {
    
    CGFloat totalHeight = self.view.height;
    NSNumber *pipeGap = self.gameInfo.pipeGaps[self.gameInfo.gameDegree];
    CGFloat topPipeHeight = totalHeight * 1/10.f + (arc4random() % (int)(totalHeight * 1/2.f));
    CGFloat bottomPipeHeight = totalHeight - pipeGap.floatValue - topPipeHeight;
    
    WeakSelf(weakSelf);
    [self.topPipe mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(topPipeHeight);
        make.left.equalTo(weakSelf.view.mas_right);
    }];
    
    [self.bottonPipe mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bottomPipeHeight);
        make.left.equalTo(weakSelf.view.mas_right);
    }];
}

#pragma mark - target - action

- (void)handleForward {
    
    //move the roadView
    self.roadView.x -= self.flappyBird.birdSpeed;
    if (self.roadView.x < - kGameControllerRoadRightOffset) {
        self.roadView.x = 0;
    }
    
    //move the pipes
    self.topPipe.x -= self.flappyBird.birdSpeed;
    self.bottonPipe.x -= self.flappyBird.birdSpeed;
    
    if (self.topPipe.x < - self.topPipe.width) {
        [self createPipe];
    }
    
    //move the bird
    if (self.flappyBird.isFlying) {
        self.birdView.y -= 3;
    } else {
        self.birdView.y += 1;
    }
    
    //collision detection
    BOOL topPipeDetection = CGRectIntersectsRect(self.birdView.frame, self.topPipe.frame);
    BOOL bottomPipeDetection = CGRectIntersectsRect(self.birdView.frame, self.bottonPipe.frame);
    BOOL roadDetection = CGRectIntersectsRect(self.birdView.frame, self.roadView.frame);
    BOOL superViewDetection = self.birdView.y < 0;
    
    if (topPipeDetection || bottomPipeDetection || roadDetection || superViewDetection) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [LCHSoundTool playPunchSound];
        });
        [self.forwardTimer invalidate];
        self.flappyBird.flying = NO;
        [self.gameInfo updateTopFiveScoreWithScore:[NSNumber numberWithInteger:self.flappyBird.flownPipes]];
        self.gameOverView.hidden = NO;
    }
    if ( fabs(self.topPipe.center.x - self.birdView.center.x) < 0.5) {
        self.flappyBird.flownPipes += 1;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [LCHSoundTool playPipeSound];
        });
        
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    self.flappyBird.flying = YES;
}

#pragma mark - LCHGameOverDelegate
- (void)backToMenuWithGameOverView:(LCHGameOverView *)gameOverView {
    
    [gameOverView removeFromSuperview];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([self.delegate respondsToSelector:@selector(finishController:reloadCurrentScore:)]) {
        
        NSNumber *num = [NSNumber numberWithInteger:self.flappyBird.flownPipes];
        [self.delegate finishController:self reloadCurrentScore:num];
    }
    
}

- (void)restartGameWithGameOverView:(LCHGameOverView *)gameOverView {
    
    [self createPipe];
    self.birdView.frame = self.flappyBird.firstFrame;
    self.flappyBird.flownPipes = 0;
    self.gameOverView.hidden = YES;
    self.forwardTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(handleForward) userInfo:nil repeats:YES];
}

#pragma mark - 6lazy loading getter and setter

- (UIImageView *)birdView {
    
    if (_birdView) {
        
        return _birdView;
    }
    
    _birdView = [[UIImageView alloc] initWithFrame:self.flappyBird.firstFrame];
    _birdView.animationImages = self.flappyBird.birdImages;
    _birdView.animationDuration = 0.5;
    _birdView.animationRepeatCount = 0;
    [_birdView startAnimating];
    
    return _birdView;
}

- (UIImageView *)roadView {
    
    if (_roadView) {
        
        return _roadView;
    }
    _roadView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"road"]];
    
    return _roadView;
}


- (UIImageView *)topPipe {
    
    if (_topPipe) {
        
        return _topPipe;
    }
    _topPipe = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pipe"]];
    
    return _topPipe;
}

- (UIImageView *)bottonPipe {
    
    if (_bottonPipe) {
        
        return _bottonPipe;
    }
    _bottonPipe = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pipe"]];
    
    return _bottonPipe;
}

- (LCHBird *)flappyBird {
    if (_flappyBird) {
        
        return _flappyBird;
    }
    
    _flappyBird = [[LCHBird alloc] init];
    [_flappyBird addObserver:self forKeyPath:@"flownPipes" options:NSKeyValueObservingOptionNew context:nil];
    
    return _flappyBird;
}

- (UITapGestureRecognizer *)tapGesture {
    
    if (_tapGesture) {
        
        return _tapGesture;
    }
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    return _tapGesture;
}

- (LCHFlounPipesLabel *)flounPipesLabel {
    
    if (_flounPipesLabel) {
        
        return _flounPipesLabel;
    }
    _flounPipesLabel = [[LCHFlounPipesLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/3)];
    _flounPipesLabel.center = self.view.center;
    
    return _flounPipesLabel;
}

- (LCHGameOverView *)gameOverView {
    
    if (_gameOverView) {
        
        return _gameOverView;
    }
    _gameOverView = [[LCHGameOverView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/2)];
    _gameOverView.center = self.view.center;
    _gameOverView.centerY -= self.view.height/10;
    _gameOverView.hidden = YES;
    _gameOverView.delegate = self;
    
    return _gameOverView;
}


@end
