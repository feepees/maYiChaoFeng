//
//  ArticleModel.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/27.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"desc": @"description"};
}

@end
