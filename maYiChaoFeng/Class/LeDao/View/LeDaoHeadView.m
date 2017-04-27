//
//  LeDaoHeadView.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/22.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "LeDaoHeadView.h"
@interface LeDaoHeadView()


@property (weak, nonatomic) IBOutlet UIView *CustomerView;
@property (weak, nonatomic) IBOutlet UIView *rankingList;
@property (weak, nonatomic) IBOutlet UIView *helpCenterView;
@property (weak, nonatomic) IBOutlet UIView *noticeView;

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UILabel *levelLable;
@property (weak, nonatomic) IBOutlet UILabel *earningsLable;
@property (weak, nonatomic) IBOutlet UILabel *unwithdrawLable;

@end
@implementation LeDaoHeadView


-(void)setUpUI{
    
    [self addTapAction:self.CustomerView andTag:0];
    [self addTapAction:self.rankingList andTag:1];
    [self addTapAction:self.noticeView andTag:2];
    [self addTapAction:self.helpCenterView andTag:3];
    

}
-(void)addTapAction:(UIView *)view andTag:(NSInteger )tag{
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    view.tag=tag;
    view.userInteractionEnabled=YES;
    [view addGestureRecognizer:tap];
}
-(void)layoutSubviews{
    [self setUpUI];
}
-(void)tapAction:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 0:
            self.businessActions(0);
            break;
        case 1:
            self.businessActions(1);
            break;
        case 2:
            self.businessActions(2);
            break;
        case 3:
            self.businessActions(3);
            break;
            
        default:
            break;
    }
}
- (IBAction)porfileCenter:(id)sender {
    self.profileCenter();
}
- (IBAction)walletAction:(id)sender {
    self.walletCenter();
}
-(void)setUser:(UserModel *)user{
    _user=user;
    if(user.nickname){
        self.nickNameLable.text=user.nickname;
    }
    if(user.head_pic)
    {
        [self.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,user.head_pic]] placeholderImage:[UIImage imageNamed:@"mrtx_f"]];
    }
    if (user.distribut_money) {
        self.earningsLable.text=user.distribut_money;
    }
    self.unwithdrawLable.text=user.user_money;

}


@end
