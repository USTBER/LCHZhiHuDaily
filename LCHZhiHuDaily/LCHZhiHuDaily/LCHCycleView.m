//
//  LCHCycleView.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCycleView.h"

@interface LCHCycleView ()
<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger totalPageNum;
@property (nonatomic, assign) NSInteger currentPageNum;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *viewsForCycle;
@property (nonatomic, strong) NSTimer *automaticScrollTimer;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UITapGestureRecognizer *tap;
- (void)handleTap:(UITapGestureRecognizer *)tap;

- (void)configSubViews;

- (void)automaticScroll;

- (NSInteger)numberOfViewFromDataSource;
- (UIView *)viewForIndexFromDataSource:(NSInteger)index;

- (void)didSelectViewAtIndex:(NSInteger)index;

- (void)moveToValidePage;

@end

@implementation LCHCycleView

#pragma mark - init method

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _duration = 4.0;
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        
        _pageControl = [[UIPageControl alloc] init];
        
        [self addSubview:_scrollView];
        [self addSubview:_pageControl];
        
        WeakObject(weakSelf, self);
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf);
            make.left.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf).priorityLow();
        }];
        
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-kHeight(5)).priorityLow();
            make.centerX.equalTo(weakSelf);
            make.width.greaterThanOrEqualTo(@0.1);
        }];
        
        [self configSubViews];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            _automaticScrollTimer = [NSTimer timerWithTimeInterval:_duration target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_automaticScrollTimer forMode:NSRunLoopCommonModes];
            [[NSRunLoop currentRunLoop] run];
        });
        
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:_tap];
    }
    
    return self;
}

- (void)dealloc {
    
    [_automaticScrollTimer invalidate];
}

#pragma mark - private method

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(cycleView:didSelectAtIndex:)]) {
        [self.delegate cycleView:self didSelectAtIndex:_currentPageNum];
    }
}

- (void)configSubViews {
    
    _totalPageNum = [self numberOfViewFromDataSource];
    _currentPageNum = 1;
    if (_totalPageNum == 0) {
        _scrollView.contentSize = CGSizeZero;
        
        return;
    }
    
    _viewsForCycle = [[NSMutableArray alloc] initWithCapacity:_totalPageNum + 2];
    for (int i = 0; i < _totalPageNum + 2; i++) {
        
        UIView *view;
        if (i == 0) {
            view = [self viewForIndexFromDataSource:_totalPageNum - 1];
        } else {
            if (i == _totalPageNum + 1) {
                view = [self viewForIndexFromDataSource:0];
            } else {
                view = [self viewForIndexFromDataSource:i - 1];
            }
        }
        
        
        if (!view) {
            view = [[UIView alloc] init];
        }
        [_viewsForCycle insertObject:view atIndex:i];
        
    }
    
    _scrollView.contentSize = CGSizeMake(_scrollView.width * _viewsForCycle.count, _scrollView.height);
    _scrollView.contentOffset = CGPointMake(_scrollView.width, 0);
    [_viewsForCycle enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        [_scrollView addSubview:view];
    }];
    
    _pageControl.numberOfPages = _totalPageNum;
    _pageControl.currentPage = _currentPageNum - 1;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self adjustSubviewsFrame];
}

- (void)adjustSubviewsFrame {
    
    _scrollView.contentSize = CGSizeMake(_scrollView.width * _viewsForCycle.count, _scrollView.height);
    
    _scrollView.height = self.height;
    _pageControl.centerY = self.height - 5 - _pageControl.height / 2;
    [_viewsForCycle enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj;
        view.frame = _scrollView.frame;
        view.x = idx * _scrollView.width;
    }];
}

- (void)automaticScroll {
    
    _currentPageNum ++;
    
    _currentPageNum = _currentPageNum % (_totalPageNum + 2);

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            [_scrollView setContentOffset:CGPointMake(_currentPageNum * _scrollView.width, 0) animated:NO];
        } completion:^(BOOL finished) {
            if (finished) {
                [self moveToValidePage];
                _pageControl.currentPage = _currentPageNum - 1;
            }
        }];
    });
}

- (void)moveToValidePage {
    
    if (_totalPageNum == 0) {
        return;
    }
    if (_currentPageNum <= 0) {
        _currentPageNum =  _viewsForCycle.count - 2;
        [_scrollView setContentOffset:CGPointMake(_currentPageNum * _scrollView.width, 0) animated:NO];
        
        return;
    }
    if (_currentPageNum >= _viewsForCycle.count - 1) {
        _currentPageNum = 1;
        [_scrollView setContentOffset:CGPointMake(_currentPageNum * _scrollView.width, 0) animated:NO];
        
        return;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [_automaticScrollTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [_automaticScrollTimer resumeTimerAfterTimeInterval:_duration];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    _currentPageNum = contentOffsetX / scrollView.width;
    [self moveToValidePage];
    _pageControl.currentPage = _currentPageNum - 1;
}


#pragma mark - public method

- (UIView *)viewForIndex:(NSInteger)index {
    
    return nil;
}

- (void)reloadData {
    
    [_scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    [self configSubViews];
    [self adjustSubviewsFrame];
    
}

#pragma mark - require from datasource

- (NSInteger)numberOfViewFromDataSource {
    
    if ([self.dataSource respondsToSelector:@selector(numberOfViewInCycleView)]) {
        return [self.dataSource numberOfViewInCycleView];
    }
    
    return 0;
}

- (UIView *)viewForIndexFromDataSource:(NSInteger)index {
    
    if ([self.dataSource respondsToSelector:@selector(cycleView:viewForIndex:)]) {
        
        return [self.dataSource cycleView:self viewForIndex:index];
    }
    
    return nil;
}


#pragma mark - delegate method

- (void)didSelectViewAtIndex:(NSInteger)index {
    
    if ([self.delegate respondsToSelector:@selector(cycleView:didSelectAtIndex:)]) {
        [self.delegate cycleView:self didSelectAtIndex:index];
    }
}

#pragma mark - lazy loading

- (void)setDataSource:(id<LCHCycleViewDataSource>)dataSource {
    
    _dataSource = dataSource;
    [self reloadData];
}


@end
