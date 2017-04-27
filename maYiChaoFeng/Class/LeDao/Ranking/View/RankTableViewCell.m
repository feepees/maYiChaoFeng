//
//  RankTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/27.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "RankTableViewCell.h"
@interface RankTableViewCell()

@end
@implementation RankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(MenmberModel *)model{
    _model=model;
    [self.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.head_pic]] placeholderImage:[UIImage imageNamed:@"mrtx_y"]];
    self.nickNameLable.text=model.username;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
