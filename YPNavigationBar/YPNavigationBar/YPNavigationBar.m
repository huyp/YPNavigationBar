//
//  YPNavigationBar.m
//  YPNavigationBar
//
//  Created by hyp on 2020/8/5.
//

#import "YPNavigationBar.h"
#import "YPNavigationBarDefine.h"
#import "UIColor+YPCategory.h"
#import "YPNavigationBarConfig.h"
#import "UIViewController+YPCategory.h"

@implementation YPNavigationBar

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setDefaultProperty];
    }
    return self;
}

#pragma mark - 设置默认值
- (void)setDefaultProperty {
    // 背景色
    self.yp_backgroundColor = YPNavigationConfigureInstance.backgroundColor;
    // title
    self.titleTextAttributes = @{NSForegroundColorAttributeName: YPNavigationConfigureInstance.titleColor, NSFontAttributeName: YPNavigationConfigureInstance.titleFont};
    // 透明度
    self.yp_navBarBackgroundAlpha = YPNavigationConfigureInstance.alpha;
}

- (void)setYp_currentViewController:(UIViewController *)yp_currentViewController {
    _yp_currentViewController = yp_currentViewController;
    // 返回按钮
    if (yp_currentViewController.navigationController.viewControllers.firstObject != yp_currentViewController) {
        self.yp_currentViewController.yp_navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:YPNavigationConfigureInstance.backImage style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
//        yp_currentViewController.yp_navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:YPNavigationConfigureInstance.backImage style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
//        yp_currentViewController.yp_navigationItem.leftBarButtonItem.tintColor = [UIColor yp_dynamicColorWithAnyModel:[UIColor blackColor] darkModel:[UIColor whiteColor]];
    }
}

#pragma mark - 返回上一页
- (void)pop {
    [self.yp_currentViewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 监听模式变化(如果将导航上的按钮改为在Assets中设置暗黑模式套图,那么应该删除此段代码)
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if (previousTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            
        } else {
            
        }
    } else {
        
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 适配iOS11，找到_UINavigationBarContentView,向下移动一个状态栏高度
    if (@available(iOS 11.0, *)) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                CGRect frame = obj.frame;
                frame.size.height = self.frame.size.height;
                obj.frame = frame;
            } else {
                CGFloat y = 0;
                if (YP_SCREEN_WIDTH < YP_SCREEN_HEIGHT && (YP_IS_NOTCHED_SCREEN || !YP_IS_STATUSBAR_HIDDEN)) {
                    y = YP_STATUSBAR_HEIGHT;
                }
                CGRect frame = obj.frame;
                frame.origin.y = y;
                obj.frame = frame;
            }
        }];
    }
    
    self.yp_navBarBackgroundAlpha = self.yp_navBarBackgroundAlpha;
}

- (void)setYp_backgroundImage:(UIImage *)yp_backgroundImage {
    _yp_backgroundImage = yp_backgroundImage;
    [self setBackgroundImage:yp_backgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)setYp_backgroundColor:(UIColor *)yp_backgroundColor {
    _yp_backgroundColor = yp_backgroundColor;
//    self.barTintColor = yp_backgroundColor;
    [self setBackgroundImage:[UIColor yp_imageWithColor:yp_backgroundColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)setYp_navBarBackgroundAlpha:(CGFloat)yp_navBarBackgroundAlpha {
    _yp_navBarBackgroundAlpha = yp_navBarBackgroundAlpha;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (@available(iOS 10.0, *)) {
            if ([obj isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (obj.alpha != yp_navBarBackgroundAlpha) {
                        obj.alpha = yp_navBarBackgroundAlpha;
                    }
                });
            }
        } else if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (obj.alpha != yp_navBarBackgroundAlpha) {
                    obj.alpha = yp_navBarBackgroundAlpha;
                }
            });
        }
    }];
}

- (void)setYp_navLineHidden:(BOOL)yp_navLineHidden {
    _yp_navLineHidden = yp_navLineHidden;
    
    UIView *backgroundView = self.subviews.firstObject;
    for (UIView *view in backgroundView.subviews) {
        if (view.frame.size.height > 0 && view.frame.size.height <= 1.0f) {
            view.hidden = self.yp_navLineHidden;
        }
    }
}

@end
