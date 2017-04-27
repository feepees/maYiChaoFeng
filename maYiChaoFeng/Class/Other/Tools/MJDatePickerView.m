//
//  MJDatePickerView.m
//  duoBi
//
//  Created by 孟杰 on 16/11/21.
//  Copyright © 2016年 龙御科技（北京）有限公司. All rights reserved.
//

#import "MJDatePickerView.h"

//#define backViewY -249

@interface MJDatePickerView()


@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (weak, nonatomic) IBOutlet UIView *datePickerBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datePickerBackView_bottom;

@property(nonatomic,copy) NSString *dateStr;
@property(nonatomic,strong) NSDate *date;
@end

@implementation MJDatePickerView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    
    self.datePickerView.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区

    //进入控制器，首先将日期控件
    self.datePickerBackView_bottom.constant = -249;
    
    [UIView animateWithDuration:0.25 animations:^{
            self.datePickerBackView_bottom.constant = 0;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
    
    self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    self.datePickerView.datePickerMode = UIDatePickerModeDate;
     self.datePickerView.date = [NSDate date];
    [self.datePickerView addTarget:self action:@selector(chageDate:) forControlEvents:UIControlEventValueChanged];

   
}

-(void)chageDate:(UIDatePicker *)sender{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"] ];
    
    //不设置h:mm日期月份会算错
    [formatter setDateFormat:@"MM/dd/YYYY hh:mm:ss"];
    self.dateStr= [formatter stringFromDate:sender.date];
    self.date = sender.date;
    MYLog(@"%@",self.dateStr);
    
}

- (IBAction)clickRight:(id)sender {
    
    //获取日期
    NSDate *date = self.datePickerView.date;
    MYLog(@"选取的时间：%@",date);
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/dd/YYYY hh:mm:ss";
    
    NSString *timestamp = [formatter stringFromDate:self.datePickerView.date];
    self.dateStr = [NSString stringWithFormat:@"%@",timestamp];
    self.date=date;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];

        self.datePickerBackView_bottom.constant = -249;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        //点击确定传出当前选中日期
        self.selectdate(self.date,self.dateStr);
        
        [self removeFromSuperview];
        
    }];
    
//    NSDate *date = self.datePickerView.date;
//    MJLog(@"%@",date);
//    
//        //如果当前日期为空，那么将当前日期返回
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
//
//        [formatter setDateFormat:@"mm/dd/YYYY"];
//        self.dateStr= [formatter stringFromDate:date];
    
 
    
   
}


- (IBAction)cancel:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        
        self.datePickerBackView_bottom.constant = -249;
        
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];

        
    }];
    
}

@end
