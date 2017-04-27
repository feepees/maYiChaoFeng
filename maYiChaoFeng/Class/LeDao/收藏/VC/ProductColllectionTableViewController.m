//
//  ProductColllectionTableViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/28.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "ProductColllectionTableViewController.h"
#import "ProductColllectionCell.h"
@interface ProductColllectionTableViewController ()

@end

@implementation ProductColllectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 200.0;
    // 告诉tableView在编辑模式下可以多选
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"editor" object:nil];

}

-(void)notice:(NSNotification *)Notification{
   
    if ([Notification.object integerValue] == 0) {
        
        NSLog(@"%@",Notification.object);
        // 进入编辑模式
        [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    }
}


-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:@"editor"];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"ProductColllectionCell";
    
    ProductColllectionCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProductColllectionCell" owner:nil options:nil] lastObject];
        
    }
    

    return cell;
}


@end
