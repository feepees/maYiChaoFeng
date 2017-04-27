//
//  CommentHeadView.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "CommentHeadView.h"
#import "UserModel.h"
#include "NSString+InputCheck.h"
@interface CommentHeadView()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titileNameLable;
@property (weak, nonatomic) IBOutlet UILabel *palyCount;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *articleDetail;
@property (weak, nonatomic) IBOutlet UILabel *placeholdeer;

@end
@implementation CommentHeadView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.commentTextView.delegate=self;
    
}
//发送评论
- (IBAction)sendAction:(id)sender {
    self.sendAction(self.commentTextView.text);
}
//显示简介
- (IBAction)unfoldDetailAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    btn.selected=!btn.selected;
    if (btn.selected) {
        CGRect rect=[self.model.a_content calculateHeightWithFont:[UIFont systemFontOfSize:17] labelWidth:screenWidth-30];
        self.detailHegit.constant=rect.size.height;
        self.unfold(rect.size.height);

    }
    else{
        self.detailHegit.constant=0;
         self.unfold(0);
    }
    
}

//分享
- (IBAction)shareAction:(id)sender {
    self.shareAction();
}
//重写set方法
-(void)setModel:(ArticleModel *)model{
    _model=model;
    self.titileNameLable.text=model.a_title;
    self.palyCount.text=[NSString stringWithFormat:@"播放次数%@",model.clicknum];
    [self.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,[UserModel sharedUserModel].head_pic]]];
    self.articleDetail.text=model.a_content;
}
#pragma mark ------------------textviewDelegate-----------
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{    if (![text isEqualToString:@""])
    
{
    
    self.placeholdeer.hidden = YES;
    
}
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        
        self.placeholdeer.hidden = NO;
        
    }
    
    return YES;
    
}
@end
