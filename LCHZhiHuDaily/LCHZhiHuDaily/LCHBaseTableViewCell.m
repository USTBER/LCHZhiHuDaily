//
//  LCHBaseTableViewCell.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHBaseTableViewCell.h"

@interface LCHBaseTableViewCell ()


@end

@implementation LCHBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configSubviews];
        [self configConstraints];
    }
    
    return self;
}

- (void)configSubviews {
    
}

- (void)configConstraints {
    
    
}

@end
