//
//  CustomerCenterViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/20.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "CustomerCenterViewController.h"
#import "TeamViewController.h"
#import "PerformanceViewController.h"
#import <UShareUI/UShareUI.h>
@interface CustomerCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray  *dataSoure;
@end

@implementation CustomerCenterViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
    return _tableView;
}
-(NSArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSArray alloc]init];
        _dataSoure=@[@"我的业绩",@"我的团队",@"分享邀请"];
    }
    return _dataSoure;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"消费商中心";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma mark -----UITableView----

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text=self.dataSoure[indexPath.item];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.item) {
        case 0:
        {
            PerformanceViewController *performanceC=[[PerformanceViewController alloc]init];
            [self.navigationController pushViewController:performanceC animated:YES];
        }
            break;
        case 1:
        {
            TeamViewController *teamC=[[TeamViewController alloc]init];
            [self.navigationController pushViewController:teamC animated:YES];
        }
            break;
        case 2:
        {
            MYLog(@"分享");
            [self shareAction];
        }
            break;
            
        default:
            break;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
//分享
-(void)shareAction{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareTextToPlatformType:platformType];
    }];
}
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}
@end
