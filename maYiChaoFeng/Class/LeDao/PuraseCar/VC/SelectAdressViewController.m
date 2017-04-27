//
//  SelectAdressViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "SelectAdressViewController.h"
#import "SelectAdressTableViewCell.h"
#import "ManagerAddressViewController.h"
#import "AddressModel.h"
@interface SelectAdressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@end

@implementation SelectAdressViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"选择收货地址";
    }
    return self;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerNib:[UINib nibWithNibName:@"SelectAdressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setRightItem];
    [self getAddresData];
    
}
-(void)getAddresData{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    [MJHttpTool Post:GetAllAddress parameters:parameter success:^(id responseObject) {
        MYLog(@"获取全部地址返回：%@",responseObject);
        self.dataSoure=[AddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        MYLog(@"获取全部地址错误%@",error);
    }];
}
-(void)setRightItem{
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    [rightBtn addTarget:self action:@selector(managerAddress:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"管理" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
}
-(void)managerAddress:(UIButton *)sender{
    ManagerAddressViewController *managerC=[[ManagerAddressViewController alloc]init];
    [self.navigationController pushViewController:managerC animated:YES];
}
#pragma mark -------------UITableViewDelegate--------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    SelectAdressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.model=self.dataSoure[indexPath.section];
    if(indexPath.section==0){
        UILabel *defaultLable=[[UILabel alloc]initWithFrame:CGRectMake(15, 80, 100, 20)];
        defaultLable.text=@"(默认地址)";
        defaultLable.textColor=[UIColor redColor];
        [cell.contentView addSubview:defaultLable];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 118;
    }
    return 88;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.returnAddress(self.dataSoure[indexPath.section]);
    [self.navigationController popViewControllerAnimated:YES];
}
@end
