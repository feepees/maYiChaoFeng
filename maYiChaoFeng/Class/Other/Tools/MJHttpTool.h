//
//  MJHttpTool.h
//  maYiChaoFeng
//
//  Created by Android on 2017/2/21.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJHttpTool : NSObject
/**
 *  发送get请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的基本的url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Post:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;

+ (void)PostHead:(NSString *)URLString
      parameters:(id)parameters
         success:(void (^)(id responseObject))success
         failure:(void (^)(NSError *error))failure;
@end
