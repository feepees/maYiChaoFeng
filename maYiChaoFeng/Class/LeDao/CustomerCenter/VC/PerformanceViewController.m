//
//  PerformanceViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/27.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "PerformanceViewController.h"
#import "UserModel.h"
#import "OrderTableViewCell.h"
#import "OrderModel.h"
@interface PerformanceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;

@end

@implementation PerformanceViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
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
        self.title=@"我的业绩";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self getData];
}

-(void)getData{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    
    parameter[@"user_id"]=[UserModel sharedUserModel].user_id;
    parameter[@"page"]=@"1";
    parameter[@"page_size"]=@"20";
    MYLog(@"业绩信息API：%@参数：%@",Performance,parameter);
    [MJHttpTool Post:Performance parameters:parameter success:^(id responseObject) {
        MYLog(@"我的业绩返回数据：%@",responseObject);
      self.dataSoure=  [OrderModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        MYLog(@"我的业绩错误：%@",error);
    }];
}

#pragma mark ----------UITableViewDelegate-----------


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSoure.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    OrderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.model=self.dataSoure[indexPath.item];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(Pading, 10, 100, 20)];
    lable.text=@"我的业绩";
    [view addSubview:lable];
    
    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(screenWidth-100-Pading, 10, 100, 20)];
    lable1.text=[NSString stringWithFormat:@"共%ld单",self.dataSoure.count];
    [view addSubview:lable1];
    return view;
}


@end
