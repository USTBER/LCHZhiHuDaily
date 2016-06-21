//
//  LCHTableViewCell.m
//  AutoSizedTableViewCellDemo
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHTableViewCell.h"
#import <Masonry.h>

@implementation LCHTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:20];
        _nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel.numberOfLines = 0;
        
        _introduceLabel = [[UILabel alloc] init];
        _introduceLabel.textAlignment = NSTextAlignmentCenter;
        _introduceLabel.font = [UIFont systemFontOfSize:20];
        _introduceLabel.backgroundColor = [UIColor yellowColor];
        _introduceLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_introduceLabel];
        
        self.contentView.backgroundColor = [UIColor greenColor];
    }
    
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    __weak typeof(_introduceLabel) weakNameLabel = _nameLabel;
    
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.top.equalTo(weakSelf.contentView).offset(10);
        make.width.greaterThanOrEqualTo(@0.1);
        make.width.lessThanOrEqualTo(@200);
        make.height.greaterThanOrEqualTo(@0.1);
    }];
    
    [_introduceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.contentView);
        make.top.mas_equalTo(weakNameLabel.mas_bottom).offset(10);
        make.width.greaterThanOrEqualTo(@0.1);
        make.height.greaterThanOrEqualTo(@0.1);
        make.width.lessThanOrEqualTo(@300);
        make.bottom.equalTo(weakSelf.contentView).offset(-10).priorityLow();
    }];
}

@end
