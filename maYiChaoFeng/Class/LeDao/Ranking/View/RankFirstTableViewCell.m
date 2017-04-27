//
//  RankFirstTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/29.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "RankFirstTableViewCell.h"

@interface RankFirstTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UIButton *naciNameBtn;
@property (weak, nonatomic) IBOutlet UILabel *creditsLable;
@property (weak, nonatomic) IBOutlet UIButton *leavelBtn;

@end
@implementation RankFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(MenmberModel *)model{
    _model=model;
    [self.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.head_pic]] placeholderImage:[UIImage imageNamed:@"mrtx_y"]];
    [self.naciNameBtn setTitle:model.username forState:UIControlStateNormal];
    
}
@end
