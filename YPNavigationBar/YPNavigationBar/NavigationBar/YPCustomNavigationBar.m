//
//  YPCustomNavigationBar.m
//
//  Created by b2c on 2020/9/22.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "YPCustomNavigationBar.h"
#import "YPNavigationBarDefine.h"
#import "YPNavigationConfigure.h"
#import "UIColor+YPCategory.h"

@interface YPCustomNavigationBar ()

@property (nonatomic, weak) YPNavigationConfigure * configure;

@end

@implementation YPCustomNavigationBar

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (previousTraitCollection && yp_backgroundColor) {
        self.backgroundColor = yp_backgroundColor;
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.configure = [YPNavigationConfigure sharedInstance];
        [self defaultProperty];
    }
    return self;
}
- (void)defaultProperty {
    // 导航不透明
    self.translucent = NO;
    self.alpha = 1.0;
    
    if (self.configure.backgroundColor) {
        self.backgroundColor = self.configure.backgroundColor;
    }
    if (self.configure.backgroundImage) {
        self.backgroundImage = self.configure.backgroundImage;
    }
    if (self.configure.titleFont && self.configure.titleColor) {
        self.titleTextAttributes = @{NSForegroundColorAttributeName: self.configure.titleColor, NSFontAttributeName: self.configure.titleFont};
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
            } else if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarContentView")]){
                if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight ||
                    [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft) {
                    obj.frame = self.frame;
                } else {
                    CGRect frame = obj.frame;
                    frame.origin.y = YP_STATUSBAR_HEIGHT;
                    obj.frame = frame;
                }
            }
        }];
    }
}
#pragma mark - 分割线颜色
- (void)setLineColor:(UIColor *)yp_lineColor {
    _lineColor = yp_lineColor;
    self.shadowImage = [UIColor yp_imageWithColor:yp_lineColor];
}
#pragma mark - 重新定义backgroundColor
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    yp_backgroundColor = backgroundColor;
    [self setBackgroundImage:[UIColor yp_imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark - 背景图
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}
#pragma mark - 当前VC
- (void)setCurrentVC:(UIViewController *)currentVC {
    _currentVC = currentVC;
    if (currentVC.navigationController.viewControllers.count > 1) {
        UIImageView * leftBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        leftBarImageView.contentMode = UIViewContentModeScaleAspectFill;
        leftBarImageView.image = self.configure.leftImage;
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:self.configure.leftImage style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
        self.topItem.leftBarButtonItem = item;
    }
}

- (void)popViewController {
    [self.currentVC.navigationController popViewControllerAnimated:YES];
}

@end
