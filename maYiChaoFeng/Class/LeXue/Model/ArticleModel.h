//
//  ArticleModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/3/27.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"
@interface ArticleModel : NSObject
/*
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
 */
@property(nonatomic,strong)NSString *a_id;
@property(nonatomic,strong)NSString *cid;
@property(nonatomic,strong)NSString *sort;
@property(nonatomic,strong)NSString *a_title;
@property(nonatomic,strong)NSString *e_title;
@property(nonatomic,strong)NSString *a_pic;
@property(nonatomic,strong)NSString *big_pic;
@property(nonatomic,strong)NSString *fj_drss;
@property(nonatomic,strong)NSString *flag;
@property(nonatomic,strong)NSString *link_drss;
@property(nonatomic,strong)NSString *keywords;
@property(nonatomic,strong)NSString *a_content;
@property(nonatomic,strong)NSString *createtime;
@property(nonatomic,strong)NSString *updatetime;
@property(nonatomic,strong)NSString *clicknum;
@property(nonatomic,strong)NSString *sharenum;
@property(nonatomic,strong)NSString *commentnum;
@property(nonatomic,strong)NSString *zannum;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSMutableArray<CommentModel*> *comment;

@end
