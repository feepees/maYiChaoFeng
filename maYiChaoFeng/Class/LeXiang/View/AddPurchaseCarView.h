//
//  AddPurchaseCarView.h
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPurchaseCarView : UIView
@property(nonatomic,copy)void(^addCarAction)();
@property(nonatomic,copy)void(^purchaseAction)();
@end