//
//  LeXueViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/27.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "LeXueViewController.h"
#import "VideoListCollectionViewController.h"
#import "SearchViewController.h"
@interface LeXueViewController ()
@property(nonatomic,strong)NSArray *titleData;
@end

@implementation LeXueViewController
-(NSArray *)titleData{
    if (!_titleData) {
        _titleData = [[NSArray alloc]initWithObjects:@"免费视频",@"蚁城",@"凤巢", nil];
        
    }
    return _titleData;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 15;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
        self.menuHeight = 50;
    }
    return self;
}
#pragma mark ---------------WMPageViewController----------------

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titleData.count;
}
-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            
            VideoListCollectionViewController   *vcClass = [[VideoListCollectionViewController alloc] init];
            vcClass.titleName = @"免费视频";
            
            return vcClass;
        }
            
            break;
        case 1:{
            
            VideoListCollectionViewController   *vcClass = [[VideoListCollectionViewController alloc] init];
            vcClass.titleName = @"蚁城";
            
            return vcClass;
        }
            
            break;

        case 2:{
            
            VideoListCollectionViewController *vcClass = [[VideoListCollectionViewController alloc]init];
            vcClass.titleName = @"凤巢";
            return vcClass;
            
        }
            break;
            
            
        default:
    
            return nil;
            break;
    }
}
-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
   return self.titleData[index];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *lefrBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    [lefrBtn addTarget:self action:@selector(seacherAction:) forControlEvents:UIControlEventTouchUpInside];
    [lefrBtn setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:lefrBtn];
    
}
-(void)seacherAction:(UIButton *)sender{
    SearchViewController *searchC=[[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchC animated:YES];
}
@end
