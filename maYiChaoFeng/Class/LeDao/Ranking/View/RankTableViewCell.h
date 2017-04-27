//
//  RankTableViewCell.h
//  maYiChaoFeng
//
//  Created by Android on 2017/3/27.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenmberModel.h"
@interface RankTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *rankView;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *moneyView;
@property (weak, nonatomic) IBOutlet UILabel *RankNum;
@property(nonatomic,strong)MenmberModel *model;
@end
