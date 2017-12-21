//
//  FunctionView.h
//  AliPayRecommendDemo
//
//  Created by admin on 2017/12/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFunctionConfig.h"

@interface FunctionView : UICollectionView

@property (nonatomic, strong) NSArray<HomeFunctionConfig *>* dataSources;

@end
