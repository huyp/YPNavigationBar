//
//  YPConfig.h
//  YPNavigationBar
//
//  Created by hyp on 2020/8/5.
//

/**
 定义默认值
 */

#import <UIKit/UIKit.h>

#define YPNavigationConfigureInstance     [YPNavigationBarConfig sharedInstance]

NS_ASSUME_NONNULL_BEGIN

@interface YPNavigationBarConfig : NSObject
// ------------------ NavigationBar的属性 ------------------
/// 导航栏背景色，默认白色
@property (nonatomic, strong) UIColor   *backgroundColor;

/// 导航栏标题颜色，默认黑色
@property (nonatomic, strong) UIColor   *titleColor;

/// 导航栏标题字体，默认系统字体17
@property (nonatomic, strong) UIFont    *titleFont;

/// 透明度
@property (nonatomic, assign) CGFloat   alpha;

// ------------------ NavigationItem的属性 ------------------
/// 返回按钮图片(默认nil，优先级高于backStyle)
@property (nonatomic, strong) UIImage   *backImage;

/// 是否需要转场导航渐变，默认NO
@property (nonatomic, assign) BOOL      transitionGradual;

// ------------------ UIController的属性 ------------------
/// 状态栏类型，默认UIStatusBarStyleDefault
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/// 是否隐藏状态栏，默认NO
@property (nonatomic, assign) BOOL      statusBarHidden;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
