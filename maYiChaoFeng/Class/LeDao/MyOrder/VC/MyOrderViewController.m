//
//  MyOrderViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "MyOrderViewController.h"
#import "RankListViewController.h"
#import "WaitPyViewController.h"
#import "WaitDispachViewController.h"
#import "WaitRecevingViewController.h"
#import "WaitEvallluatViewController.h"
#import "OrderDoneViewController.h"

@interface MyOrderViewController ()
@property(nonatomic,strong)NSArray *titleData;
@end

@implementation MyOrderViewController

-(NSArray *)titleData{
    if (!_titleData) {
        _titleData = [[NSArray alloc]initWithObjects:@"待付款",@"待发货",@"待收获",@"待评价",@"已完成 ",nil];
        
    }
    return _titleData;
}
//
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"我的订单";
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
            
            WaitPyViewController   *vcClass = [[WaitPyViewController alloc] init];
            vcClass.title = @"日榜";
            
            return vcClass;
        }
            
            break;
        case 1:{
            
            WaitDispachViewController *vcClass = [WaitDispachViewController new];
            vcClass.title = @"周榜";
            return vcClass;
            
        }
            break;
        case 2:{
            
            WaitRecevingViewController *vcClass = [WaitRecevingViewController new];
            vcClass.title = @"月榜";
            return vcClass;
            
        }
            break;
        case 3:{
            
            WaitEvallluatViewController *vcClass = [WaitEvallluatViewController new];
            vcClass.title = @"月榜";
            return vcClass;
            
        }
            break;
        case 4:{
            
            OrderDoneViewController *vcClass = [OrderDoneViewController new];
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
