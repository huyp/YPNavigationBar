//
//  UIViewController+YPCategory.m
//  YPNavigationBar
//
//  Created by hyp on 2020/8/5.
//

#import "UIViewController+YPCategory.h"
#import <objc/runtime.h>
#import "YPNavigationBarDefine.h"
#import "UIColor+YPCategory.h"
#import "YPNavigationBarConfig.h"

@implementation UIViewController (YPCategory)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray <NSString *> *oriSels = @[@"viewDidLoad",
                                          @"viewWillAppear:",
                                          @"viewWillLayoutSubviews"];
        
        [oriSels enumerateObjectsUsingBlock:^(NSString * _Nonnull oriSel, NSUInteger idx, BOOL * _Nonnull stop) {
            yp_swizzled_instanceMethod(self, oriSel, self);
        }];
    });
}

- (void)yp_viewDidLoad {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self yp_viewDidLoad];
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)yp_viewWillAppear:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]]) return;
    if ([self isKindOfClass:[UITabBarController class]]) return;
    if (!self.navigationController) return;
    
    if (self.isInitYPNavigationBar) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        // 将自定义导航栏放置顶层
        if (self.yp_navigationBar && !self.yp_navigationBar.hidden) {
            [self.view bringSubviewToFront:self.yp_navigationBar];
        }
        // 隐藏系统导航栏
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    [self yp_viewWillAppear:animated];
}

- (void)yp_viewWillLayoutSubviews {
    if (self.isInitYPNavigationBar) {
        [self setupNavBarFrame];
        [self setContainerViewFrame];
    }
    [self yp_viewWillLayoutSubviews];
}

#pragma mark - 设置导航frame
- (void)setupNavBarFrame {
    CGFloat naviHeight = 0;
    if (YP_SCREEN_WIDTH > YP_SCREEN_HEIGHT) { //横屏
        naviHeight = YP_NAVBAR_HORIZONTAL_HEIGHT;
    } else { // 竖屏
        if (!YP_IS_STATUSBAR_HIDDEN || YP_IS_NOTCHED_SCREEN) { // 状态栏显示 | 刘海屏
            naviHeight = YP_STATUSBAR_HEIGHT + YP_NAVBAR_VERTICAL_HEIGHT;
        } else { // 状态栏隐藏 & 非刘海屏
            naviHeight = YP_NAVBAR_VERTICAL_HEIGHT;
        }
    }
    self.yp_navigationBar.frame = CGRectMake(0, 0, YP_SCREEN_WIDTH, naviHeight);
}

#pragma mark - 设置容器frame
- (void)setContainerViewFrame {
    CGFloat containerY = 0;
    if (YP_IS_STATUSBAR_HIDDEN) {
        if (self.yp_navigationBar.hidden) {
            if (YP_IS_NOTCHED_SCREEN) {
                containerY = YP_STATUSBAR_HEIGHT;
            } else {
                containerY = 0;
            }
        } else {
            if (YP_IS_NOTCHED_SCREEN) {
                containerY = YP_STATUSBAR_HEIGHT + YP_NAVBAR_HEIGHT;
            } else {
                containerY = YP_NAVBAR_HEIGHT;
            }
        }
    } else {
        if (self.yp_navigationBar.hidden) {
            containerY = YP_STATUSBAR_HEIGHT;
        } else {
            containerY = YP_STATUSBAR_HEIGHT + YP_NAVBAR_HEIGHT;
        }
    }
    
    NSLog(@"YP_SCREEN_WIDTH : %f", YP_SCREEN_WIDTH);

    self.yp_containerView.frame = CGRectMake(0, containerY, YP_SCREEN_WIDTH, YP_SCREEN_HEIGHT - containerY);
}

#pragma mark - 容器view
static char kAssociatedObjectKey_containerView;
- (void)setYp_containerView:(UIView *)yp_containerView {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_containerView, yp_containerView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)yp_containerView {
    UIView * yp_containerView = objc_getAssociatedObject(self, &kAssociatedObjectKey_containerView);
    if (!yp_containerView) {
        yp_containerView = [[UIView alloc] init];
        if (self.yp_navigationBar.hidden && YP_IS_STATUSBAR_HIDDEN) {
            yp_containerView.frame = CGRectMake(0, 0, YP_SCREEN_WIDTH, YP_SCREEN_HEIGHT);
        } else if (self.yp_navigationBar.hidden && !YP_IS_STATUSBAR_HIDDEN){
            yp_containerView.frame = CGRectMake(0, YP_STATUSBAR_HEIGHT, YP_SCREEN_WIDTH, YP_SCREEN_HEIGHT - YP_STATUSBAR_HEIGHT);
        } else if (!self.yp_navigationBar.hidden && YP_IS_STATUSBAR_HIDDEN) {
            yp_containerView.frame = CGRectMake(0, YP_NAVBAR_HEIGHT, YP_SCREEN_WIDTH, YP_SCREEN_HEIGHT - YP_NAVBAR_HEIGHT);
        } else if (!self.yp_navigationBar.hidden && !YP_IS_STATUSBAR_HIDDEN) {
            yp_containerView.frame = CGRectMake(0, YP_NAVBAR_HEIGHT + YP_STATUSBAR_HEIGHT, YP_SCREEN_WIDTH, YP_SCREEN_HEIGHT - YP_NAVBAR_HEIGHT - YP_STATUSBAR_HEIGHT);
        }
        yp_containerView.backgroundColor = [UIColor yp_dynamicColorWithAnyModel:[UIColor yp_hexColorWithHexString:@"ffffff" alpha:1.0] darkModel:[UIColor yp_hexColorWithHexString:@"16161A" alpha:1.0]];
        self.yp_containerView = yp_containerView;
        [self.view addSubview:yp_containerView];
    }
    return yp_containerView;
}

#pragma mark - 当前Controller是否使用了YPNavigationBar
static char kAssociatedObjectKey_isInitYPNavigationBar;
- (void)setIsInitYPNavigationBar:(BOOL)isInitYPNavigationBar {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_isInitYPNavigationBar, @(isInitYPNavigationBar), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isInitYPNavigationBar {
    return [objc_getAssociatedObject(self, &kAssociatedObjectKey_isInitYPNavigationBar) boolValue];
}

#pragma mark - 添加自定义导航栏
static char kAssociatedObjectKey_navigationBar;
- (void)setYp_navigationBar:(YPNavigationBar *)yp_navigationBar {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_navigationBar, yp_navigationBar, OBJC_ASSOCIATION_RETAIN);
}

- (YPNavigationBar *)yp_navigationBar {
    YPNavigationBar * navigationBar = objc_getAssociatedObject(self, &kAssociatedObjectKey_navigationBar);
    if (!navigationBar) {
        navigationBar = [[YPNavigationBar alloc] init];
        navigationBar.yp_currentViewController = self;
        [self.view addSubview:navigationBar];
        self.isInitYPNavigationBar = YES;
        self.yp_navigationBar = navigationBar;
    }
    return navigationBar;
}

#pragma mark - navigationItem
static char kAssociatedObjectKey_navigationItem;
- (void)setYp_navigationItem:(UINavigationItem *)yp_navigationItem {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_navigationItem, yp_navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.yp_navigationBar.items = @[yp_navigationItem];
}

- (UINavigationItem *)yp_navigationItem {
    UINavigationItem *navigationItem = objc_getAssociatedObject(self, &kAssociatedObjectKey_navigationItem);
    if (!navigationItem) {
        navigationItem = [[UINavigationItem alloc] init];
        self.yp_navigationItem = navigationItem;
    }
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_navigationItem);
}


@end
