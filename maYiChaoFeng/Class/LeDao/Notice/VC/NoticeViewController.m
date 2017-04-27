//
//  NoticeViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/24.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "NoticeViewController.h"
#import "NoticeTableViewCell.h"
#import "ArticleModel.h"
#import "HelpDetailViewController.h"
#import "UIView+FPErrorPage.h"
@interface NoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray<ArticleModel *> *dataSoure;
@end

@implementation NoticeViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title=@"公告";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self getData];
}
-(NSMutableArray<ArticleModel *> *)dataSoure{
    if (!_dataSoure) {
        _dataSoure = [[NSMutableArray alloc]init];
        
    }
    return _dataSoure;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        [_tableView registerNib:[UINib nibWithNibName:@"NoticeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
    return _tableView;
}
-(void)getData{
    NSMutableDictionary *parameter=[NSMutableDictionary dictionary];
    parameter[@"name"]=@"公告";
    parameter[@"page"]=@"0";
    parameter[@"page_size"]=@"10";
[MJHttpTool Post:GetArticle parameters:parameter success:^(id responseObject) {
    MYLog(@"获取公告返回：%@",responseObject);
   self.dataSoure= [ArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
    [self.tableView reloadData];
    if (self.dataSoure.count<1) {
        [self.tableView showBlankPageView];
    }
    else{
        [self.tableView hideBlankPageView];
    }
    
} failure:^(NSError *error) {
    MYLog(@"获取公告错误%@",error);
}];
}
#pragma mark -------UITableDelegate-----------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    NoticeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.dataSoure[indexPath.item];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpDetailViewController *helpDetailC=[[HelpDetailViewController alloc]init];
    helpDetailC.url=[NSString stringWithFormat:@"%@/mobile/index/details/id/%@.html",Host1,self.dataSoure[indexPath.item].a_id];
    [self.navigationController pushViewController:helpDetailC animated:YES];
}


@end
