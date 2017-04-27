//
//  DeliverAddressTableViewCell.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface DeliverAddressTableViewCell : UITableViewCell
@property(nonatomic,strong)AddressModel *model;
@property(nonatomic,copy)void(^editorAction)(AddressModel *model);
@property(nonatomic,copy)void(^deleteAction)(AddressModel *model);
@property(nonatomic,copy)void(^DefaultAction)();
@end
