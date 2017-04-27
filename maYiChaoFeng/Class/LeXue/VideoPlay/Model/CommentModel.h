//
//  CommentModel.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/1.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
/*
 comment_id : 336,
	content : Good very good ,
	user_head : <null>,
	username : <null>,
	article_id : 4,
	is_show : 1,
	user_id : 2591,

 */
@property(nonatomic,copy)NSString *comment_id;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *user_head;
@property(nonatomic,copy)NSString *article_id;
@property(nonatomic,copy)NSString *is_show;
@property(nonatomic,copy)NSString *user_id;
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *add_time;
@end
