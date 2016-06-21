//
//  ViewController.m
//  AutoSizedTableViewCellDemo
//
//  Created by apple on 16/5/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LCHModel.h"
#import "LCHTableViewCell.h"

@interface ViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *models;

@end

@implementation ViewController


#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.models.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    LCHModel *model = self.models[indexPath.row];
    cell.nameLabel.text = model.name;
    cell.introduceLabel.text = model.introduce;
    [cell layoutSubviews];
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - lazyLoading

- (UITableView *)tableView {
    
    if (_tableView) {
        
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView.frame = CGRectZero;
    _tableView.tableHeaderView.frame = CGRectZero;
    _tableView.estimatedRowHeight = 50.f;
    [_tableView registerClass:[LCHTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    return _tableView;
}

- (NSArray *)models {
    
    if (_models) {
        
        return _models;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Peoples" ofType:@"plist"];
    NSArray *dics = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableArray *tem = [[NSMutableArray alloc] initWithCapacity:dics.count];
    for (NSDictionary *dic in dics) {
        LCHModel *model = [[LCHModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [tem addObject:model];
    }
    _models = [[NSArray alloc] initWithArray:tem];
    
    return _models;
    
}

@end
