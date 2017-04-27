//
//  WaitPayTableViewCell.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"
@interface WaitPayTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray *dataSoure;
@property(nonatomic,copy)void(^cancalOrder)(GoodsOrderModel *model);
@property(nonatomic,copy)void(^payOrder)(GoodsOrderModel *model);
@property(nonatomic,copy)void(^selectOrder)(GoodsOrderModel *model,BOOL isSelected);
@property(nonatomic,strong)GoodsOrderModel *model;
@end
