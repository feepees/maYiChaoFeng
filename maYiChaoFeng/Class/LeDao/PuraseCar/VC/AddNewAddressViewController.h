//
//  AddNewAddressViewController.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface AddNewAddressViewController : UIViewController
@property(nonatomic,copy)void(^setDefaultAction)();
@property(nonatomic,strong)AddressModel *model;
@end
