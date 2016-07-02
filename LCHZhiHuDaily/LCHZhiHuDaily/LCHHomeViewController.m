//
//  LCHHomeViewController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHHomeViewController.h"
#import "LCHHomePageTopNewsModel.h"
#import "LCHHomePageNewsModel.h"
#import "LCHHomePageCell.h"
#import "LCHHomePageConfig.h"
#import "CircleRefreshView.h"
#import "LCHCycleHeadView.h"
#import "LCHTopHeadView.h"
#import "LCHHomePageTableHeaderView.h"
#import "LCHHomePageBeforeJsonModel.h"
#import "LCHDetailNewsViewController.h"
#import "LCHContainerController.h"
#import "LCHThemeContainController.h"
#import "LCHThemeDetailNewsController.h"
#import "LCHThemeNewsTool.h"

@interface LCHHomeViewController ()
<UITableViewDataSource, UITableViewDelegate, LCHCycleViewDataSource, LCHCycleViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//里面装了装有LCHHomePageLatestJsonModel的NSMutableArray
@property (nonatomic, strong) NSMutableArray *allHomePageNewsModels;
@property (nonatomic, strong) NSMutableArray *topNews;
@property (nonatomic, strong) CircleRefreshView *refreshView;
@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) LCHCycleHeadView *cycleHeadView;
@property (nonatomic, strong) UIView *navigationBar;
@property (nonatomic, strong) LCHThemeNewsTool *tool;
@property (nonatomic, strong) NSMutableArray *newsIDs;

- (void)configConstraints;
- (void)getHomePageData;
- (void)updateHomePageDataWithDate:(NSString *)date;

- (void)handleRefresh;
- (void)handleMenu:(UIButton *)sender;

@end

@implementation LCHHomeViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.cycleHeadView];
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.menuButton];
    [self.view addSubview:self.refreshView];
    [self.view insertSubview:self.tableView belowSubview:self.cycleHeadView];
    
    [self configConstraints];
    [self getHomePageData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    
    WeakObject(weakView, self.view);
    WeakObject(weakTitleLabel, self.titleLabel);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakView).offset(kHeight(kHomePageTableViewTopPadding));
        make.left.equalTo(weakView);
        make.bottom.equalTo(weakView);
        make.width.equalTo(weakView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakView);
        make.top.mas_equalTo(kHeight(kHomePageTitleLabelTopPadding));
        make.height.mas_equalTo(kHeight(kHomePageTitleLabelHeight));
        make.width.greaterThanOrEqualTo(@0.1);
    }];
    
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakView).offset(kHeight(KHomePageMenuButtonTopPadding));
        make.left.equalTo(weakView).offset(kWidth(KHomePageMenuButtonLeftPadding));
        make.width.mas_equalTo(kWidth(kHomePageMenuButtonWidth));
        make.height.mas_equalTo(kHeight(KHomePageMenuButtonHeight));
    }];
    
    [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakTitleLabel).priorityLow();
        make.right.equalTo(weakTitleLabel.mas_left).offset(-kWidth(kHomePageRefreshRightPadding));
        make.width.mas_equalTo(kWidth(kHomePageRefreshWidth));
        make.height.mas_equalTo(kHeight(kHomePageRefreshHeight));
    }];
    
    [self.cycleHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakView).offset(-kHeight(kHomePageHeadViewTopPadding));
        make.left.equalTo(weakView);
        make.right.equalTo(weakView);
        make.height.mas_equalTo(kHeight(kHomePageHeadViewHeight));
    }];
    
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakView);
        make.left.equalTo(weakView);
        make.right.equalTo(weakView);
        make.height.mas_equalTo(kHeight(kHomePageNavigationBarDefaultHeight));
    }];
}

