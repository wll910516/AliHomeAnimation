//
//  HomeViewModel.m
//  AliPayRecommendDemo
//
//  Created by admin on 2017/12/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (NSArray *)newFunctions {
    NSMutableArray *mutArr = [NSMutableArray array];
    
    HomeFunctionConfig *prepareApproveC = [self getFunctionConfigWithImageName:@"home_scan_big"
                                                                           title:@"扫一扫"
                                                                       textColor:[UIColor whiteColor]];
    
    HomeFunctionConfig *claimC = [self getFunctionConfigWithImageName:@"home_pay_big"
                                                                  title:@"付钱"
                                                              textColor:[UIColor whiteColor]];
    
    HomeFunctionConfig *approvelRequestC = [self getFunctionConfigWithImageName:@"home_collect_big"
                                                                            title:@"收钱"
                                                                        textColor:[UIColor whiteColor]];
    
    
    HomeFunctionConfig *signC = [self getFunctionConfigWithImageName:@"home_pocket_big"
                                                                 title:@"卡包"
                                                             textColor:[UIColor whiteColor]];
    
    [mutArr addObject:prepareApproveC];
    [mutArr addObject:claimC];
    [mutArr addObject:approvelRequestC];
    [mutArr addObject:signC];
    return [mutArr copy];
}

- (NSArray *)oldFunctions {
    NSMutableArray *mutArr = [NSMutableArray array];
    
    HomeFunctionConfig *config1 = [self getFunctionConfigWithImageName:@"home_deductible"
                                                                   title:@"转账"
                                                               textColor:[UIColor didSelectColor]];
    
    HomeFunctionConfig *config2 = [self getFunctionConfigWithImageName:@"home_more"
                                                                   title:@"更多"
                                                               textColor:[UIColor didSelectColor]];
    
    HomeFunctionConfig *config3 = [self getFunctionConfigWithImageName:@"home_deductible"
                                                                 title:@"转账"
                                                             textColor:[UIColor didSelectColor]];
    
    HomeFunctionConfig *config4 = [self getFunctionConfigWithImageName:@"home_more"
                                                                 title:@"更多"
                                                             textColor:[UIColor didSelectColor]];
    
    HomeFunctionConfig *config5 = [self getFunctionConfigWithImageName:@"home_deductible"
                                                                 title:@"转账"
                                                             textColor:[UIColor didSelectColor]];
    
    HomeFunctionConfig *config6 = [self getFunctionConfigWithImageName:@"home_more"
                                                                 title:@"更多"
                                                             textColor:[UIColor didSelectColor]];
    
    HomeFunctionConfig *config7 = [self getFunctionConfigWithImageName:@"home_deductible"
                                                                 title:@"转账"
                                                             textColor:[UIColor didSelectColor]];
    
    HomeFunctionConfig *config8 = [self getFunctionConfigWithImageName:@"home_more"
                                                                 title:@"更多"
                                                             textColor:[UIColor didSelectColor]];
    [mutArr addObject:config1];
    [mutArr addObject:config2];
    [mutArr addObject:config3];
    [mutArr addObject:config4];
    [mutArr addObject:config5];
    [mutArr addObject:config6];
    [mutArr addObject:config7];
    [mutArr addObject:config8];
    
    return [mutArr copy];
}

- (HomeFunctionConfig *)getFunctionConfigWithImageName:(NSString *)imageName
                                                   title:(NSString *)title
                                               textColor:(UIColor *)textColor {
    HomeFunctionConfig *prepareApproveC = [HomeFunctionConfig new];
    prepareApproveC.imageName = imageName;
    prepareApproveC.title = title;
    prepareApproveC.titleColor = textColor;
    return prepareApproveC;
}

@end
