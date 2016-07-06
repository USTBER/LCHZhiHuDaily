//
//  LCHRecommendersView.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHRecommendersView.h"
#import <UIButton+WebCache.h>

@interface LCHRecommendersView ()

@property (nonatomic, strong) UILabel *recommenderLabel;
@property (nonatomic, assign) NSInteger recommenderNumber;
@property (nonatomic, strong) NSMutableArray *recommenderAvatars;

@property (nonatomic, strong) UIView *bottomLine;

- (void)setUpRecommenderAvatars;

- (NSInteger)numberOfRecommendersFromDataSource;
- (NSString *)imageURLForIndexFromDataSource:(NSInteger)index;

- (void)handleButtonPressed:(UIButton *)sender;

@end

@implementation LCHRecommendersView

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _recommenderLabel = [[UILabel alloc] init];
        _recommenderLabel.textAlignment = NSTextAlignmentCenter;
        _recommenderLabel.text = @"推荐者";
        _recommenderLabel.textColor = [UIColor blackColor];
        _recommenderLabel.font = [UIFont systemFontOfSize:12];
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
        
        [self addSubview:_recommenderLabel];
        [self addSubview:_bottomLine];
        
        [_recommenderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.height.greaterThanOrEqualTo(@0.1);
            make.width.greaterThanOrEqualTo(@0.1);
            make.left.offset(kWidth(20));
        }];
        
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.offset(0);
            make.bottom.offset(-0.2);
            make.height.mas_equalTo(0.2);
        }];
    }
    
    return self;
}

#pragma mark - private method

- (void)setUpRecommenderAvatars {
    [self.recommenderAvatars enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = obj;
        [button removeFromSuperview];
    }];
    
    self.recommenderNumber = [self numberOfRecommendersFromDataSource];
    
    WeakObject(weakLabel, _recommenderLabel);
    
    for (int i = 0; i < self.recommenderNumber; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *imageURL = [self imageURLForIndexFromDataSource:i];
        [button sd_setImageWithURL:[NSURL URLWithString:imageURL] forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 15;
        [button addTarget:self action:@selector(handleButtonPressed:) forControlEvents:UIControlEventTouchDragInside];
        
        [self addSubview:button];
        [self.recommenderAvatars insertObject:button atIndex:i];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kWidth(30));
            make.height.mas_equalTo(kWidth(30));
            make.centerY.offset(0);
            make.left.equalTo(weakLabel.mas_right).offset(kWidth(20 + i * 50));
        }];
    }
}

#pragma mark - public method

- (void)reloadData {
    [self setUpRecommenderAvatars];
}

#pragma mark - data from dataSource

- (NSInteger)numberOfRecommendersFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(numberOfRecommenders:)]) {
        
        return [self.dataSource numberOfRecommenders:self];
    }
    return 0;
}

- (NSString *)imageURLForIndexFromDataSource:(NSInteger)index {
    
    if ([self.dataSource respondsToSelector:@selector(recommenderView:didSelectRecommenderAtIndex:)]) {
        
        return [self.dataSource recommenderView:self imageURLForIndex:index];
    }
    
    return nil;
}

#pragma mark - target action

- (void)handleButtonPressed:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(recommenderView:didSelectRecommenderAtIndex:)]) {
        [self.delegate recommenderView:self didSelectRecommenderAtIndex:0];
    }
}

#pragma mark - lazy loading

- (void)setDataSource:(id<LCHRecommendersViewDataSource>)dataSource {
    
    _dataSource = dataSource;
    [self setUpRecommenderAvatars];
}

- (NSMutableArray *)recommenderAvatars {
    
    if (_recommenderAvatars) {
        
        return _recommenderAvatars;
    }
    _recommenderAvatars = [[NSMutableArray alloc] init];
    
    return _recommenderAvatars;
}

@end
