//
//  UserModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/3/24.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCoding>

/*
 user_id	用户id	int
 username	用户名	string
 email	电子邮箱	string
 password	密码	string
 sex	性别 0 保密 1 男 2 女	int
 birthday	生日	int
 user_money	用户余额	money
 frozen_money	冻结金额	moeny
 distribut_money	累积分佣金额	money
 pay_points	消费积分	money
 reg_time	注册时间	int
 last_login	最后登录时间	string
 last_ip	最后登录ip	string
 qq	QQ号	string
 mobile	手机	string
 mobile_validated	手机验证状态 0否 1是	int
 oauth	第三方来源 （wx weibo alipay）	string
 openid	第三方唯一标示	int
 head_pic	头像	string
 province	省	string
 city	市	string
 district	区	string
 email_validated	邮箱验证状态 0未验证 1已验证	int
 nickname	昵称	string
 level	用户等级	int
 is_lock	是否被锁定冻结 0 否 1 是	int
 is_distribut	是否分销商 0 否 1 是	int
 first_leader	第一个上级	int
 second_leader	第二个上级	int
 third_leader	第三个上级	int
 token	用于app 授权	string
 dut_time	会员过期时间	int
 level_name	等级名称
 */
HMSingletonH(UserModel);
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSString *user_money;
@property(nonatomic,copy)NSString *distribut_money;
@property(nonatomic,copy)NSString *qq;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *mobile_validated;
@property(nonatomic,copy)NSString *openid;
@property(nonatomic,copy)NSString *frozen_money;
@property(nonatomic,copy)NSString *head_pic;
@property(nonatomic,copy)NSString *province;
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *level;
@property(nonatomic,copy)NSString *is_lock;
@property(nonatomic,copy)NSString *is_distribut;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *level_name;
@property(nonatomic,copy)NSString *first_leader;
@property(nonatomic,copy)NSString *second_leader;
@property(nonatomic,copy)NSString *third_leader;


@end