- (void)getHomePageData {
    
    [LCHDataManager getHomePageLatestNews:kHomePageLatestNewsAPI success:^(NSMutableArray *models) {
        
        [self.allHomePageNewsModels addObject:models[0]];
        [self.topNews addObjectsFromArray:models[1]];
        [self.tableView reloadData];
        [self.cycleHeadView reloadData];
        
        /**
         *  更新newsIDs的内容，用于前后新闻跳转
         */
        @autoreleasepool {
            LCHHomePageBeforeJsonModel *beforeJsonModel = models[0];
            [beforeJsonModel.stories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LCHHomePageNewsModel *newsModel = obj;
                NSString *newsID = [NSString stringWithFormat:@"%ld", (long)newsModel.newsID];
                [self.newsIDs insertObject:newsID atIndex:idx];
            }];
        }
    } failed:^(NSError *err) {
        NSLog(@"%@", err.domain);
    }];
}

- (void)updateHomePageDataWithDate:(NSString *)date {
    
    LCHHomePageBeforeJsonModel *oldestNewsJsonModel = [self.allHomePageNewsModels lastObject];
    
    if (![date isEqualToString:oldestNewsJsonModel.date]) {
        
        return;
    }
    
    [LCHDataManager getHomePageBeforeNews:[KHomePageBeforeNewsAPI stringByAppendingString:date] success:^(id returnModel) {
        
        LCHHomePageBeforeJsonModel *beforeNewsJsonModel = returnModel;
        [self.allHomePageNewsModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LCHHomePageBeforeJsonModel *downloadedJsonModel = obj;
            if ([downloadedJsonModel.date isEqualToString:beforeNewsJsonModel.date]) {
                
                return ;
            }
        }];
        [self.allHomePageNewsModels addObject:beforeNewsJsonModel];
        [self.tableView reloadData];
        
        /**
         *  更新newsIDs的内容，用于前后新闻跳转
         */
        @autoreleasepool {
            NSInteger newsCount = self.newsIDs.count;
            [beforeNewsJsonModel.stories enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LCHHomePageNewsModel *newsModel = obj;
                NSString *newsID = [NSString stringWithFormat:@"%ld", (long)newsModel.newsID];
                [self.newsIDs insertObject:newsID atIndex:idx + newsCount];
            }];
        }
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.allHomePageNewsModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    LCHHomePageBeforeJsonModel *newsJsonModel = self.allHomePageNewsModels[section];
    
    return newsJsonModel.stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCHHomePageCell *homePageCell = [tableView dequeueReusableCellWithIdentifier:kHomePageCellIdenfitier forIndexPath:indexPath];
    LCHHomePageBeforeJsonModel *newsJsonModel = self.allHomePageNewsModels[indexPath.section];
    
    LCHHomePageNewsModel *newsModel = newsJsonModel.stories[indexPath.row];
    if (newsModel) {
        homePageCell.newsLabel.text = newsModel.title;
        [homePageCell.newsImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.images[0]]];
    }
    
    return homePageCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCHHomePageBeforeJsonModel *newsJsonModel = self.allHomePageNewsModels[indexPath.section];
    LCHHomePageNewsModel *newsModel = newsJsonModel.stories[indexPath.row];
    
    if (newsModel) {
        LCHThemeContainController *themeContainController = [[LCHThemeContainController alloc] init];
        themeContainController.newsID = [NSString stringWithFormat:@"%ld", (long)newsModel.newsID];
        self.tool.newsIDs = self.newsIDs;
        [self.navigationController pushViewController:themeContainController animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kHeight(kHomePageCellHeight);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section ? kHeight(kHomePageTableSectionHeaderViewHeight) : CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return nil;
    }
    LCHHomePageTableHeaderView *tableHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kHomePageHeaderFooterViewIdenfitier];
    if (!tableHeaderView) {
        tableHeaderView = [[LCHHomePageTableHeaderView alloc] initWithReuseIdentifier:kHomePageHeaderFooterViewIdenfitier];
    }
    LCHHomePageBeforeJsonModel *newsJsonModel = self.allHomePageNewsModels[section];
    tableHeaderView.dateString = newsJsonModel.date;
    
    return tableHeaderView;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (section == 0) {
        
        [self.navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kHeight(55));
        }];
        self.titleLabel.alpha = 1;
    }
    
    if (section == self.tableView.numberOfSections - 1) {
        LCHHomePageBeforeJsonModel *newsJsonModel = self.allHomePageNewsModels[section];
        NSString *date = newsJsonModel.date;
        [self updateHomePageDataWithDate:date];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (section == 0) {
        [self.navigationBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kHeight(20));
        }];
        
        self.titleLabel.alpha = 0;
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offSetY = scrollView.contentOffset.y;
    
    if (offSetY<=0&&offSetY>=-90)  self.navigationBar.alpha = 0;
    else if(offSetY <= 500) self.navigationBar.alpha = offSetY/200;
    
}

