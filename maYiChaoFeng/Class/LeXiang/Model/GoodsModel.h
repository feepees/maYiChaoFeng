//
//  GoodsModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject
/*
 参数名	描述	类型
 a_id	文章id	int
 cid	分类id	int
 sort	排序	int
 a_title	中文标题	string
 e_title	英文标题	string
 a_pic	列表图	string
 big_pic	大图片	string
 fj_drss	视频地址	string
 flag	是否推荐 0否 1是	int
 link_drss	链接地址	string
 seotitle	seo标题	string
 keywords	关键字	article
 description	简述	string
 a_content	详细描述	string
 createtime	创建时间	int
 updatetime	更新时间	int
 clicknum	点击数	int
 sharenum	分享数	int
 commentnum	回复数	int
 zannum	点赞数	int
 price	价格	money
 
 */
@property(nonatomic,copy)NSString *a_id;
@property(nonatomic,copy)NSString *cid;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *a_title;
@property(nonatomic,copy)NSString *e_title;
@property(nonatomic,copy)NSString *a_pic;
@property(nonatomic,copy)NSString *big_pic;
@property(nonatomic,copy)NSString *link_drss;
@property(nonatomic,copy)NSString *seotitle;
@property(nonatomic,copy)NSString *keywords;
@property(nonatomic,copy)NSString *descr;
@property(nonatomic,copy)NSString *a_content;
@property(nonatomic,copy)NSString *createtime;
@property(nonatomic,copy)NSString *updatetime;
@property(nonatomic,copy)NSString *clicknum;
@property(nonatomic,copy)NSString *sharenum;
@property(nonatomic,copy)NSString *commentnum;
@property(nonatomic,copy)NSString *zannum;
@property(nonatomic,copy)NSString *price;

@end
