//
//  CompanyIntroductionViewController.m
//  maYiChaoFeng
//
//  Created by Android on 2017/3/14.
//  Copyright © 2017年 cc.youdu. All rights reserved.
//

#import "CompanyIntroductionViewController.h"

@interface CompanyIntroductionViewController ()

@end

@implementation CompanyIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web=[[UIWebView alloc]initWithFrame:self.view.bounds];
    web.scalesPageToFit=YES;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:web];
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
