//
//  OrderDataTool.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/24.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "OrderDataTool.h"

@implementation OrderDataTool
+(void)getOrderWithStatus:(NSString *)status page:(NSString *)page success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    parameter[@"page"]=page;
    parameter[@"page_size"]=@"5";
    parameter[@"order_status"]=status;
    [MJHttpTool Post:GetOrderList parameters:parameter success:^(id responseObject) {
        //MYLog(@"获取待付款订单列表返回%@",responseObject);
        success(responseObject);
           }
             failure:^(NSError *error) {
               failure(error);
        MYLog(@"获取待付款订单列表错误%@",error);
    }];

}
+(void)deleteOrderWithId:(NSString *)orderId success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{

}
@end
