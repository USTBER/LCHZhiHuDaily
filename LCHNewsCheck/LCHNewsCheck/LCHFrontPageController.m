//
//  LCHFrontPageController.m
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//


#import "LCHFrontPageController.h"
#import "LCHTitleView.h"
#import "LCHNewsView.h"
#import "LCHTitleModel.h"
#import "LCHCollectionViewCell.h"
#import <Masonry.h>
#import <NSLayoutConstraint+MASDebugAdditions.h>

@interface LCHFrontPageController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) LCHTitleView *titleView;
@property (nonatomic, strong) LCHNewsView *newsView;
@property (nonatomic, strong) LCHTitleModel *titleModel;

- (void)configConstraints;


@end

@implementation LCHFrontPageController


#pragma mark - lifeCircle of viewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.titleView];
    [self.containerView addSubview:self.newsView];
    self.navigationController.navigationBar.layer.opacity = 0.1;
    [self configConstraints];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"效果示例";
    
    
}

- (void)dealloc {
    
    
}

#pragma mark - overWrite method

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}


#pragma mark - private method

- (void)configConstraints {
    
    WeakSelf(weakSelf);
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.and.equalTo(weakSelf.view);
        make.top.mas_equalTo(CGRectGetMaxY(self.navigationController.navigationBar.frame));
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.containerView);
        make.top.equalTo(weakSelf.containerView);
        make.left.equalTo(weakSelf.containerView);
        make.height.equalTo(weakSelf.containerView).multipliedBy(1/10.f);
    }];
    
    [self.newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleView.mas_bottom);
        make.left.and.width.and.bottom.equalTo(weakSelf.containerView);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return  self.titleModel.newsColumns.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s", __func__);
    
    LCHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:frontCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor randomColor];
    cell.delegate = self;
    cell.newsColumnName = self.titleModel.newsColumns[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 5, 0, 5);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeZero;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"%s", __func__);
//    
//    CGFloat height = self.titleView.height;
//    NSNumber *num = self.titleModel.cellWidths[indexPath.row];
//    CGFloat width = [num floatValue];
////    return CGSizeMake(height, width);
//        return CGSizeMake(50, 50);
//    
//}

#pragma mark - LCHTitleViewDelegate

- (CGFloat)titleView:(LCHTitleView *)titleView indicatorXForIndex:(NSUInteger)index {
    
    return 10 * index;
}

- (CGFloat)titleView:(LCHTitleView *)titleView indicatorWidthForIndex:(NSUInteger)index {
    
    return 10;
}

#pragma mark - LCHCollectionViewCellDelegate

- (void)currentCollectionViewCell:(LCHCollectionViewCell *)cell lableWidthDidChangeTo:(CGFloat)width {
    
    NSIndexPath *indexPath = [self.titleView indexPathForCollectionViewCell:cell];
    [self.titleModel.cellWidths replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:width]];
        [self.titleView reloadData];
    
    NSLog(@"%s", __func__);
    
}

#pragma mark - lazyloading getter and setter

- (UIView *)containerView {
    
    if (_containerView) {
        
        return _containerView;
    }
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor redColor];
    
    return _containerView;
}

- (LCHTitleView *)titleView {
    
    if (_titleView) {
        
        return _titleView;
    }
    _titleView = [[LCHTitleView alloc] init];
    _titleView.titleViewDelegate = self;
    
    return _titleView;
}

- (LCHNewsView *)newsView {
    
    if (_newsView) {
        
        return _newsView;
    }
    _newsView = [[LCHNewsView alloc] init];
    _newsView.backgroundColor = [UIColor greenColor];
    _newsView.layer.opacity = 1;
    
    return _newsView;
}

- (LCHTitleModel *)titleModel {
    
    if (_titleModel) {
        
        return _titleModel;
    }
    _titleModel = [LCHTitleModel defaultTitleModal];
    
    return _titleModel;
}

@end
