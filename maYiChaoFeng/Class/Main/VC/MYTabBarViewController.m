//
//  MYTabBarViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "MYTabBarViewController.h"
#import "LeXiangTableViewController.h"
#import "LeDaoTableViewController.h"
#import "WMPageController.h"
#import "VideoListCollectionViewController.h"
#import "MYNavigationViewController.h"
#import "LeXueViewController.h"

@interface MYTabBarViewController ()

@end

@implementation MYTabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self confingTabBar];
}
-(void)confingTabBar{

        //乐学
    LeXueViewController *lexueC=[[LeXueViewController alloc]init];
    MYNavigationViewController *lexueNav=[[MYNavigationViewController alloc]initWithRootViewController:lexueC];
    lexueC.title=@"乐学";
    UIImageView *titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dhl_bj_logo"]];
    [titleView sizeToFit];
    lexueC.navigationItem.titleView=titleView;
    
    lexueC.tabBarItem.image=[UIImage imageNamed:@"cdl_lxue"];
    [lexueC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR)} forState:UIControlStateNormal];
    [lexueC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR_SELECTED)} forState:UIControlStateSelected];
        /*
        Class pc = [VideoListCollectionViewController class];
        Class vc = [VideoListCollectionViewController class];
        NSArray *VCArray = [NSArray arrayWithObjects:pc,vc, nil];
        NSArray *titleArray = [NSArray arrayWithObjects:@"蚁城",@"凤巢", nil];
    
            //用上面两个数组初始化WMPageController对象
        WMPageController *pageController = [[WMPageController alloc] initWithViewControllerClasses:VCArray andTheirTitles:titleArray];
        pageController.menuViewStyle = WMMenuViewStyleLine;
        pageController.titleColorSelected = [UIColor whiteColor];
        pageController.titleColorNormal = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
        pageController.progressColor = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
        //    pageController.itemsWidths = @[@(70),@(100),@(70)]; // 这里可以设置不同的宽度
    
        //设置WMPageController每个标题的宽度
        pageController.menuItemWidth = 375/3;
        //设置WMPageController标题栏的高度
        pageController.menuHeight = 45;
        //设置WMPageController选中的标题的颜色
        pageController.titleColorSelected = [UIColor colorWithRed:200/255.0 green:0 blue:0 alpha:1];
    
        pageController.title=@"乐学";
        UIImageView *titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dhl_bj_logo"]];
        [titleView sizeToFit];
        pageController.navigationItem.titleView=titleView;
    
        pageController.tabBarItem.image=[UIImage imageNamed:@"cdl_lxue"];
        [pageController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR)} forState:UIControlStateNormal];
        [pageController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR_SELECTED)} forState:UIControlStateSelected];
    
    
        MYNavigationViewController *pageNav=[[MYNavigationViewController alloc]initWithRootViewController:pageController];
         */
        //乐享
    
        //VideoListCollectionViewController *videoC=[[VideoListCollectionViewController alloc]init];
    
    LeXiangTableViewController *videoC=[[LeXiangTableViewController alloc]init];
    
    videoC.titleName=@"乐享";
    videoC.title=@"乐享";
    videoC.tabBarItem.image=[UIImage imageNamed:@"cdl_lxiang"];
    UIImageView *LXtitleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dhl_bj_logo"]];
    [LXtitleView sizeToFit];
    videoC.navigationItem.titleView=LXtitleView;
        [videoC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR)} forState:UIControlStateNormal];
        [videoC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR_SELECTED)} forState:UIControlStateSelected];
    
    
        MYNavigationViewController *videoNav=[[MYNavigationViewController alloc]initWithRootViewController:videoC];
    
    
        //乐道
    
        LeDaoTableViewController *ledaoC=[[LeDaoTableViewController alloc]init];
        ledaoC.title=@"乐道";
        ledaoC.tabBarItem.image=[UIImage imageNamed:@"cdl_ld"];
        [ledaoC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR)} forState:UIControlStateNormal];
        [ledaoC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR_SELECTED)} forState:UIControlStateSelected];
        MYNavigationViewController *ledaonNav=[[MYNavigationViewController alloc]initWithRootViewController:ledaoC];
        ledaoC.view.backgroundColor=UIColorFromRGB(TABBAR_ITEM_COLOR);
    
        self.viewControllers=@[lexueNav,videoNav,ledaonNav];
        


}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}



@end
