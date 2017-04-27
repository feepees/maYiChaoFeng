//
//  WaitDispatchTableViewCell.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"
@interface WaitDispatchTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray *dataSoure;
@property(nonatomic,strong)GoodsOrderModel *model;
@end
