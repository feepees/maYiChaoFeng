//
//  CartModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/18.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartModel : NSObject
/*
 参数名	描述	类型
 id	购物车id	int
 user_id	用户id	int
 goods_id	商品id	int
 goods_name	商品名称	string
 goods_price	价格	money
 goods_num	数量	int
 goods_pic	图片	string
 add_time	添加时间	int
 total	总价	money

 */
@property(nonatomic,copy)NSString *Id;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *goods_id;
@property(nonatomic,copy)NSString *goods_name;
@property(nonatomic,copy)NSString *goods_price;
@property(nonatomic,copy)NSString *goods_num;
@property(nonatomic,copy)NSString *goods_pic;
@property(nonatomic,copy)NSString *add_time;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,copy)NSString *is_selected;
@end
