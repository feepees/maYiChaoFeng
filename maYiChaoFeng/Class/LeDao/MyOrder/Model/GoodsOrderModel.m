//
//  OrderModel.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/19.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "GoodsOrderModel.h"
#import "GoodsModel.h"
@implementation GoodsOrderModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"goods":@"GoodModel"};
}
@end
