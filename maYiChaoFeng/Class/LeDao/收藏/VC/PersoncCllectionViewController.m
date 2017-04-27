//
//  PersoncCllectionViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/2/28.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "PersoncCllectionViewController.h"

@interface PersoncCllectionViewController ()

@end

@implementation PersoncCllectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateSelected];
    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn addTarget:self action:@selector(editor:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;

}

-(void)editor:(UIButton *)Btn{
    Btn.selected = !Btn.selected;

    NSLog(@"%d",self.selectIndex);
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"editor" object:[NSString stringWithFormat:@"%d",self.selectIndex] userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
