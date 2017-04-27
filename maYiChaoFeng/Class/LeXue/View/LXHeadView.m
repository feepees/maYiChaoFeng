//
//  LXHeadView.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "LXHeadView.h"
#import "SDCycleScrollView.h"

@interface LXHeadView ()<SDCycleScrollViewDelegate>


@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property(nonatomic,strong) NSMutableArray *urlArray;
@end

@implementation LXHeadView


-(void)setDataArray:(NSArray *)dataArray{
    
    _cycleScrollView.imageURLStringsGroup = dataArray;
}



-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
//        self.frame = CGRectMake(0, 0, screenWidth, 195);
        // 网络加载 --- 创建带标题的图片轮播器
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.currentPageDotColor = UIColorFromRGB(0x9fd056);
        _cycleScrollView.delegate = self;
        
        _cycleScrollView.pageDotColor = UIColorFromRGB(0xffffff);
        [_cycleScrollView setPageControlAliment:SDCycleScrollViewPageContolAlimentCenter];
        [self addSubview:_cycleScrollView];
        
    }
    
    return self;
    

}

+(instancetype)shareLXHeadViewWithUrlArray:(NSArray *)urlArray{
    
    return [[self alloc]init];
    

}


#pragma mark -SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    self.HeadViewBlock(index);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
