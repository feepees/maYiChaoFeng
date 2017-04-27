//
//  MJHttpTool.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/21.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "MJHttpTool.h"
#import "AFNetworking.h"

@implementation MJHttpTool
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure{

    AFHTTPSessionManager *mgr = [MJHttpTool getAFHTTPSessionManager];
    
    [mgr GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
        
    }];


}


+ (void)Post:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure{

    AFHTTPSessionManager *mgr = [MJHttpTool getAFHTTPSessionManager];
    
    [mgr POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];



}

+ (void)PostHead:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *mgr = [MJHttpTool getAFHTTPSessionManager];
    mgr.requestSerializer=[AFHTTPRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/octet-stream" forHTTPHeaderField:@"content-type"];
    [mgr POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
}
+(AFHTTPSessionManager *)getAFHTTPSessionManager{
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //    设置请求头
    //https请求设置下面两个属性
    mgr.securityPolicy.allowInvalidCertificates = YES;
    mgr.securityPolicy.validatesDomainName = NO;
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"image/jpg", nil];
    return mgr;
    
}



@end
