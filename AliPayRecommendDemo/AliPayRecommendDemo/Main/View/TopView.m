//
//  TopView.m
//  AliPayRecommendDemo
//
//  Created by admin on 2017/12/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TopView.h"

@implementation TopView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor mainColor];
        
        [self addSubview:self.topSimpleView];
        [self.topSimpleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(TopSimpleViewHeight);
        }];
        
        [self addSubview:self.oldFunctionView];
        [self.oldFunctionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.bottom.equalTo(self.oldFunctionView);
        }];
    }
    return self;
}

#pragma mark - setter and getter

- (UIView *)topSimpleView {
    if (!_topSimpleView) {
        _topSimpleView = [UIView new];
        _topSimpleView.alpha = 0;
        for (int i = 0 ; i < 5; i ++) {
            UIButton *btn = [[UIButton alloc] init];
            NSString *imageName = @"";
            switch (i) {
                case 0:
                    imageName = @"home_scan_small";
                    break;
                case 1:
                    imageName = @"home_pay_small";
                    break;
                case 2:
                    imageName = @"home_collect_small";
                    break;
                case 3:
                    imageName = @"home_collect_small";
                    break;
                case 4:
                    imageName = @"account_small";
                    break;
                default:
                    break;
            }
            btn.tag = 1000 + i;
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [_topSimpleView addSubview:btn];
            if (i == 4) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.right.equalTo(_topSimpleView);
                    make.width.height.mas_equalTo(54);
                }];
            }
            else {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(i * 54);
                    make.bottom.equalTo(_topSimpleView);
                    make.height.width.mas_equalTo(54);
                }];
            }
        }
        _topSimpleView.backgroundColor = [UIColor mainColor];
    }
    return _topSimpleView;
}

- (UIView *)oldFunctionView {
    if (!_oldFunctionView) {
        _oldFunctionView = [UIView new];
        _oldFunctionView.backgroundColor = [UIColor mainColor];
        
        UIView *accountView = [self getERPAccountView];
        [_oldFunctionView addSubview:accountView];
        CGFloat topY = iPhoneX ? 55 : 25 ;
        [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_oldFunctionView);
            make.top.equalTo(_oldFunctionView.mas_top).offset(topY);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(230);
        }];
        
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
        FunctionView *oldFunctionView = [[FunctionView alloc] initWithFrame:CGRectZero collectionViewLayout:layOut];
        oldFunctionView.scrollEnabled = NO;
        oldFunctionView.tag = 200;
        oldFunctionView.backgroundColor = [UIColor mainColor];
        oldFunctionView.dataSources = [[HomeViewModel new] newFunctions];
        [_oldFunctionView addSubview:oldFunctionView];
        [oldFunctionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_oldFunctionView);
            make.top.equalTo(accountView.mas_bottom);
            make.bottom.equalTo(_oldFunctionView);
            make.height.mas_equalTo(FuncationCellHeight + 20);
        }];
    }
    return _oldFunctionView;
}

- (UIView *)getERPAccountView {
    UIView *ERPAccountView = [[UIView alloc] init];
    ERPAccountView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    ERPAccountView.layer.masksToBounds = YES;
    ERPAccountView.layer.cornerRadius = 5;
    
    UIView *centerView = [UIView new];
    [ERPAccountView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ERPAccountView);
        make.centerX.centerY.equalTo(ERPAccountView);
    }];
    
    UIImage *avatar = [UIImage imageNamed:@"home_erp"];
    UIImageView *avatarView = [[UIImageView alloc] initWithImage:avatar];
    [avatarView setImage:avatar];
    [centerView addSubview:avatarView];
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(centerView);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(14);
    }];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = @"热门电影：芳华";
    nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [centerView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(centerView);
        make.left.equalTo(avatarView.mas_right).offset(5);
        make.width.mas_lessThanOrEqualTo(130);
    }];
    
    UIImage *image = [UIImage imageNamed:@"home_switch_count"];
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView setImage:image];
    [ERPAccountView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ERPAccountView.mas_right).offset(-15);
        make.centerY.equalTo(ERPAccountView);
        make.width.mas_equalTo(image.size.width);
        make.height.mas_equalTo(image.size.height);
    }];
    
    return ERPAccountView;
}

@end
