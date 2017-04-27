//
//  LXHeadView.h
//  maYiChaoFeng
//
//  Created by Android on 2017/2/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^LXHeadViewBlock)(NSInteger selectImageIndex);

@interface LXHeadView : UIView

@property(nonatomic,strong) NSArray *dataArray;

+(instancetype)shareLXHeadViewWithUrlArray:(NSArray *)urlArray;

@property(nonatomic,strong) LXHeadViewBlock HeadViewBlock;

@end
