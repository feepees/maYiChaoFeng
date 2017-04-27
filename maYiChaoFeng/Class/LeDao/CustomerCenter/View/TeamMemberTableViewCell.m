//
//  TeamMemberTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/20.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "TeamMemberTableViewCell.h"
@interface TeamMemberTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@end
@implementation TeamMemberTableViewCell
-(void)setMenmber:(MenmberModel *)menmber{
    _menmber=menmber;
    self.nickNameLable.text=menmber.nickname;
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=@"yyy/dd/MM";
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:menmber.reg_time.doubleValue];
    self.timeLable.text= [formatter stringFromDate:date];
   // self.timeLable.text=menmber
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
