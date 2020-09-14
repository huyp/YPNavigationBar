//
//  UIViewController+YPCategory.h
//  YPNavigationBar
//
//  Created by hyp on 2020/8/5.
//

#import <UIKit/UIKit.h>
#import "YPNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YPCategory)

/// 获取&初始化yp_navigationBar
@property (nonatomic, strong) YPNavigationBar *yp_navigationBar;
/// NavigationItem
@property (nonatomic, strong) UINavigationItem *yp_navigationItem;
/// 当前控制器是否有初始化yp_navigationBar
@property (nonatomic, assign, readonly) BOOL isInitYPNavigationBar;
/// 空白区域
@property (nonatomic, strong) UIView * yp_containerView;

@end

NS_ASSUME_NONNULL_END
