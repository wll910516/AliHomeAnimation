//
//  FunctionView.m
//  AliPayRecommendDemo
//
//  Created by admin on 2017/12/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FunctionView.h"

@interface FunctionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation FunctionView

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor mainColor];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeCollectionViewCell class])];
    }
    return self;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = screenWidth * (1.0 / 4);
    CGFloat itemH = FuncationCellHeight;
    return CGSizeMake(itemW, itemH);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 0, 0, 0);
}


#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeCollectionViewCell class])
                                                                           forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[HomeCollectionViewCell class]]) {
        HomeCollectionViewCell *mCell = (HomeCollectionViewCell *)cell;
        HomeFunctionConfig *config = self.dataSources[indexPath.row];
        [mCell updateContentWithModel:config];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)setDataSources:(NSArray<HomeFunctionConfig *> *)dataSources {
    _dataSources = dataSources;
    [self reloadData];
}

@end
