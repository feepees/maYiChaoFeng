//
//  LeXiangTableViewCell.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
@interface LeXiangTableViewCell : UITableViewCell
@property(nonatomic,copy)void(^AddToCartAction) ();
@property(nonatomic,strong)GoodsModel *model;
@end
