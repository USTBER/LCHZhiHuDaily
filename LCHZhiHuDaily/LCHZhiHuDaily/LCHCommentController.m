//
//  LCHCommentController.m
//  LCHZhiHuDaily
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LCHCommentController.h"
#import "LCHCommentBottomBar.h"
#import "LCHCommentPageConfig.h"
#import "LCHShortCommentJsonModel.h"
#import "LCHShortCommentModel.h"
#import "LCHLongCommentJsonModel.h"
#import "LCHLongCommentModel.h"
#import "LCHCommentCell.h"
#import "LCHShortCommentDisplayCell.h"
#import "LCHLongCommentDisplayCell.h"
#import "LCHLoginController.h"

@interface LCHCommentController ()
<LCHCommentBottomBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) LCHCommentBottomBar *bottomBar;
@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *noCommentImageView;
@property (nonatomic, strong) UILabel *noCommentLabel;
@property (nonatomic, strong) NSMutableArray *longComments;
@property (nonatomic, strong) NSMutableArray *shortComments;
@property (nonatomic, strong) NSMutableArray *shortCommentsForDisplay;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *viewWithoutLongComment;
@property (nonatomic, strong) LCHLongCommentDisplayCell *longCommentDisplayCell;

- (void)configConstraints;
- (void)getCommentData;

@end

@implementation LCHCommentController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.bottomBar];
    [self.view addSubview:self.tableView];
    [self.viewWithoutLongComment addSubview:self.noCommentImageView];
    [self.viewWithoutLongComment addSubview:self.noCommentLabel];
    self.tableView.tableHeaderView = self.viewWithoutLongComment;
    
    [self configConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getCommentData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)configConstraints {
    WeakObject(weakTopBar, self.topBar);
    WeakObject(weakBottomBar, self.bottomBar);
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.offset(0);
        make.height.mas_equalTo(kHeight(kCommentTopBarHeight));
    }];
    
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.offset(0);
        make.height.mas_equalTo(kHeight(kCommentBottomBarHeight));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.offset(0);
        make.top.equalTo(weakTopBar.mas_bottom);
        make.bottom.equalTo(weakBottomBar.mas_top);
    }];
    
    [self.noCommentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(kHeight(kCommentPageNoCommentImageViewTopPadding));
        make.width.mas_equalTo(kWidth(kCommentPageNoCommentImageViewWidth));
        make.height.mas_equalTo(kHeight(kCommentPageNoCommentImageViewHeight));
    }];
    
    [self.noCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(kHeight(kCommentPageNoCommentLabelTopPadding));
        make.width.and.height.greaterThanOrEqualTo(@0.1);
    }];
}

