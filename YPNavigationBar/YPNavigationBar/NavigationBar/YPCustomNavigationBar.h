//
//  YPCustomNavigationBar.h
//
//  Created by b2c on 2020/9/22.
//  Copyright © 2020 b2c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YPCustomNavigationBar : UINavigationBar
{
    /**
    说明:
    重写了 setBackgroundColor 方法
    调用 setBackgroundColor 方法可以正确的设置背景色,并且值存在 yp_backgroundColor 中
    */
    UIColor *yp_backgroundColor;
}

/// 当前所在ViewController
@property (nonatomic, weak) UIViewController * currentVC;
/// 背景图
@property (nonatomic, strong) UIImage * backgroundImage;
/// 分割线颜色
@property (nonatomic, strong) UIColor * lineColor;

@end
