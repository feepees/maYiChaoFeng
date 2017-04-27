//
//  VIPGardenHeadView.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/12.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "VIPGardenHeadView.h"
@interface VIPGardenHeadView()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *BGHeadView;
@property (weak, nonatomic) IBOutlet UIImageView *cur_icon;
@property (weak, nonatomic) IBOutlet UIImageView *pre_icon;
@property (weak, nonatomic) IBOutlet UIImageView *next_icon;
@property (weak, nonatomic) IBOutlet UIImageView *line_icon;
@property (weak, nonatomic) IBOutlet UILabel *pre_lable;
@property (weak, nonatomic) IBOutlet UILabel *cur_lable;
@property (weak, nonatomic) IBOutlet UILabel *next_lable;
@property (weak, nonatomic) IBOutlet UILabel *nextLable;

@end
@implementation VIPGardenHeadView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUpUI];
}
-(void)setUpUI{
    
    UserModel *model=[UserModel sharedUserModel];
    if (model) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectMake(0, 0, self.BGHeadView.frame.size.width, self.BGHeadView.frame.size.height);
        [self.BGHeadView addSubview:effectView];
        [self.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.head_pic]] placeholderImage:[UIImage imageNamed:@"mrtx_f"]];
        [self.BGHeadView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.head_pic]] placeholderImage:[UIImage imageNamed:@"mrtx_f"]];
    
    }


}



@end
