//
//  BannerModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/3/28.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
/*
 id	广告id	int
 type_id	分类id	int
 sort	排序	int
 title	标题	string
 pic	图片	string
 fujian	附件	string
 url	链接地址	string
 miaoshu	描述	string
 createtime	创建时间	string
 updatetime	修改时间	string
 */
@property(nonatomic,copy)NSString *Id;
@property(nonatomic,copy)NSString *type_id;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *fujian;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *miaoshu;
@property(nonatomic,copy)NSString *createtime;
@property(nonatomic,copy)NSString *updatetime;

@end
