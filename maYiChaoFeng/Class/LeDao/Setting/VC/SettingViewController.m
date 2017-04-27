//
//  SettingViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "SettingViewController.h"
#import "PersonMessageViewController.h"
#import "CommenTableViewCell.h"
#import "MYAlertVIew.h"
#import "ForgetPaasworldViewController.h"
#import "LoginViewController.h"
#import "MYNavigationViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation SettingViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"设置";
    }
    return self;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        [_tableView registerNib:[UINib nibWithNibName:@"CommenTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]initWithArray:@[@[@"个人资料",@"修改密码",@"清楚存储空间",@"当前版本"],@[@"退出"]]];
        
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

#pragma --------UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array=self.dataSource[section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId=@"cellId";
    
    CommenTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (indexPath.section==0&&indexPath.item==2) {
        cell.footLable.text=[NSString stringWithFormat:@"%lldM",[self caculatCacheMemory]];

    }
    else if (indexPath.section==0&&indexPath.item==3){
        cell.footLable.text=@"1.0.1";
    }
    cell.headLable.text=self.dataSource[indexPath.section][indexPath.item];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.item==0) {
        PersonMessageViewController *personC=[[PersonMessageViewController alloc]init];
        [self.navigationController pushViewController:personC animated:YES];
    }
    else if(indexPath.section==0&&indexPath.item==1){
        ForgetPaasworldViewController *forgetC=[[ForgetPaasworldViewController alloc]init];
        [self.navigationController pushViewController:forgetC animated:YES];
    
    }
    else if(indexPath.section==0&&indexPath.item==2){
        
   MYAlertVIew *alertView=[MYAlertVIew showToView:self.view withTitle:@"确认清楚缓存?"];
        alertView.comfirmActiom=^{
            [self removeCacheMemory];
            [self.tableView reloadData];
        };
        alertView.cancelAction=^{
            
        };
    }
    else if(indexPath.section==0&&indexPath.item==3){
        
        
    }
    else if (indexPath.section==1 && indexPath.item==0){
        MYAlertVIew *alertView=[MYAlertVIew showToView:self.view withTitle:@"确认退出"];
        alertView.comfirmActiom=^{
            LoginViewController *loginC=[[LoginViewController alloc]init];
            MYNavigationViewController *nav=[[MYNavigationViewController alloc]initWithRootViewController:loginC];
            [self presentViewController:nav animated:YES completion:nil];
            NSLog(@"确认退出");
        };
        alertView.cancelAction=^{
            NSLog(@"取消");
        };
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

//清除缓存数据
-(void)removeCacheMemory{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    for ( NSString * p in files) {
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    
    //读取缓存大小
    //float cacheSize = [self caculatCacheMemory] *1024;

}
//清楚缓存
-(long long)caculatCacheMemory{
    
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSFileManager *manager=[NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:cachePath]) {
        return 0;
    }
    NSEnumerator *childFileEnumerater=[[manager subpathsAtPath:cachePath] objectEnumerator];
    NSString *fileName;
    long long foderSize=0;
    
    while ((fileName=[childFileEnumerater nextObject])!=nil) {
        NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
        if ([manager fileExistsAtPath:fileAbsolutePath]) {
        foderSize += [[manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
        }
    }
    
    return foderSize/(1024.0*1024.0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
