//
//  LCHCircleView.m
//  DoubleDirCircleScrollView
//
//  Created by apple on 16/5/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCircleView.h"
#import "LCHCircleCell.h"
#import "LCHPageControl.h"

@interface LCHCircleView ()
<UIScrollViewDelegate>

@property (nonatomic, assign) LCHCircleViewType circleType;
@property (nonatomic, assign) LCHCircieViewScrollDirection scrollDirection;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentCellIndex;
@property (nonatomic, assign) NSTimer *autoScrollTimer;
@property (nonatomic, strong) LCHPageControl *pageControl;

@property (nonatomic, strong) UITapGestureRecognizer *testTap;

- (NSUInteger)numberOfView;
- (LCHCircleCell *)cellForIndex:(NSUInteger)index;

- (void)setUpUI;
- (void)scrollToIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)handleScrollTimer;

- (void)handleTestTap:(UITapGestureRecognizer *)tap;

@end

static const CGFloat onceScrollTime = 2;

@implementation LCHCircleView

#pragma mark - initMethod

- (id)initWithType:(LCHCircleViewType)type frame:(CGRect)frame {
    
    return [self initWithType:type scrollDirection:LCHCircleViewScrollDirectionHorizon frame:frame];
}

- (id)initWithScrollDirection:(LCHCircieViewScrollDirection)scrollDirection frame:(CGRect)frame {
    
    return [self initWithType:LCHCircleViewTypeNotAutomatic scrollDirection:scrollDirection frame:frame];
    
}

- (id)initWithType:(LCHCircleViewType)type scrollDirection:(LCHCircieViewScrollDirection)scrollDirection {
    
    return [self initWithType:type scrollDirection:scrollDirection frame:CGRectZero];
}

- (id)initWithType:(LCHCircleViewType)type {
    
    return [self initWithType:type scrollDirection:LCHCircleViewScrollDirectionHorizon frame:CGRectZero];
}

- (id)initWithScrollDirection:(LCHCircieViewScrollDirection)scrollDirection {
    
    return [self initWithType:LCHCircleViewTypeNotAutomatic scrollDirection:scrollDirection frame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    
    return [self initWithType:LCHCircleViewTypeNotAutomatic scrollDirection:LCHCircleViewScrollDirectionHorizon frame:frame];
}

- (id)initWithType:(LCHCircleViewType)type scrollDirection:(LCHCircieViewScrollDirection)scrollDirection frame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _circleType = type;
        _scrollDirection = scrollDirection;
        _currentCellIndex = 1;
        _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:onceScrollTime target:self selector:@selector(handleScrollTimer) userInfo:nil repeats:NO];
    }
    [self setUpUI];
    
    return self;
}

#pragma mark - overWrite

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    CGFloat width = self.scrollView.width;
    CGFloat height = self.scrollView.height;
    CGPoint contentOffset = self.scrollView.contentOffset;
    NSUInteger num = [self numberOfView];
    if (num == 0) {
        
        return;
    }
    
    if (self.scrollDirection == LCHCircleViewScrollDirectionHorizon) {
        contentOffset.x = width * (self.currentCellIndex);
        width *= (num + 2);
        
    } else if (self.scrollDirection == LCHCircleViewScrollDirectionVertical) {
        contentOffset.y = height * (self.currentCellIndex);
        height *= (num + 2);
        
    }
    self.scrollView.contentSize = CGSizeMake(width, height);
    self.scrollView.contentOffset = contentOffset;
    
    CGFloat pageControlWidth = self.width/2;
    CGFloat pageControlHeight = self.height/20;
    self.pageControl.frame = CGRectMake((self.width - pageControlWidth) / 2, (self.height - pageControlHeight) / (1.1), pageControlWidth, pageControlHeight);
    
}

- (void)dealloc {
    
    [self.autoScrollTimer invalidate];
    
}

#pragma mark - private method

- (void)setUpUI {
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    _scrollView.delegate = self;
    
    _testTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTestTap:)];
    [self addGestureRecognizer:_testTap];
    
    _pageControl = [[LCHPageControl alloc] init];
    _pageControl.hidesForSinglePage = NO;
    _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:_pageControl];
}

- (void)scrollToIndex:(NSUInteger)index animated:(BOOL)animated{
    
    if (self.scrollDirection == LCHCircleViewScrollDirectionHorizon) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.width * index, 0) animated:animated];
    } else if (self.scrollDirection == LCHCircleViewScrollDirectionVertical) {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.height * index) animated:animated];
    }
}

