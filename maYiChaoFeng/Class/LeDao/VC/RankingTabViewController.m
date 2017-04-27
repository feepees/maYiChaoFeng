//
//  RankingTabViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/27.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "RankingTabViewController.h"
#import "RankListViewController.h"
@interface RankingTabViewController ()
@property(nonatomic,strong)NSArray *titleData;
@end

@implementation RankingTabViewController
-(NSArray *)titleData{
    if (!_titleData) {
        _titleData = [[NSArray alloc]initWithObjects:@"日榜",@"周榜",@"月榜",nil];
        
    }
    return _titleData;
}
//
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"排行榜";
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
        self.menuHeight = 50;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark ------WMPageViewcontroller----------------
-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titleData.count;
}

-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            
            RankListViewController   *vcClass = [[RankListViewController alloc] init];
            vcClass.title = @"日榜";
            
            return vcClass;
        }
            
            break;
        case 1:{
            
            RankListViewController *vcClass = [RankListViewController new];
            vcClass.title = @"周榜";
            return vcClass;
            
        }
            break;
        case 2:{
            
            RankListViewController *vcClass = [RankListViewController new];
            vcClass.title = @"月榜";
            return vcClass;
            
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.titleData[index];
}

@end
