//
//  OrderDataTool.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/24.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDataTool : NSObject

+(void)getOrderWithStatus:(NSString *)status page:(NSString *)page success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)deleteOrderWithId:(NSString *)orderId success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