#pragma mark - LCHCycleViewDataSource

- (NSInteger)numberOfViewInCycleView {
    
    return self.topNews.count;
}

- (UIView *)cycleView:(LCHCycleView *)cycleView viewForIndex:(NSInteger)index {
    
    LCHTopHeadView *topHeadView = [[LCHTopHeadView alloc] init];
    
    LCHHomePageTopNewsModel *topNewsModel = self.topNews[index];
    if (topNewsModel) {
        topHeadView.titleLabel.text = topNewsModel.title;
        [topHeadView.imageView sd_setImageWithURL:[NSURL URLWithString:topNewsModel.image]];
        topHeadView.backgroundColor = [UIColor randomColor];
    }
    
    return topHeadView;
}

#pragma mark - LCHCycleViewDelegate

- (void)cycleView:(LCHCycleView *)cycleView didSelectAtIndex:(NSInteger)index {
    
    
    
}

#pragma mark - target action

- (void)handleMenu:(UIButton *)sender{
    
}

- (void)handleRefresh {
    
    [self.refreshView endRefreshing];
}

#pragma mark - lazy loading

- (UITableView *)tableView {
    
    if (_tableView) {
        
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight(kHomePageTableHeaderViewHeight))];
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[LCHHomePageCell class] forCellReuseIdentifier:kHomePageCellIdenfitier];
    
    return _tableView;
}

- (NSMutableArray *)allHomePageNewsModels {
    
    if (_allHomePageNewsModels) {
        
        return _allHomePageNewsModels;
    }
    _allHomePageNewsModels = [[NSMutableArray alloc] init];
    
    return _allHomePageNewsModels;
}

- (NSMutableArray *)topNews {
    
    if (_topNews) {
        
        return _topNews;
    }
    _topNews = [[NSMutableArray alloc] init];
    
    return _topNews;
}

- (CircleRefreshView *)refreshView {
    
    if (_refreshView) {
        
        return _refreshView;
    }
    _refreshView = [CircleRefreshView attachObserveToScrollView:self.tableView target:self action:@selector(handleRefresh)];
    
    return _refreshView;
}

- (UIButton *)menuButton {
    
    if (_menuButton) {
        
        return _menuButton;
    }
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_menuButton addTarget:self action:@selector(handleMenu:) forControlEvents:UIControlEventTouchUpInside];
    [_menuButton setImage:[UIImage imageNamed:kHomePageTMenuButtonImageName] forState:UIControlStateNormal];
    
    return _menuButton;
}

- (UILabel *)titleLabel {
    if (_titleLabel) {
        
        return _titleLabel;
    }
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:kHomePageTitleLabelFontSize];
    _titleLabel.text = kHomePageTitleLabelText;
    
    return _titleLabel;
}

- (LCHCycleHeadView *)cycleHeadView {
    
    if (_cycleHeadView) {
        
        return _cycleHeadView;
    }
    _cycleHeadView = [LCHCycleHeadView attachToScrollView:self.tableView];
    _cycleHeadView.delegate = self;
    _cycleHeadView.dataSource = self;
    
    return _cycleHeadView;
}

- (UIView *)navigationBar {
    
    if (_navigationBar) {
        
        return _navigationBar;
    }
    _navigationBar = [[UIView alloc] init];
    _navigationBar.backgroundColor = kColor(23, 144, 211, 1);
    _navigationBar.alpha = 0;
    
    return _navigationBar;
}

- (LCHThemeNewsTool *)tool {
    
    if (_tool) {
        
        return _tool;
    }
    _tool = [LCHThemeNewsTool sharedThemeNewsTool];
    
    return _tool;
}

- (NSMutableArray *)newsIDs {
    
    if (_newsIDs) {
        
        return _newsIDs;
    }
    _newsIDs = [[NSMutableArray alloc] init];
    
    return _newsIDs;
    
}

@end
