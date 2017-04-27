//
//  GoodSCommentViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/17.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "GoodSCommentViewController.h"
#import "CommentTableViewCell.h"
@interface GoodSCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSoure;
@end

@implementation GoodSCommentViewController
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        
    }
    return _tableView;
}
-(NSMutableArray *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
        
    }
    return _dataSoure;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"全部评论";
    [self.view addSubview:self.tableView];
    [self getData];
}
-(void)getData{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"a_id"]=self.goodsId;
    parameter[@"page"]=@"0";
    parameter[@"page_size"]=@"10";
    [MJHttpTool Post:GoodDetail parameters:parameter success:^(id responseObject) {
        MYLog(@"商品详情返回:%@",responseObject);
        
        self.dataSoure=[CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"comment"]];
        [self.tableView reloadData];
            } failure:^(NSError *error) {
        MYLog(@"商品详情错误%@",error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    CommentTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.model=self.dataSoure[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
@end
