//
//  LCHTitleView.m
//  LCHNewsCheck
//
//  Created by apple on 16/5/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHTitleView.h"
#import "LCHCollectionViewCell.h"
#import <Masonry.h>


@interface LCHTitleView ()

@property (nonatomic, strong) UICollectionView *titleContainView;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation LCHTitleView

#pragma mark - overWrite

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 5;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.estimatedItemSize = CGSizeMake(100, 40);
        
        _titleContainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:flowLayout];
        [_titleContainView registerClass:[LCHCollectionViewCell class] forCellWithReuseIdentifier:frontCollectionViewCellIdentifier];
        _titleContainView.backgroundColor = [UIColor yellowColor];
        _titleContainView.pagingEnabled = YES;
        _titleContainView.showsHorizontalScrollIndicator = NO;
        _titleContainView.bounces = NO;
        _titleContainView.allowsMultipleSelection = NO;
        _titleContainView.preservesSuperviewLayoutMargins =NO;
        _titleContainView.layoutMargins = UIEdgeInsetsZero;
        
        [self addSubview:_titleContainView];
        
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor grayColor];
        [self addSubview:_indicatorView];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    WeakSelf(weakSelf);
    [self.titleContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.and.bottom.equalTo(weakSelf);
    }];
    
    
    if ([self.titleViewDelegate respondsToSelector:@selector(titleView:indicatorWidthForIndex:)] && [self.titleViewDelegate respondsToSelector:@selector(titleView:indicatorXForIndex:)]) {
        
        CGFloat width = [self.titleViewDelegate titleView:self indicatorWidthForIndex:self.selectedIndex];
        
        CGFloat x = [self.titleViewDelegate titleView:self indicatorXForIndex:self.selectedIndex];
        
        [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(x);
            make.width.mas_equalTo(width);
            make.bottom.equalTo(weakSelf.indicatorView);
            make.height.mas_equalTo(2);
        }];
    } else {
        
        LCH_LOG_NULL_ERROR;
    }
    
}

#pragma mark - public

- (NSIndexPath *)indexPathForCollectionViewCell:(LCHCollectionViewCell *)cell {
    
    return [self.titleContainView indexPathForCell:cell];
}

- (void)reloadData {
    
    [self.titleContainView reloadData];
}

#pragma mark - private



#pragma mark - lazyLoading getter and setter

- (void)setTitleViewDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate ,LCHTitleViewDelegate>)titleViewDelegate {
    
    if (_titleViewDelegate == titleViewDelegate) {
        
        return;
    }
    _titleContainView.delegate = titleViewDelegate;
    _titleContainView.dataSource = titleViewDelegate;
    _titleViewDelegate = titleViewDelegate;
    
}

@end
