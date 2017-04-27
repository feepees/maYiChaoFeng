//
//  AboutUsViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//  关于我们

#import "AboutUsViewController.h"
#import "CompanyIntroductionViewController.h"
#import "HotLineViewController.h"
#import "MYAlertVIew.h"

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataSoure;
@property(nonatomic,copy)NSString *AboutUs;
@property(nonatomic,copy)NSString *hotLine;
@end

@implementation AboutUsViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"关于我们";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self getDataWithTitle:@"公司介绍"];
    [self getDataWithTitle:@"客服热线"];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        _tableView.dataSource=self;
        _tableView.delegate=self;
    }
    return _tableView;
}
-(NSArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSArray alloc]init];
        _dataSoure=@[@[@"公司介绍",@"客服热线"],@[@"去评分"]];
    }
    return _dataSoure;
}
-(void)getDataWithTitle:(NSString *)title{
    NSMutableDictionary *paremeter=[NSMutableDictionary dictionary];
    paremeter[@"name"]=title;
    [MJHttpTool Post:GetUserArticle parameters:paremeter success:^(id responseObject) {
        MYLog(@"获取用户文章：%@",responseObject);
        if ([title isEqualToString:@"客服热线"]) {
            self.hotLine=[NSString stringWithFormat:@"%@%@",Host1,responseObject[@"data"]];
        }
        else{
        self.AboutUs=[NSString stringWithFormat:@"%@%@",Host1,responseObject[@"data"]];
        }
        
    } failure:^(NSError *error) {
        MYLog(@"获取文章错误%@",error);
    }];
}
#  pragma -------UITableViewDelegate----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSoure.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array=self.dataSoure[section];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text=self.dataSoure[indexPath.section][indexPath.item];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.item==0) {
        CompanyIntroductionViewController *commanyC=[[CompanyIntroductionViewController alloc]init];
        commanyC.url=self.AboutUs;
        [self.navigationController pushViewController:commanyC animated:YES];
    }
    else if (indexPath.section==0&&indexPath.item==1){
        HotLineViewController *hotLineC=[[HotLineViewController alloc]init];
        hotLineC.url=self.hotLine;
        [self.navigationController pushViewController:hotLineC animated:YES];
    }
    else{
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
