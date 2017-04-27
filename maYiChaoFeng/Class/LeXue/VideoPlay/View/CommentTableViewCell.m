//
//  CommentTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "CommentTableViewCell.h"
@interface CommentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;


@end
@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(CommentModel *)model{
    _model=model;
    [self.headImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.user_head]]];
    self.nickNameLable.text=model.username;
    self.contentLable.text=model.content;
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyy-MM-dd";
    NSDate *data=[NSDate dateWithTimeIntervalSince1970:model.add_time.doubleValue];
    
    self.timeLable.text=[formatter stringFromDate:data];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
