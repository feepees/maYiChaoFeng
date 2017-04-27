//
//  HelpCenterViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/23.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "CommenTableViewCell.h"
#import "HelpArticleModel.h"
#import "HelpDetailViewController.h"
@interface HelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<NSArray*> *dataSoure;
@end

@implementation HelpCenterViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"帮助中心";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self getData];
}

-(NSMutableArray<NSArray *> *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
        
    }
    return _dataSoure;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 75)];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(Pading, 15, screenWidth-Pading*2, 45)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"dlzc_srk_bj"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(getMore:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"没解决您的问题，查看更多联系方式" forState:UIControlStateNormal];
        [view addSubview:button];
        _tableView.tableFooterView=view;
        
        
    }
    return _tableView;
}
-(void)getData{
    
[MJHttpTool Post:HelpCenter parameters:nil success:^(id responseObject) {
    MYLog(@"帮助中心返回：%@",responseObject);
    NSArray *hotArr=[HelpArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"hot"]];
    NSArray *ptArr=[HelpArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"pt"]];
    [self.dataSoure addObject:hotArr];
    [self.dataSoure addObject:ptArr];
    [self.tableView reloadData];
} failure:^(NSError *error) {
    MYLog(@"帮助中心错误%@",error);
}];
}
-(void)getMore:(UIButton *)sender{

}
#pragma mark ----------------tableViewDelefate-----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSoure.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSoure[section].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    HelpArticleModel *model=self.dataSoure[indexPath.section][indexPath.item];
    cell.textLabel.text=model.a_title;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return @"热门问题";
    }
    else{
        return @"全部问题";
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpDetailViewController *helpDetail=[[HelpDetailViewController alloc]init];
     HelpArticleModel *model=self.dataSoure[indexPath.section][indexPath.item];
    helpDetail.url=[NSString stringWithFormat:@"%@/mobile/index/details/id/%ld.html",Host1,model.a_id.integerValue];
    [self.navigationController pushViewController:helpDetail animated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

@end
