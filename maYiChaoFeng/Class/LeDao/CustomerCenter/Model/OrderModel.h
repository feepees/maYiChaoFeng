//
//  OrderModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/3/31.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
/*
 id	状态码	int
 user_id	获佣用户	int
 buy_user_id	购买人id	int
 nickname	购买人名称	string
 order_sn	订单编号	string
 order_id	订单id	int
 goods_price	订单商品总额	money
 money	获佣金额	money
 level	获佣用户级别	int
 create_time	分成记录生成时间	int
 confirm	确定收货时间	int
 status	0未付款,1已付款, 2等待分成(已收货) 3已分成, 4已取消	int
 confirm_time	确定分成或者取消时间	int
 remark	备注	string
    id : 692,
	confirm : 0,
	order_sn : 201609090751409115,
	money : 6.48,
	buy_user_id : 2572,
	confirm_time : 0,
	user_id : 2591,
	order_id : 764,
	level : 1,
	remark : ,
	goods_price : 54.00,
	nickname : 皈依三宝,
	create_time : 1473378700,
	status : 0

 */
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *buy_user_id;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *goods_price;
@property(nonatomic,copy)NSString *money;
@property(nonatomic,copy)NSString *level;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *confirm;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *confirm_time;
@property(nonatomic,copy)NSString *remark;
@end
