//
//  PlatformLoginAddInfoViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/13.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//  第三方登陆补充信息

#import "PlatformLoginAddInfoViewController.h"

@interface PlatformLoginAddInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@end

@implementation PlatformLoginAddInfoViewController
- (IBAction)closeBtn:(id)sender {
}
- (IBAction)registerBtn:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
