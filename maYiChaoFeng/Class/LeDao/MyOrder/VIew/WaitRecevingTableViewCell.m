//
//  WaitRecevingTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "WaitRecevingTableViewCell.h"
#import "GoodsTableViewCell.h"
@interface WaitRecevingTableViewCell()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *expressNumLable;
@property (weak, nonatomic) IBOutlet UILabel *expressNameLable;
@end
@implementation WaitRecevingTableViewCell
- (IBAction)confirmActoin:(id)sender {
}


-(void)setModel:(GoodsOrderModel *)model{
    _model=model;
    self.dataSoure=model.goods;
    self.expressNameLable.text=[NSString stringWithFormat:@"订单:%@",model.shipping_name];
    self.expressNumLable.text=[NSString stringWithFormat:@"订单:%@",model.shipping_code];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.scrollEnabled=NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellId"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSoure.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cellId";
    GoodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.model=self.dataSoure[indexPath.item];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
