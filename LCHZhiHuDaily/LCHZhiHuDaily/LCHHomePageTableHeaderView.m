//
//  LCHHeaderView.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHHomePageTableHeaderView.h"

@interface LCHHomePageTableHeaderView ()

@end

@implementation LCHHomePageTableHeaderView


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = kColor(23, 144, 211, 1);
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.centerX = self.centerX;
}

- (void)setDateString:(NSString *)dateString {
    
    _dateString = dateString;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"MM月dd日 EEEE"];
    NSString *text = [dateFormatter stringFromDate:date];
    
    self.textLabel.attributedText = [[NSAttributedString alloc]
                                     initWithString:text
                                     attributes:
                                     @{NSFontAttributeName:
                                           [UIFont systemFontOfSize:14] ,
                                       NSForegroundColorAttributeName:
                                           [UIColor whiteColor]}];
}

@end
