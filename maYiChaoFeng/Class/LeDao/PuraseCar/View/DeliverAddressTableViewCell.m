//
//  DeliverAddressTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "DeliverAddressTableViewCell.h"
@interface DeliverAddressTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *defaultLable;
@property (weak, nonatomic) IBOutlet UILabel *addressDetail;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumbeiLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIButton *isDefaultBtn;
@end
@implementation DeliverAddressTableViewCell
- (IBAction)setDefault:(id)sender {
    self.DefaultAction();
}
- (IBAction)editBtn:(id)sender {
    self.editorAction(self.model);
}
- (IBAction)deleteBtn:(id)sender {
    self.deleteAction(self.model);
}
-(void)setModel:(AddressModel *)model{
    _model=model;
    self.nameLable.text=model.name;
    self.phoneNumbeiLable.text=model.mobile;
    self.addressDetail.text=model.address;
    if(![model.is_default isEqualToString:@"1"]){
        self.defaultLable.hidden=YES;
        self.isDefaultBtn.selected=NO;
    }
    else{
        self.isDefaultBtn.selected=YES;
    }
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
