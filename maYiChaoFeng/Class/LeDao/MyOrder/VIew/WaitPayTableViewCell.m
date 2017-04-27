//
//  WaitPayTableViewCell.m
//  maYiChaoFeng
//
//  Created by Android on 2017/4/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "WaitPayTableViewCell.h"
#import "GoodsTableViewCell.h"

@interface WaitPayTableViewCell()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation WaitPayTableViewCell

- (IBAction)cancelOrderAction:(id)sender {
    self.cancalOrder(self.model);
}
- (IBAction)payAction:(id)sender {
    self.payOrder(self.model);
}
- (IBAction)selectAction:(id)sender {
    UIButton *button=(UIButton *)sender;
    button.selected=!button.selected;
    self.selectOrder(self.model,button.selected);
}

-(void)setModel:(GoodsOrderModel *)model{
    _model=model;
    self.dataSoure=model.goods;
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

    // Configure the view for the selected state
}

@end
