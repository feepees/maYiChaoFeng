//
//  LeDaoHeadView.h
//  maYiChaoFeng
//
//  Created by Android on 2017/2/22.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface LeDaoHeadView : UIView
@property(nonatomic,copy)void(^businessActions)(int index);
@property(nonatomic,copy)void(^profileCenter)();
@property(nonatomic,copy)void(^walletCenter)();
@property(nonatomic,strong)UserModel *user;
@end
