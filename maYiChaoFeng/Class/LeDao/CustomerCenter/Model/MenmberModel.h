//
//  MenmberModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/3/31.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenmberModel : NSObject
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *birthday;
@property(nonatomic,copy)NSString *user_money;
@property(nonatomic,copy)NSString *qq;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *mobile_validated;
@property(nonatomic,copy)NSString *openid;
@property(nonatomic,copy)NSString *frozen_money;
@property(nonatomic,strong)NSString *reg_time;
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
