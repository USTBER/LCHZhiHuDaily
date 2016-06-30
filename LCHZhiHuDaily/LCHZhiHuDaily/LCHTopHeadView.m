//
//  LCHTopHeadView.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHTopHeadView.h"

@interface LCHTopHeadView ()

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation LCHTopHeadView

#pragma mark -  life cycle

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.numberOfLines = 0;
        
        _sourceLabel = [[UILabel alloc] init];
        _sourceLabel.textColor = [UIColor whiteColor];
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
        _sourceLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_imageView];
        [self addSubview:_titleLabel];
        [self addSubview:_sourceLabel];
        
        WeakObject(weakSelf, self);
        WeakObject(weakSourceLabel, _sourceLabel);
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.width.and.height.equalTo(weakSelf);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf).offset(kWidth(15));
            make.bottom.equalTo(weakSourceLabel.mas_top);
            make.width.greaterThanOrEqualTo(@0.1);
            make.right.equalTo(weakSelf).offset(-kWidth(15));
        }];
        
        [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf).offset(-kWidth(15));
            make.bottom.equalTo(weakSelf).offset(-kWidth(8));
            make.height.mas_equalTo(kHeight(21));
            make.width.greaterThanOrEqualTo(@0.1);
        }];
    }
    
    return self;
}

- (void)dealloc {
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

#pragma mark - public method

+ (id)attachToScrollView:(UIWebView *)webView {
    
    LCHTopHeadView *topHeadView = [[LCHTopHeadView alloc] init];
    topHeadView.webView = webView;
    [webView.scrollView addObserver:topHeadView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    return topHeadView;
}

- (void)observeWebView:(UIWebView *)webView {
    
    self.webView = webView;
    [webView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

+ (id)addToView:(UIView *)view attachToScrollView:(UIWebView *)webView {
    
    LCHTopHeadView *topHeadView = [[LCHTopHeadView alloc] init];
    topHeadView.webView = webView;
    [view addSubview:topHeadView];
    [webView.scrollView addObserver:topHeadView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    return topHeadView;
}

#pragma mark - private method

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    
    UIScrollView *scrollView = object;
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY<=0&&offSetY>=-kHeight(90)) {
        
        self.frame = CGRectMake(0, -kHeight(45) - 0.5 * offSetY, kScreenWidth, kHeight(265) - 0.5 * offSetY);
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.mas_equalTo(-kHeight(45) - 0.5 * offSetY);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(kHeight(265) - 0.5 * offSetY);
        }];
        
    }else if(offSetY<-kHeight(90)){
        self.webView.scrollView.contentOffset = CGPointMake(0, -kHeight(90));
    }else if(offSetY <= kHeight(500)) {
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.mas_equalTo(-kHeight(45) - 0.5 * offSetY);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(kHeight(265) - 0.5 * offSetY);
        }];
        
        if (offSetY <= kHeight(220)) {
            
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }else {
            
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

@end
