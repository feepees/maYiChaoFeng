//
//  MJDatePickerView.h
//  duoBi
//
//  Created by 孟杰 on 16/11/21.
//  Copyright © 2016年 龙御科技（北京）有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MJDate)(NSDate *date,NSString *dateStr);
@interface MJDatePickerView : UIView

@property(nonatomic,copy) MJDate selectdate;
@end