- (void)reloadData {
    
    [self layoutIfNeeded];
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    NSUInteger num = [self numberOfView];
    if (num == 0) {
        
        return;
    }
    self.pageControl.numberOfPages = num;
    self.pageControl.currentPage = self.currentCellIndex - 1;
    
    for (NSUInteger i = 0; i < num; i++) {
        
        LCHCircleCell *cell = [self cellForIndex:i];
        [self.scrollView addSubview:cell];
    }
    
    LCHCircleCell *firstCell = [self cellForIndex:num - 1];
    LCHCircleCell *lastCell = [self cellForIndex:0];
    if (self.scrollDirection == LCHCircleViewScrollDirectionHorizon) {
        firstCell.x = 0;
        lastCell.x = lastCell.width * (num + 1);
    } else if (self.scrollDirection == LCHCircleViewScrollDirectionVertical) {
        firstCell.y = 0;
        lastCell.y = lastCell.height * (num + 1);
    }
    
    [self.scrollView addSubview:firstCell];
    [self.scrollView addSubview:lastCell];
}

- (NSUInteger)numberOfView {
    
    if (![self.dataSource respondsToSelector:@selector(numberOfCircleCellInCircleView:)]) {
        _currentCellIndex = -1;
        
        return 0;
    }
    NSUInteger num = [self.dataSource numberOfCircleCellInCircleView:self];
    if (num == 0){
        _currentCellIndex = -1;
    }
    
    return num;
};


- (LCHCircleCell *)cellForIndex:(NSUInteger)index {
    
    if (![self.dataSource respondsToSelector:@selector(circleView:cellIndex:)]) {
        self.currentCellIndex = -1;
        
        return nil;
    }
    
    LCHCircleCell *cell = [self.dataSource circleView:self cellIndex:index];
    cell.width = self.scrollView.width;
    cell.height = self.scrollView.height;
    
    if (self.scrollDirection == LCHCircleViewScrollDirectionHorizon) {
        cell.x = cell.width * (index + 1);
        cell.y = 0;
    } else if (self.scrollDirection == LCHCircleViewScrollDirectionVertical) {
        cell.x = 0;
        cell.y = cell.height * (index + 1);
    }
    
    return cell;
    
}

#pragma mark - handleMethod

- (void)handleScrollTimer {
    
    if ([self numberOfView] == 0) {
        
        return;
    }
    
    switch (self.circleType) {
        case LCHCircleViewTypeNotAutomatic:
            
            break;
            
        case LCHCircleViewTypeaForwardAutomatic:
            //            [self scrollToIndex:self.currentCellIndex++ animated:YES];
            self.currentCellIndex++;
            break;
            
        case LCHCircleViewTypeBackwardAutomatic:
            //            [self scrollToIndex:self.currentCellIndex-- animated:YES];
            self.currentCellIndex--;
            break;
    }
}

- (void)handleTestTap:(UITapGestureRecognizer *)tap {
    
    NSLog(@"currentCellIndex is %ld", (long)self.currentCellIndex);
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    if (index == 0 || index == [self numberOfView] + 1) {
        self.currentCellIndex = index;
    } else {
        _currentCellIndex = index;
        self.pageControl.currentPage = index - 1;
    }
    
    [self.autoScrollTimer setFireDate:[NSDate dateWithTimeInterval:onceScrollTime sinceDate:[NSDate date]]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.autoScrollTimer setFireDate:[NSDate distantFuture]];
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    //    [self.autoScrollTimer setFireDate:[NSDate date]];
    //    [_autoScrollTimer invalidate];
    
}

#pragma mark - lazyLoading

- (void)setDataSource:(id<LCHCircleViewDataSource>)dataSource {
    
    if (_dataSource == dataSource) {
        
        return;
    }
    _dataSource = dataSource;
    [self reloadData];
}

- (void)setCurrentCellIndex:(NSInteger)currentCellIndex {
    
    if (_currentCellIndex == currentCellIndex) {
        
        return;
    }
    if ([self numberOfView] == 0) {
        
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self scrollToIndex:currentCellIndex animated:NO];
    } completion:^(BOOL finished) {
        
        if (currentCellIndex == 0) {
            _currentCellIndex = [self numberOfView];
            [self scrollToIndex:[self numberOfView] animated:NO];
            self.pageControl.currentPage = _currentCellIndex - 1;
            
            return;
        }
        if (currentCellIndex == ([self numberOfView] + 1)) {
            _currentCellIndex = 1;
            [self scrollToIndex:1 animated:NO];
            self.pageControl.currentPage = _currentCellIndex - 1;
            
            return;
        }
        
    }];
    
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:onceScrollTime target:self selector:@selector(handleScrollTimer) userInfo:nil repeats:NO];
    
    _currentCellIndex = currentCellIndex;
    self.pageControl.currentPage = _currentCellIndex - 1;
    
}

@end
