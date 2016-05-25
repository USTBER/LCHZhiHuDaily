//
//  ViewController.m
//  自定义CollectionViewCellWidth
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LCHCollectionViewCellDelegate.h"
#import "LCHCollectionModel.h"
#import "LCHCollectionViewCell.h"
#import <Masonry.h>

@interface ViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LCHCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LCHCollectionModel *model;

- (void)configConstrains;

@end

@implementation ViewController

#pragma mark - lifeCicle of viewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.collectionView];
    [self configConstrains];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - overWrite

#pragma mark - private method

- (void)configConstrains {
    
    WeakSelf(weakSelf);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.centerY.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view).multipliedBy(1/10.f);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    return 0;
    return self.model.newsTitles.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s", __func__);
    
    LCHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:frontCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    cell.newsTitle = self.model.newsTitles[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegate

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"%s", __func__);
//    LCHCollectionViewCell *currentCell = (LCHCollectionViewCell *)cell;
//    NSIndexPath *path = [collectionView indexPathForCell:cell];
//    currentCell.newsTitle = self.model.newsTitles[indexPath.row];
//    
//    UICollectionViewCell *thisCell = [collectionView cellForItemAtIndexPath:indexPath];
//
//}


#pragma mark - UICollectionViewDelegateFlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"%s", __func__);
//
//    CGFloat height = collectionView.height;
//    NSNumber *num = self.model.cellWidths[indexPath.row];
//    CGFloat width = [num floatValue];
//    
//    return CGSizeMake(40, 40);
//    return CGSizeMake(width, height);
//    
//}

#pragma mark - LCHCollectionViewCellDelegate

- (void)currentCollectionViewCell:(LCHCollectionViewCell *)cell lableWidthDidChangeTo:(CGFloat)width {
    
    NSLog(@"%s", __func__);
    NSIndexPath *path = [self.collectionView indexPathForCell:cell];
    NSNumber *num = [NSNumber numberWithFloat:width];
    [self.model.cellWidths replaceObjectAtIndex:path.row withObject:num];
//    [self.collectionView reloadInputViews];

}

#pragma mark - lazyLoading

- (UICollectionView *)collectionView {
    
    if (_collectionView) {
        
        return _collectionView;
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.estimatedItemSize = CGSizeMake(100, 50);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor yellowColor];
    [_collectionView registerClass:[LCHCollectionViewCell class] forCellWithReuseIdentifier:frontCollectionViewCellIdentifier];
    
    return _collectionView;
}

- (LCHCollectionModel *)model {
    
    if (_model) {
        
        return _model;
    }
    _model = [LCHCollectionModel defaultModal];
    
    return _model;
}



@end
