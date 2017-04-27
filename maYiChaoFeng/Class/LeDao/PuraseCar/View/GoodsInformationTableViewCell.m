//
//  GoodsInformationTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "GoodsInformationTableViewCell.h"
@interface GoodsInformationTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@end
@implementation GoodsInformationTableViewCell
-(void)setModel:(CartModel *)model{
    _model=model;
    [self.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.goods_pic]] placeholderImage:[UIImage imageNamed:@"banner"]];
    self.priceLable.text=model.goods_price;
    self.countLable.text=[NSString stringWithFormat:@"数量:%@",model.goods_num];
    self.titleLable.text=model.goods_name;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
