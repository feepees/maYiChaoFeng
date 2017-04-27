//
//  GoodsDetailTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "GoodsDetailTableViewCell.h"
@interface GoodsDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *goosName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetailLable;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLable;
@end
@implementation GoodsDetailTableViewCell


-(void)setModel:(GoodsModel *)model{
    _model=model;
    self.goosName.text=model.a_title;
    self.goodsDetailLable.text=model.a_title;
    self.goodsPriceLable.text=model.price;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
