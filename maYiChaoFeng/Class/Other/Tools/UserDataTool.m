//
//  UserDataTool.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/30.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "UserDataTool.h"
#import "UserModel.h"
@implementation UserDataTool
+(void)updataUserProfileWithValue:(NSString *)value andKey:(NSString *)key{
    
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    parameter[@"key"]=key;
    parameter[@"value"]=value;
    MYLog(@"修改用户信息key:%@value:%@",key,value);
    [MJHttpTool Post:GetProfile parameters:parameter    success:^(id responseObject) {
        MYLog(@"修改用户%@信息%@",key,responseObject);
    } failure:^(NSError *error) {
        MYLog(@"修改用户%@信息失败%@",key,error);
    }];
}
+(void)getUserProfile{
    
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
[MJHttpTool Post:GetProfile parameters:parameter    success:^(id responseObject) {
    MYLog(@"获取用户信息%@",responseObject);
    UserModel *model= [UserModel mj_objectWithKeyValues:responseObject[@"data"]];
    [NSKeyedArchiver archiveRootObject:model toFile:UserData];
    
} failure:^(NSError *error) {
    MYLog(@"获取用户信息失败%@",error);
}];
}
@end
