//
//  VideoListCollectionViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/20.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "VideoListCollectionViewCell.h"
@interface VideoListCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *playerCount;
@property (weak, nonatomic) IBOutlet UIImageView *headVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property (weak, nonatomic) IBOutlet UILabel *shareLable;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
@property (weak, nonatomic) IBOutlet UILabel *likeLable;
@end
@implementation VideoListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(ArticleModel *)model{
    _model=model;
    
    [self.headVIew setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Host1,model.a_pic]] placeholderImage:[UIImage imageNamed:@"banner"]];
    self.playerCount.text=[NSString stringWithFormat:@"播放次数:%@",model.clicknum];
    self.titleLable.text=model.a_title;
    self.detailLable.text=model.desc;
    self.shareLable.text=model.sharenum;
    self.commentLable.text=model.commentnum;
    self.likeLable.text=model.zannum;
}
@end
