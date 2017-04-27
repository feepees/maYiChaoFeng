//
//  OrderTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/20.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "OrderTableViewCell.h"
@interface OrderTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@end
@implementation OrderTableViewCell
-(void)setModel:(OrderModel *)model{
    _model=model;
    self.orderNumber.text=model.order_id;
    self.nickNameLable.text=model.nickname;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyy/dd/MM";
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:model.create_time.doubleValue];
    self.timeLable.text= [formatter stringFromDate:date];
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
