//
//  LeDaoTableViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "LeDaoTableViewController.h"
#import "LeDaoHeadView.h"
#import "LeDaoCellModel.h"
#import "PersoncCllectionViewController.h"
#import "ProductColllectionTableViewController.h"
#import "VideoCollectionTableViewController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "HelpCenterViewController.h"
#import "NoticeViewController.h"
#import "WMPageController.h"
#import "RankListViewController.h"
#import "CustomerCenterViewController.h"
#import "PersonMessageViewController.h"
#import "WalletViewController.h"
#import "RankingTabViewController.h"
#import "MyOrderViewController.h"
#import "PurchaseCarViewController.h"
@interface LeDaoTableViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation LeDaoTableViewController

-(NSMutableArray *)dataArray{

    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
  
        NSMutableArray *lastSection = [NSMutableArray array];

        
        NSMutableArray *secondTitle = [NSMutableArray arrayWithObjects:@"公告",@"帮助中心",@"关于我们",@"设置", nil];
        NSMutableArray *secondimageName = [NSMutableArray arrayWithObjects:@"hy_gg_icon",@"hy_bzzx_icon",@"hy_gy_icon",@"hy_sz_icon", nil];

        for (int i = 0; i< secondTitle.count; i++) {
            
            LeDaoCellModel *sectionModel = [[LeDaoCellModel  alloc]init];

            sectionModel.title = secondTitle[i];
            sectionModel.cellImage = secondimageName[i]
            ;
            
            [lastSection addObject:sectionModel];
     
        }
        [_dataArray addObject:lastSection];
    }
    
    return _dataArray;

}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, screenWidth, screenHeight) style:UITableViewStyleGrouped];
        _tableView.contentInset=UIEdgeInsetsMake(0, 0, 69, 0);
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets=NO;
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    lable.textColor=[UIColor whiteColor];
    lable.font=[UIFont systemFontOfSize:18];
    lable.text=self.title;
    lable.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=lable;

    LeDaoHeadView *headView = [[NSBundle mainBundle]loadNibNamed:@"LeDaoHeadView" owner:nil options:nil].lastObject;
    headView.frame = CGRectMake(0, 0, screenWidth, 450);
    headView.businessActions=^(int index){
        [self businessActionWithTag:index];
    };
    headView.profileCenter=^{
        WalletViewController *walletC=[[WalletViewController alloc]init];
        [self.navigationController pushViewController:walletC animated:YES];
    };
    headView.walletCenter=^{
        PersonMessageViewController *personC=[[PersonMessageViewController alloc]init];
        [self.navigationController pushViewController:personC animated:YES];
    };
    headView.user=[NSKeyedUnarchiver unarchiveObjectWithFile:UserData];
    self.tableView.tableHeaderView = headView;
    
}

-(void)businessActionWithTag:(NSInteger )tag{

    switch (tag) {
        case 0:
        {
            CustomerCenterViewController *customC=[[CustomerCenterViewController alloc]init];
            [self.navigationController pushViewController:customC animated:YES];
        }
            break;
        case 1:{
            RankingTabViewController *rankC=[[RankingTabViewController alloc]init];
            [self.navigationController pushViewController:rankC animated:YES];
            return;
           /*             //用上面两个数组初始化WMPageController对象
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
            
            pageController.title=@"排行榜";
            
            pageController.tabBarItem.image=[UIImage imageNamed:@"cdl_lxue"];
            [pageController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR)} forState:UIControlStateNormal];
            [pageController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(TABBAR_ITEM_COLOR_SELECTED)} forState:UIControlStateSelected];
            [self.navigationController pushViewController:pageController animated:YES];*/
        }
            break;
        case 2:
        {
            PurchaseCarViewController *purchaseC=[[PurchaseCarViewController alloc]init];
            [self.navigationController pushViewController: purchaseC animated:YES
             ];
        }
            break;
        case 3:
        {
            MyOrderViewController *orderC=[[MyOrderViewController alloc]init];
            [self.navigationController pushViewController:orderC animated:YES];
        }
            break;
        default:
            break;
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"feepees"];
    NSMutableArray *array = self.dataArray[indexPath.section];
    
    LeDaoCellModel *model = array[indexPath.row];
    cell.textLabel.text = model.title;
    cell.imageView.image = [UIImage imageNamed:model.cellImage];
        
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

        return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //单独设置某一section的高度
    
    
    return 20;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];


    if (indexPath.section == -1 && indexPath.row == 0) {
       
      Class pc = [ProductColllectionTableViewController class];
        Class vc = [VideoCollectionTableViewController class];
        NSArray *VCArray = [NSArray arrayWithObjects:pc,vc, nil];
        NSArray *titleArray = [NSArray arrayWithObjects:@"产品",@"视频", nil];
        
        PersoncCllectionViewController *personcCllection = [[PersoncCllectionViewController alloc]initWithViewControllerClasses:VCArray andTheirTitles:titleArray];
        personcCllection.menuItemWidth = 85;
        personcCllection.postNotification = YES;
        personcCllection.bounces = YES;
        personcCllection.hidesBottomBarWhenPushed = YES;
        personcCllection.selectIndex = 0;
        personcCllection.menuViewStyle = WMMenuViewStyleLine;
        [self.navigationController pushViewController:personcCllection animated:YES];
            }
    else if(indexPath.section == 0 && indexPath.row == 0){
        NoticeViewController *notiC=[[NoticeViewController alloc]init];
        [self.navigationController pushViewController:notiC animated:YES];
    }
    else if(indexPath.section == 0 && indexPath.row == 1){
        HelpCenterViewController *helpC=[[HelpCenterViewController alloc]init];
        [self.navigationController pushViewController:helpC animated:YES];
    }
    else if(indexPath.section == 0 && indexPath.row == 2){
        AboutUsViewController *aboutC=[[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutC animated:YES];       }
    
    else
        {
            SettingViewController *vc=[[SettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
    
        }
}

@end
