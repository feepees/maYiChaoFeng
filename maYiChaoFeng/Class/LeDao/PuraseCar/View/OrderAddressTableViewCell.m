//
//  OrderAddressTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "OrderAddressTableViewCell.h"
@interface OrderAddressTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@end
@implementation OrderAddressTableViewCell
- (IBAction)selectAddressAction:(id)sender {
    self.selectAddresAction();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(AddressModel *)model{
    _model=model;
    self.addressLable.text=model.address;
    self.phoneLable.text=model.mobile;
    self.nameLable.text=model.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
