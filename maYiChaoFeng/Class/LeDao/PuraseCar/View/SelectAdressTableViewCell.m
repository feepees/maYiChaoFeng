//
//  SelectAdressTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "SelectAdressTableViewCell.h"
@interface SelectAdressTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@end
@implementation SelectAdressTableViewCell


-(void)setModel:(AddressModel *)model{
    _model=model;
    self.nameLabel.text=model.name;
    self.phoneLable.text=model.mobile;
    self.addressLable.text=model.address;
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
