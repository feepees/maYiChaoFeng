//
//  VIPGardeViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/28.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//  会员等级

#import "VIPGardeViewController.h"
#import "VIPGardenHeadView.h"
@interface VIPGardeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@end

@implementation VIPGardeViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"会员等级";
    }
    return self;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        VIPGardenHeadView *headView=[[NSBundle mainBundle] loadNibNamed:@"VIPGardenHeadView" owner:nil options:nil].lastObject;
        headView.frame=CGRectMake(0, 0, screenWidth, 250);
        _tableView.tableHeaderView=headView;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text=@"当前等级特权";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"当前等级特权";
}

@end
