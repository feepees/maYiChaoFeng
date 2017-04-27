//
//  MYNavigationViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "MYNavigationViewController.h"

@interface MYNavigationViewController ()

@end

@implementation MYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"dhl_bj"] forBarMetrics:UIBarMetricsDefault];
}



- (void)backBarButtonItemAction
{
    [self popViewControllerAnimated:YES];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
    if  (!(viewController == self.viewControllers[0])) {
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
        lable.textColor=[UIColor whiteColor];
        lable.font=[UIFont systemFontOfSize:18];
        lable.text=viewController.title;
        lable.textAlignment=NSTextAlignmentCenter;
        viewController.navigationItem.titleView=lable;
        
        UIButton *backBtn=[[UIButton alloc]init];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"dhl_jt_icon"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        [backBtn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
        self.tabBarController.tabBar.hidden=YES;
    }
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
   UIViewController *vic= [super popViewControllerAnimated:animated];
    if  (self.childViewControllers.count==1) {
        self.tabBarController.tabBar.hidden=NO;;
    }
    return vic;
}


@end
