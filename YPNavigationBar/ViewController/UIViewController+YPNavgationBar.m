//
//  UIViewController+YPNavgationBar.m
//
//  Created by b2c on 2020/9/22.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "UIViewController+YPNavgationBar.h"
#import "UIColor+YPCategory.h"
#import "YPNavigationConfigure.h"
#import "UIImage+YPCategory.h"

@interface UIViewController (YPNavgationBar)

@end

@implementation UIViewController (YPNavgationBar)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray <NSString *> *oriSels = @[@"viewDidLoad", @"viewWillAppear:",@"viewWillDisappear:",@"viewDidAppear:",@"viewWillLayoutSubviews", @"dealloc"];
        [oriSels enumerateObjectsUsingBlock:^(NSString * _Nonnull oriSel, NSUInteger idx, BOOL * _Nonnull stop) {
            yp_swizzled_instanceMethod(self, oriSel, self);
        }];
    });
}

- (void)yp_dealloc {
    if (self.isCustomBarInit) {
        [self.yp_navigationBar removeObserver:self forKeyPath:@"hidden"];
    } else {
        // ...
    }
    [self yp_dealloc];
}

- (void)yp_viewDidLoad {
    if ([self isKindOfClass:[UINavigationController class]] || [self isKindOfClass:[UITabBarController class]] || !self.navigationController) {
        // ...
    } else {
        // 原生导航不透明
        self.navigationController.navigationBar.translucent = NO;
        // 对不透明导航view延展到四周
        self.extendedLayoutIncludesOpaqueBars = YES;
        // scroll内边距(默认就可以)
        self.edgesForExtendedLayout = UIRectEdgeTop;
        // 显示导航
        self.navigationController.navigationBar.hidden = NO;
    }
    [self yp_viewDidLoad];
}

- (void)yp_viewWillAppear:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]] || [self isKindOfClass:[UITabBarController class]] || !self.navigationController) {
        // ...
    } else {
        if (self.isCustomBarInit) {
            self.navigationController.navigationBar.hidden = YES;
            self.yp_navigationBar.frame = CGRectMake(0, 0, YP_SCREEN_WIDTH, YP_NAVBAR_HEIGHT + YP_STATUSBAR_HEIGHT);
            [self.view bringSubviewToFront:self.yp_navigationBar];
        } else {
            
        }
    }
    [self yp_viewWillAppear:animated];
}

- (void)yp_viewWillDisappear:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]] || [self isKindOfClass:[UITabBarController class]] || !self.navigationController) {
        // ...
    } else {
        if (!self.isCustomBarInit) {
            [self.view addSubview:self.virtualView];
            [self.view addSubview:self.virtualNavigationBar];
        } else {
            // ...
        }
    }
    [self yp_viewWillDisappear:animated];
}

- (void)yp_viewDidAppear:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]] || [self isKindOfClass:[UITabBarController class]] || !self.navigationController) {
        // ...
    } else {
        if (!self.isCustomBarInit) {
            [self.virtualNavigationBar removeFromSuperview];
            [self.virtualView removeFromSuperview];
            self.navigationController.navigationBar.hidden = NO;
        } else {
            // ...
        }
    }
    [self yp_viewDidAppear:animated];
}

- (void)yp_viewWillLayoutSubviews {
    if ([self isKindOfClass:[UINavigationController class]] || [self isKindOfClass:[UITabBarController class]] || !self.navigationController) {
        // ...
    } else {
        if (self.customBarInit) {
            [self setupNavBarFrame];
            [self updateContainerViewFrame];
        }
    }
    [self yp_viewWillLayoutSubviews];
}

#pragma mark - 设置导航frame
- (void)setupNavBarFrame {
    self.yp_navigationBar.frame = CGRectMake(0, 0, YP_SCREEN_WIDTH, YP_NAVBAR_HEIGHT + YP_STATUSBAR_HEIGHT);
}
#pragma mark - 设置ContainerView frame
- (void)updateContainerViewFrame {
    BOOL isHidden = self.yp_navigationBar.isHidden;
    CGFloat Y = isHidden ? YP_STATUSBAR_HEIGHT : YP_NAVBAR_HEIGHT + YP_STATUSBAR_HEIGHT;
    CGFloat H = isHidden ? self.view.bounds.size.height - YP_STATUSBAR_HEIGHT : self.view.bounds.size.height - YP_NAVBAR_HEIGHT - YP_STATUSBAR_HEIGHT;
    self.yp_containerView.frame = CGRectMake(0, Y, YP_SCREEN_WIDTH, H);
}

