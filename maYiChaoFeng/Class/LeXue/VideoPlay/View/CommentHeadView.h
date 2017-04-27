//
//  CommentHeadView.h
//  maYiChaoFeng
//
//  Created by Android on 2017/3/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
@interface CommentHeadView : UIView
//显示简介
@property(nonatomic,copy)void(^unfold)(CGFloat height);

@property(nonatomic,copy)void(^sendAction)(NSString *content);
//
@property(nonatomic,copy)void(^shareAction)();
//

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailHegit;
//文章模型
@property(nonatomic,strong)ArticleModel *model;


@end
