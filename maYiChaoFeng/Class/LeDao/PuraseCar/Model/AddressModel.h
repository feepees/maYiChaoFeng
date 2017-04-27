//
//  AddressModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/18.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
/*
 参数名	描述	类型
 id	id	int
 user_id	用户id	int
 name	收件人	string
 mobile	电话	string
 region	省市区	string
 address	地址	string
 is_default	是否默认	int
 */
@property(nonatomic,copy)NSString *Id;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *region;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *is_default;
@end
