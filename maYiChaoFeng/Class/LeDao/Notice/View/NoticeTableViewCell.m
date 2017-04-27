//
//  NoticeTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/29.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "NoticeTableViewCell.h"
@interface NoticeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *noticeTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *noticeTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *noticeDetailLable;
@end
@implementation NoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(ArticleModel *)model{
    _model=model;
    self.nameLable.text=model.a_title;
    self.noticeTitleLable.text=model.a_content;
        self.noticeTimeLable.text=model.updatetime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
