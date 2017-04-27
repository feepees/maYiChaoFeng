//
//  MoviePlayerViewController.h
//  maYiChaoFeng
//
//  Created by Android on 2017/2/20.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
@interface MoviePlayerViewController : UIViewController
/** 视频URL */
@property (nonatomic, strong) NSURL *videoURL;
//文章id
@property(nonatomic,strong)NSString *a_id;
//
@property(nonatomic,strong)NSString *titleName;
//文章模型
@property(nonatomic,strong)ArticleModel *model;
@end
