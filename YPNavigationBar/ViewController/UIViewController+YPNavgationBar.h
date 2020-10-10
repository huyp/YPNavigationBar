//
//  UIViewController+YPNavgationBar.h
//
//  Created by b2c on 2020/9/22.
//  Copyright © 2020 b2c. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPNavigationBarDefine.h"
#import "YPCustomNavigationBar.h"
#import "YPContainerView.h"

@interface UIViewController (YPNavgationBar)

/// 是否使用了自定义navigationBar
@property (nonatomic, assign, getter=isCustomBarInit) BOOL customBarInit;
/// 当前的navigationBar
@property (nonatomic, strong) YPCustomNavigationBar * yp_navigationBar;
/// 当前的navigationItem
@property (nonatomic, strong) UINavigationItem *yp_navigationItem;
/// 导航以外的区域,如果没有使用YP导航 return nil
@property (nonatomic, strong) YPContainerView * yp_containerView;
/// 虚拟的导航
@property (nonatomic, strong, readonly) UIView *virtualNavigationBar;
/// 虚拟的view
@property (nonatomic, strong, readonly) UIView *virtualView;

@end
