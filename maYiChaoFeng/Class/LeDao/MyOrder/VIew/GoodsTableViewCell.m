//
//  GoodsTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/20.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "GoodsTableViewCell.h"
@interface GoodsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLable;
@property (weak, nonatomic) IBOutlet UILabel *goodNumLable;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@end
@implementation GoodsTableViewCell

-(void)setModel:(GoodModel *)model{
    _model=model;
    [self.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.goods_pic]] placeholderImage:[UIImage imageNamed:@"banner"]];
    self.goodsNameLable.text=model.goods_name;
    self.goodNumLable.text=model.goods_num;
    self.goodsPriceLable.text=model.goods_price;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
