//
//  OrderAddressTableViewCell.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface OrderAddressTableViewCell : UITableViewCell
@property(nonatomic,copy)void(^selectAddresAction)();
@property(nonatomic,strong)AddressModel *model;
@end
