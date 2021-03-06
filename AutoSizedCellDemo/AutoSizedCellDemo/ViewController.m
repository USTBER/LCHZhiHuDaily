//
//  ViewController.m
//  AutoSizedCellDemo
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LCHCollectionViewCell.h"
#import "LCHModel.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *models;
@end

@implementation ViewController


#pragma mark - lifeCircle

- (instancetype)init
{
    if (self = [super init]) {
    
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.models.count;
}

//collectionView 代理
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LCHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    LCHModel *model = self.models[indexPath.row];
    cell.firstLabel.text = model.firstString;
    cell.secondLabel.text = model.secondString;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LCHCollectionViewCell *cell = [[LCHCollectionViewCell alloc] init];
    LCHModel *model = self.models[indexPath.row];
    cell.firstLabel.text = model.firstString;
    cell.secondLabel.text = model.secondString;
    [cell layoutIfNeeded];
    CGRect frame = cell.frame;
    return frame.size;
}

#pragma mark - lazyLoading

- (UICollectionView *)collectionView {
    
    if (_collectionView) {
        
        return _collectionView;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.estimatedItemSize = CGSizeMake(100, 50);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.center.y, self.view.frame.size.width, self.view.frame.size.height/15) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor yellowColor];
    [_collectionView registerClass:[LCHCollectionViewCell class] forCellWithReuseIdentifier:@"reuse"];
    
    return _collectionView;
}

- (NSArray *)models {
    
    if (_models) {
        
        return _models;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Model" ofType:@"plist"];
    NSArray *dics = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableArray *tem = [[NSMutableArray alloc] initWithCapacity:dics.count];
    for (NSDictionary *dic in dics) {
        LCHModel *model = [[LCHModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [tem addObject:model];
    }
    _models = [[NSArray alloc] initWithArray:tem copyItems:NO];
    
    return _models;
}

@end
