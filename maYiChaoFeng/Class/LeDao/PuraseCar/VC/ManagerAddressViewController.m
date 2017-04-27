//
//  ManagerAddressViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "ManagerAddressViewController.h"
#import "DeliverAddressTableViewCell.h"
#import "AddNewAddressViewController.h"
#import "UserModel.h"
#import "AddressModel.h"
#import "MYAlertVIew.h"
@interface ManagerAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@end

@implementation ManagerAddressViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.contentInset=UIEdgeInsetsMake(0, 0, 50, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"DeliverAddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
        
    }
    return _dataSoure;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"收货地址管理";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    UIButton *addNewAddress=[[UIButton alloc]initWithFrame:CGRectMake(0, screenHeight-114, screenWidth, 50)];
    
    [addNewAddress setTitle:@"新加收货地址" forState:UIControlStateNormal];
    [addNewAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addNewAddress addTarget:self action:@selector(addNewAddressAction) forControlEvents:UIControlEventTouchUpInside];
    addNewAddress.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:addNewAddress];
    
    [self getData];
    
}
-(void)getData{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    MYLog(@"获取全部地址:%@参数:%@",GetAllAddress,parameter);
[MJHttpTool Post:GetAllAddress parameters:parameter success:^(id responseObject) {
    MYLog(@"获取全部寄送地址%@",responseObject);
    self.dataSoure=[AddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
    [self.tableView reloadData];
} failure:^(NSError *error) {
    MYLog(@"获取全部寄送地址错误%@",error);
}];
}

-(void)addNewAddressAction{
    AddNewAddressViewController *newC=[[AddNewAddressViewController alloc]init];
    [self.navigationController pushViewController:newC animated:YES];
}
-(void)deleteAddressWithModel:(AddressModel *)model{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"user_id"]=model.user_id;
    parameter[@"id"]=model.Id;
[MJHttpTool Post:DeleteAddress parameters:parameter success:^(id responseObject) {
    MYLog(@"删除地址返回%@",responseObject);
    if ([responseObject[@"code"] isEqualToString:@"0000"]) {
        [self getData];
        [YJProgressHUD showSuccess:@"删除成功" inview:self.view];
    }
} failure:^(NSError *error) {
    MYLog(@"删除地址错误%@",error);
    [YJProgressHUD showMessage:@"删除失败" inView:self.view];
}];
}
#define mark -----------------UITableViewDelegate----------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    DeliverAddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.deleteAction=^(AddressModel *model){
    MYAlertVIew *lert=    [MYAlertVIew showToView:self.view withTitle:@"确认删除该地址？"];
        lert.comfirmActiom=^{
        [self deleteAddressWithModel:model];
        };
        lert.cancelAction=^{
        };
      
    };
    cell.editorAction=^(AddressModel *model){
        AddNewAddressViewController *newC=[[AddNewAddressViewController alloc]init];
        newC.model=model;
        [self.navigationController pushViewController:newC animated:YES];
    
    };
    cell.model=self.dataSoure[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
@end
