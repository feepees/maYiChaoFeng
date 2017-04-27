//
//  GoodsCommentTableViewCell.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface GoodsCommentTableViewCell : UITableViewCell
@property(nonatomic,copy)void(^seeAllComment)();
@property(nonatomic,strong)CommentModel *model;
@end
