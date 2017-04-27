//
//  OrderModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/19.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsOrderModel : NSObject
/*
 参数名	描述	类型
 order_id	购物车id	int
 order_sn	订单编号	int
 user_id	用户id	int
 order_status	订单状态	string
 shipping_status	发货状态	money
 pay_status	支付状态	int
 consignee	收货人	string
 region	地区	int
 address	地址	money
 mobile	手机	int
 shipping_code	物流code	int
 shipping_name	物流名称	string
 pay_code	支付code	money
 pay_name	支付方式名称	int
 goods_price	商品总价	string
 user_money	使用余额	int
 order_amount	应付款金额	money
 total_amount	订单总价	int
 add_time	下单时间	int
 shipping_time	最后新发货时间	string
 confirm_time	收货确认时间	money
 pay_time	支付时间	int
 user_note	用户备注	string
 admin_note	管理员备注	int
 parent_sn	父单单号	money
 is_distribut	是否已分成0未分成1已分成	int
 is_show	是否显示 0显示 1不显示	int
 goods	订单商品集合	goods*/
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *order_sn;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *order_status;
@property(nonatomic,copy)NSString *shipping_status;
@property(nonatomic,copy)NSString *pay_status;
@property(nonatomic,copy)NSString *consignee;
@property(nonatomic,copy)NSString *region;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *shipping_code;
@property(nonatomic,copy)NSString *shipping_name;
@property(nonatomic,copy)NSString *pay_code;
@property(nonatomic,copy)NSString *pay_name;
@property(nonatomic,copy)NSString *goods_price;
@property(nonatomic,copy)NSString *user_money;
@property(nonatomic,copy)NSString *order_amount;
@property(nonatomic,copy)NSString *total_amount;
@property(nonatomic,copy)NSString *add_time;
@property(nonatomic,copy)NSString *shipping_time;
@property(nonatomic,copy)NSString *confirm_time;
@property(nonatomic,copy)NSString *pay_time;
@property(nonatomic,copy)NSString *user_note;
@property(nonatomic,copy)NSString *admin_note;
@property(nonatomic,copy)NSString *parent_sn;
@property(nonatomic,copy)NSString *is_distribut;
@property(nonatomic,copy)NSString *is_show;
@property(nonatomic,strong)NSMutableArray *goods;
@end