- (void)getCommentData {
    
    if (!self.newsID) {
        
        return;
    }
    NSString *longCommentURL = [NSString stringWithFormat:kLongCommentAPI, self.newsID];
    NSString *shortCommentURL = [NSString stringWithFormat:kShortCommentAPI, self.newsID];
    [LCHDataManager getNewsLongComment:longCommentURL success:^(id returnModel) {
        
        LCHLongCommentJsonModel *longCommentJsonModel = returnModel;
        self.longComments = longCommentJsonModel.comments;
        
        if (self.longComments.count > 0) {
            self.tableView.tableHeaderView = self.longCommentDisplayCell;
            self.longCommentDisplayCell.longCommentNumberLabel.text = [NSString stringWithFormat:kCommentPageLongCommentNumberLabelText, self.longComments.count];
        }
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    [LCHDataManager getNewsShortComment:shortCommentURL success:^(id returnModel) {
        
        LCHShortCommentJsonModel *shortCommentJsonModel = returnModel;
        self.shortComments = shortCommentJsonModel.comments;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - LCHCommentBottomBarDelegate

- (void)didSelectBack:(LCHCommentBottomBar *)commentBar {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didSelectWrite:(LCHCommentBottomBar *)commentBar {
    
    LCHLoginController *loginController = [[LCHLoginController alloc] init];
    [self presentViewController:loginController animated:YES completion:nil];
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return self.longComments.count;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            return self.shortCommentsForDisplay.count;
            break;
            
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCHCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:kCommentCellReuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        LCHLongCommentModel *longCommentModel = self.longComments[indexPath.row];
        if (longCommentModel) {
            commentCell.authorNameLabel.text = longCommentModel.author;
            commentCell.commentLabel.text = longCommentModel.content;
            commentCell.dateLabel.text = longCommentModel.time;
            [commentCell.avatar sd_setImageWithURL:[NSURL URLWithString:longCommentModel.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [commentCell.avatar roundRectImageView];
                });
            }];
        }
    }
    
    if (indexPath.section == 1) {
        
        LCHShortCommentDisplayCell *displayCell = [tableView dequeueReusableCellWithIdentifier:kCommentPageDispalyCellReuseIdentifier forIndexPath:indexPath];
        [displayCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        NSInteger count = self.shortComments.count;
        displayCell.shortCommentNumberLabel.text = [NSString stringWithFormat:@"%ld条短评论", (long)count];
        
        return displayCell;
    }
    
    if (indexPath.section == 2) {
        
        LCHShortCommentModel *shortCommentModel = self.shortCommentsForDisplay[indexPath.row];
        if (shortCommentModel) {
            commentCell.authorNameLabel.text = shortCommentModel.author;
            commentCell.commentLabel.text = shortCommentModel.content;
            commentCell.dateLabel.text = shortCommentModel.time;
            
            [commentCell.avatar sd_setImageWithURL:[NSURL URLWithString:shortCommentModel.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [commentCell.avatar roundRectImageView];
                });
            }];
        }
    }
    [commentCell setNeedsLayout];
    [commentCell layoutIfNeeded];
    
    return commentCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        LCHShortCommentDisplayCell *shortCommentDisplayCell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (self.shortCommentsForDisplay.count == 0) {
            self.shortCommentsForDisplay = self.shortComments;
        } else {
            self.shortCommentsForDisplay = [[NSMutableArray alloc] init];
        }
        
        [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:2] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        [UIView animateWithDuration:0.3 animations:^{
            [shortCommentDisplayCell changeArrowDirection];
        } completion:^(BOOL finished) {
            [tableView layoutIfNeeded];
            [tableView setNeedsLayout];
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

#pragma mark - lazy loading

- (UIView *)topBar {
    
    if (_topBar) {
        
        return _topBar;
    }
    _topBar = [[UIView alloc] init];
    _topBar.backgroundColor = kColor(23, 144, 211, 1);
    
    return _topBar;
}

- (LCHCommentBottomBar *)bottomBar {
    
    if (_bottomBar) {
        
        return _bottomBar;
    }
    _bottomBar = [[LCHCommentBottomBar alloc] init];
    _bottomBar.delegate = self;
    
    return _bottomBar;
}

- (UIImageView *)noCommentImageView {
    
    if (_noCommentImageView) {
        
        return _noCommentImageView;
    }
    _noCommentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kCommentPageNoCommentImageViewImageName]];
    _noCommentImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return _noCommentImageView;
}

- (UILabel *)noCommentLabel {
    
    if (_noCommentLabel) {
        
        return _noCommentLabel;
    }
    _noCommentLabel = [[UILabel alloc] init];
    _noCommentLabel.font = [UIFont systemFontOfSize:kCommentPageNoCommentLabelFontSize];
    _noCommentLabel.textAlignment = NSTextAlignmentCenter;
    _noCommentLabel.textColor = [UIColor lightTextColor];
    
    return _noCommentLabel;
}

- (NSMutableArray *)longComments {
    
    if (_longComments) {
        
        return _longComments;
    }
    _longComments = [[NSMutableArray alloc] init];
    
    return _longComments;
}

- (NSMutableArray *)shortComments {
    
    if (_shortComments) {
        
        return _shortComments;
    }
    _shortComments = [[NSMutableArray alloc] init];
    
    return _shortComments;
}

- (UIActivityIndicatorView *)activityIndicator {
    
    if (_activityIndicator) {
        
        return _activityIndicator;
    }
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.hidesWhenStopped = YES;
    
    return _activityIndicator;
}

- (UITableView *)tableView {
    
    if (_tableView) {
        
        return _tableView;
    }
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.estimatedRowHeight = 10.f;
    [_tableView registerClass:[LCHCommentCell class] forCellReuseIdentifier:kCommentCellReuseIdentifier];
    [_tableView registerClass:[LCHShortCommentDisplayCell class] forCellReuseIdentifier:kCommentPageDispalyCellReuseIdentifier];
    
    return _tableView;
}

- (UIView *)viewWithoutLongComment {
    
    if (_viewWithoutLongComment) {
        
        return _viewWithoutLongComment;
    }
    _viewWithoutLongComment = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeight(kCommentPageViewWithOutLongCommentHeight))];
    
    return _viewWithoutLongComment;
}

- (LCHLongCommentDisplayCell *)longCommentDisplayCell {
    
    if (_longCommentDisplayCell) {
        
        return _longCommentDisplayCell;
    }
    _longCommentDisplayCell = [[LCHLongCommentDisplayCell alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeight(kCommentPageViewWithLongCommentHeight))];
    
    return _longCommentDisplayCell;
}

- (NSMutableArray *)shortCommentsForDisplay {
    
    if (_shortCommentsForDisplay) {
        
        return _shortCommentsForDisplay;
    }
    _shortCommentsForDisplay = [[NSMutableArray alloc] init];
    
    return _shortCommentsForDisplay;
}

@end
