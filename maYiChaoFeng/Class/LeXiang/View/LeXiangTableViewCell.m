//
//  LeXiangTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "LeXiangTableViewCell.h"
@interface LeXiangTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UIButton *purchaseCarBtn;

@end
@implementation LeXiangTableViewCell
- (IBAction)purchaseCarBtn:(id)sender {
    self.AddToCartAction();
}
-(void)setModel:(GoodsModel *)model{
    _model=model;
    [self.headVIew setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.a_pic]]];
    //MYLog(@"url----%@",[NSString stringWithFormat:@"%@%@",Host1,model.a_pic]);
    self.titleLable.text=model.a_title;
    self.detailLable.text=model.a_content;
    self.priceLable.text=model.price;
    

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
