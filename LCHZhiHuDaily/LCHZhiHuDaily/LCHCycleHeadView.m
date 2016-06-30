//
//  LCHCycleHeadView.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCycleHeadView.h"

@interface LCHCycleHeadView ()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation LCHCycleHeadView

+ (id)attachToScrollView:(UIScrollView *)scrollView {
    
    LCHCycleHeadView *cycleHeadView = [[LCHCycleHeadView alloc] init];
    cycleHeadView.scrollView = scrollView;
    [scrollView addObserver:cycleHeadView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    return cycleHeadView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    UIScrollView *scrollView = object;
    CGFloat offSetY = scrollView.contentOffset.y;
    if (offSetY<=0&&offSetY>=-kHeight(90)) {
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(-kHeight(45) - 0.5 * offSetY);
            make.height.mas_equalTo(kHeight(265) - 0.5 * offSetY);
        }];
        
    }else if(offSetY<-kHeight(90)){
        self.scrollView.contentOffset = CGPointMake(0, -kHeight(90));
    }else if(offSetY <= kHeight(500)) {
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(-kHeight(45) - 0.5 * offSetY);
            make.height.mas_equalTo(kHeight(265) - 0.5 * offSetY);
        }];
    }
}

- (void)dealloc {
    
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

@end
