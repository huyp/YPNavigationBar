//
//  YPNavigationBar.h
//  YPNavigationBar
//
//  Created by hyp on 2020/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPNavigationBar : UINavigationBar

/// 所在的ViewController
@property (nonatomic, weak) UIViewController * yp_currentViewController;

/// 导航背景图片
@property (nonatomic, strong) UIImage * yp_backgroundImage;

/// 导航背景颜色
@property (nonatomic, strong) UIColor * yp_backgroundColor;

/// 导航栏透明度
@property (nonatomic, assign) CGFloat   yp_navBarBackgroundAlpha;

/// 导航栏分割线是否隐藏
@property (nonatomic, assign) BOOL      yp_navLineHidden;



@end

NS_ASSUME_NONNULL_END
