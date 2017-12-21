//
//  ViewController.m
//  AliPayRecommendDemo
//
//  Created by admin on 2017/12/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "TopView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) TopView *topView;
@property (nonatomic, strong) FunctionView *functionView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self initSubviewsLayout];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method

- (void)setupSubviews {
    [self.view addSubview:self.topView];
    // 实现支付宝首页向上推动的动画
    [self.view insertSubview:self.tableView belowSubview:self.topView];
    [self.view insertSubview:self.functionView belowSubview:self.topView];

    // 适配iOS11 scrollView会自动向下移动状态栏的高度
    if (@available(iOS 11.0, *)){
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    CGFloat contentOffSetY = TopViewHeight + FunctionViewHeight;
    self.tableView.contentOffset = CGPointMake(0, -(contentOffSetY));
    self.tableView.contentInset = UIEdgeInsetsMake(contentOffSetY, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(-contentOffSetY, 0, 0, 0);
    
    // 关键
    UIPanGestureRecognizer *pan = [self.tableView valueForKey:[NSString stringWithFormat:@"%@%@",@"pan",@"GestureRecognizer"]];
    [self.view addGestureRecognizer:pan];
}

- (void)initSubviewsLayout {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.greaterThanOrEqualTo(@(TopSimpleViewHeight));
        make.bottom.equalTo(self.topView.oldFunctionView);
    }];
    
    [self.functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(FunctionViewHeight);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(screenHeight);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat topViewHeight = TopViewHeight + FunctionViewHeight;
    CGPoint point = scrollView.contentOffset;
    if (point.y < 0) {
        CGFloat realOffset = topViewHeight - fabs(point.y);
        CGFloat topViewMaxOffset = TopViewHeight - TopSimpleViewHeight;
        if (realOffset < TopSimpleViewHeight * 0.5) {
            [scrollView setContentOffset:CGPointMake(0, -(FunctionViewHeight + TopViewHeight))];
        }
        else if (realOffset >= TopSimpleViewHeight * 0.5 && realOffset < topViewMaxOffset) {
            [scrollView setContentOffset:CGPointMake(0, -(FunctionViewHeight + TopViewHeight - topViewMaxOffset))];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat topViewHeight = TopViewHeight + FunctionViewHeight;
    
    CGPoint point = scrollView.contentOffset;
    CGFloat oldFunctionViewTopOffset = 0;
    CGFloat newFunctionViewTopOffset = 0;
    
    if (point.y <= 0) {
        if (fabs(point.y) <= topViewHeight) {
            CGFloat realOffset = topViewHeight - fabs(point.y);
            CGFloat topViewMaxOffset = TopViewHeight - TopSimpleViewHeight;
            CGFloat topViewAlpha = realOffset / topViewMaxOffset;
            self.topView.oldFunctionView.alpha = 1 - topViewAlpha;
            self.topView.topSimpleView.alpha = topViewAlpha;
            if (realOffset <= topViewMaxOffset) {
                oldFunctionViewTopOffset = -realOffset;
            }
            else {
                self.topView.oldFunctionView.alpha = 0;
                self.topView.topSimpleView.alpha = 1;
                oldFunctionViewTopOffset = -topViewMaxOffset;
            }
            newFunctionViewTopOffset = TopViewHeight - realOffset;
        }
        else {
            newFunctionViewTopOffset = TopViewHeight;
            oldFunctionViewTopOffset = 0;
            self.topView.oldFunctionView.alpha = 1;
            self.topView.topSimpleView.alpha = 0;
        }
    }
    else if (point.y > 0) {
        CGFloat baseOffset = - FunctionViewHeight;
        newFunctionViewTopOffset = baseOffset - point.y;
        CGFloat topViewMaxOffset = TopViewHeight - TopSimpleViewHeight;
        self.topView.oldFunctionView.alpha = 0;
        self.topView.topSimpleView.alpha = 1;
        oldFunctionViewTopOffset = -topViewMaxOffset;
    }
    [self.topView.oldFunctionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.topView);
        make.top.equalTo(self.view).offset(oldFunctionViewTopOffset);
    }];
    [self.functionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(FunctionViewHeight);
        make.top.equalTo(self.view).offset(newFunctionViewTopOffset);
    }];
}

#pragma mark - setter and getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor t5];
        [_tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 0.5)];
        _tableView.tableHeaderView = view;
        _tableView.tableFooterView = view;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (TopView *)topView {
    if (!_topView) {
        _topView = [[TopView alloc] init];
        _topView.backgroundColor = [UIColor mainColor];
    }
    return _topView;
}

- (FunctionView *)functionView {
    if (!_functionView) {
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
        _functionView = [[FunctionView alloc] initWithFrame:CGRectZero collectionViewLayout:layOut];
        _functionView.scrollEnabled = NO;
        _functionView.dataSources = [[HomeViewModel new] oldFunctions];
    }
    return _functionView;
}


@end
