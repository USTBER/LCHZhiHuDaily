//
//  LCHTopImageView.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHTopImageView.h"

@interface LCHTopImageView()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LCHTopImageView

+ (LCHTopImageView *)attachToTableView:(UITableView *)tableView {
    
    LCHTopImageView *topImageView = [[LCHTopImageView alloc] init];
    topImageView.scrollView = tableView;
    topImageView.contentMode = UIViewContentModeScaleAspectFill;
    topImageView.clipsToBounds = YES;
    [topImageView.scrollView addObserver:topImageView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

    return topImageView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    UIScrollView *scrollView = object;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0 && offsetY >= -90) {
        self.y = -45 - 0.5 * offsetY;
        self.height = 100 - offsetY * 0.5;
    }else if(offsetY < -90){
        self.scrollView.contentOffset = CGPointMake(0, -90);
    }else{
        self.y = -45;
        self.height = 100;
    }
}

- (void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffSet"];
}


@end