#pragma mark - 是否使用了自定义NavigationBar
static char kAssociatedObjectKey_customBarInit;
- (void)setCustomBarInit:(BOOL)customBarInit {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_customBarInit, @(customBarInit), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isCustomBarInit {
    return [objc_getAssociatedObject(self, &kAssociatedObjectKey_customBarInit) boolValue];
}

#pragma mark - navigationBar
static char kAssociatedObjectKey_navigationBar;
- (void)setYp_navigationBar:(YPCustomNavigationBar *)yp_navigationBar {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_navigationBar, yp_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 初始化yp_navigationItem
    yp_navigationBar.items = @[self.yp_navigationItem];
    // 初始化yp_containerView
    [self.view addSubview:self.yp_containerView];
}
- (YPCustomNavigationBar *)yp_navigationBar {
    YPCustomNavigationBar * navigationBar = objc_getAssociatedObject(self, &kAssociatedObjectKey_navigationBar);
    if (!navigationBar) {
        navigationBar = [[YPCustomNavigationBar alloc] init];
        [self.view addSubview:navigationBar];
        self.customBarInit = YES;
        self.yp_navigationBar = navigationBar;
        navigationBar.currentVC = self;
        [navigationBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
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
    return navigationItem;
}

#pragma mark - 导航以外的区域
static char kAssociatedObjectKey_containerView;
- (void)setYp_containerView:(UIView *)yp_containerView {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_containerView, yp_containerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (YPContainerView *)yp_containerView {
    if (self.isCustomBarInit) {
        YPContainerView * containerView = objc_getAssociatedObject(self, &kAssociatedObjectKey_containerView);
        if (!containerView) {
            containerView = [[YPContainerView alloc] init];
            containerView.backgroundColor = [UIColor clearColor];
            self.yp_containerView = containerView;
        }
        return containerView;
    } else {
        return nil;
    }
}

#pragma mark - 原生导航的截图
static char kAssociatedObjectKey_virtualNavigationBar;
- (void)setVirtualNavigationBar:(UIView *)virtualNavigationBar {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_virtualNavigationBar, virtualNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)virtualNavigationBar {
    UIView * virtualNavigationBar = objc_getAssociatedObject(self, &kAssociatedObjectKey_virtualNavigationBar);
    if (!virtualNavigationBar) {
        for (__kindof UIView * _Nonnull obj in self.navigationController.navigationBar.subviews) {
            if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]) {
                UIImage * image = [UIImage imageFromView:obj];
                UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.frame = CGRectMake(0, YP_STATUSBAR_HEIGHT, YP_SCREEN_WIDTH, YP_NAVBAR_HEIGHT);
                UIView * virtualNavigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YP_SCREEN_WIDTH, YP_NAVBAR_HEIGHT+YP_STATUSBAR_HEIGHT)];
                virtualNavigationBar.layer.masksToBounds = NO;
                virtualNavigationBar.backgroundColor = [YPNavigationConfigure sharedInstance].backgroundColor;
                UIView * line = [[UIView alloc] init];
                line.frame = CGRectMake(0, YP_NAVBAR_HEIGHT+YP_STATUSBAR_HEIGHT, YP_SCREEN_WIDTH, 1/YP_SCREEN_SCALE);
                line.backgroundColor = [UIColor grayColor];
                [virtualNavigationBar addSubview:imageView];
                [virtualNavigationBar addSubview:line];
                self.virtualNavigationBar = virtualNavigationBar;
                break;
            }
        }
    }
    return virtualNavigationBar;
}

#pragma mark - self.view的截图
static char kAssociatedObjectKey_virtualView;
- (void)setVirtualView:(UIView *)virtualView {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_virtualView, virtualView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)virtualView {
    UIView * virtualView = objc_getAssociatedObject(self, &kAssociatedObjectKey_virtualView);
    if (!virtualView) {
        UIImage * image = [UIImage imageFromView:self.view];
        virtualView = [[UIImageView alloc] initWithImage:image];
        virtualView.frame = self.view.bounds;
        self.virtualView = virtualView;
    }
    return virtualView;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isKindOfClass:[UINavigationBar class]] && [keyPath isEqualToString:@"hidden"]) {
        [self updateContainerViewFrame];
    }
}

@end
