//
//  GoodModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/20.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodModel : NSObject
/*
 
 rec_id : 904,
	order_id : 804,
	goods_num : 1,
	goods_pic : /Uploads/20170413/58ef2577b0ba0.png,
	prom_type : 0,
	is_comment : 0,
	is_send : 0,
	goods_price : 200.00,
	goods_name : 乐享测试商品10,
	delivery_id : 0,
	goods_id : 72
 }
 */
@property(nonatomic,copy)NSString *rec_id;
@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *goods_num;
@property(nonatomic,copy)NSString *goods_pic;
@property(nonatomic,copy)NSString *prom_type;
@property(nonatomic,copy)NSString *is_comment;
@property(nonatomic,copy)NSString *goods_price;
@property(nonatomic,copy)NSString *goods_name;
@property(nonatomic,copy)NSString *delivery_id;
@property(nonatomic,copy)NSString *goods_id;


@end
