//
//  PurhaseTableViewCell.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartModel.h"
@interface PurhaseTableViewCell : UITableViewCell
@property(nonatomic,copy)void(^deleteAction)(CartModel *model);
@property(nonatomic,copy)void(^doneAction)(CartModel *model);
@property(nonatomic,copy)void(^selectAction)(CartModel *model,BOOL isSelect);
@property(nonatomic,assign)BOOL goodsSelected;


@property(nonatomic,strong)CartModel *model;

@end
