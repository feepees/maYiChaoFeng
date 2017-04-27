//
//  GoodsCommentTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "GoodsCommentTableViewCell.h"
@interface GoodsCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *commentCountLable;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UIButton *lavelButton;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end
@implementation GoodsCommentTableViewCell


- (IBAction)seeAllCommentActioin:(id)sender {
    self.seeAllComment();
}
-(void)setModel:(CommentModel *)model{
    _model=model;
    [self.headView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.user_head]] placeholderImage:[UIImage imageNamed:@"mrtx_y"]];
    self.userNameLable.text=model.username;
    self.commentContentLable.text=model.content;
    self.timeLable.text=model.add_time;
    
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
