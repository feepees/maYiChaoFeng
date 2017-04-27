//
//  SelectAdressViewController.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@interface SelectAdressViewController : UIViewController
@property(nonatomic,strong)void(^returnAddress)(AddressModel *);
@end
