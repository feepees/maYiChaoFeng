//
//  PurhaseTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "PurhaseTableViewCell.h"
@interface PurhaseTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLable;
@property (weak, nonatomic) IBOutlet UIImageView *headView;

@property (weak, nonatomic) IBOutlet UIView *editorView;
@property (weak, nonatomic) IBOutlet UILabel *editorGoodsCountLale;

@end
@implementation PurhaseTableViewCell
- (IBAction)selectAction:(id)sender {
   // UIButton *button=(UIButton *)sender;
    self.selectBtn.selected=!self.selectBtn.selected;
    
    self.selectAction(self.model,self.selectBtn.selected);
    
}

- (IBAction)editorAction:(id)sender {
    UIButton *button=(UIButton *)sender;
    button.selected=!button.selected;
    
    if (button.selected) {
    
        self.editorView.hidden=NO;
    }
    else{
        self.editorView.hidden=YES;
        self.model.goods_num=self.editorGoodsCountLale.text;
        self.doneAction(self.model);
    }
    
}

-(void)setModel:(CartModel *)model{
    _model=model;
    if ([self.model.is_selected isEqualToString:@"1"]) {
        self.selectBtn.selected=YES;
    }
    self.nameLable.text=model.goods_name;
    [self.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.goods_pic]] placeholderImage:[UIImage imageNamed:@"banner"]];
    self.goodsCountLable.text=model.goods_num;
    self.editorGoodsCountLale.text=model.goods_num;
    self.priceLable.text=model.goods_price;
    
}
-(void)setGoodsSelected:(BOOL)goodsSelected{
    _goodsSelected=goodsSelected;
    self.selectBtn.selected=goodsSelected;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.editorView.hidden=YES;
    self.selectBtn.selected=NO;
}
- (IBAction)addAction:(id)sender {
    NSInteger count=self.editorGoodsCountLale.text.integerValue;
    count++;
    self.editorGoodsCountLale.text=[NSString stringWithFormat:@"%ld",count];
}
- (IBAction)subtrackAction:(id)sender {
    NSInteger count=self.editorGoodsCountLale.text.integerValue;
    count--;
    self.editorGoodsCountLale.text=[NSString stringWithFormat:@"%ld",count];
}
- (IBAction)deleteAction:(id)sender {
    self.deleteAction(self.model);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
