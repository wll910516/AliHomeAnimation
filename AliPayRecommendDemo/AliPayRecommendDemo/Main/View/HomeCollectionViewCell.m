//
//  HomeCollectionViewCell.m
//  AliPayRecommendDemo
//
//  Created by admin on 2017/12/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HomeCollectionViewCell

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(self.contentView);
            make.width.height.mas_equalTo(34);
        }];
        
        self.titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.imageView.mas_bottom).offset(2);
            make.height.mas_equalTo(16);
        }];
    }
    return self;
}

#pragma mark - Public Method
- (void)updateContentWithModel:(HomeFunctionConfig *)model {
    self.imageView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.title;
    self.titleLabel.textColor = model.titleColor;
}

@end
