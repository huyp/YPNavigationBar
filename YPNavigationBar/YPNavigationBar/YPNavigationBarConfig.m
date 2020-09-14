//
//  YPConfig.m
//  YPNavigationBar
//
//  Created by hyp on 2020/8/5.
//

#import "YPNavigationBarConfig.h"
#import "UIColor+YPCategory.h"

@implementation YPNavigationBarConfig

+ (instancetype)sharedInstance {
    static YPNavigationBarConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YPNavigationBarConfig alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultConfig];
    }
    return self;
}
/**
 /// 导航栏背景色，默认白色
 @property (nonatomic, strong) UIColor   *backgroundColor;

 /// 导航栏标题颜色，默认黑色
 @property (nonatomic, strong) UIColor   *titleColor;

 /// 导航栏标题字体，默认系统字体17
 @property (nonatomic, strong) UIFont    *titleFont;

 /// 返回按钮图片(默认nil，优先级高于backStyle)
 @property (nonatomic, strong) UIImage   *backImage;

 /// 状态栏类型，默认UIStatusBarStyleDefault
 @property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

 /// 是否隐藏状态栏，默认NO
 @property (nonatomic, assign) BOOL      statusBarHidden;

 /// 是否需要转场导航渐变，默认NO
 @property (nonatomic, assign) BOOL      transitionGradual;
 */
#pragma mark - 设置默认值
- (void)defaultConfig {
    
    _backgroundColor = [UIColor yp_dynamicColorWithAnyModel:[UIColor yp_hexColorWithHexString:@"ffffff" alpha:1.0] darkModel:[UIColor yp_hexColorWithHexString:@"16161A" alpha:1.0]];
    
    _titleColor = [UIColor yp_dynamicColorWithAnyModel:[UIColor yp_hexColorWithHexString:@"000000" alpha:1.0] darkModel:[UIColor yp_hexColorWithHexString:@"ffffff" alpha:1.0]];
    
    _titleFont = [UIFont systemFontOfSize:17.0];
    
    _alpha = 1.0;
    
    // 修改默认返回图片改这里,设置image为你想要的图片(如果将导航上的按钮改为在Assets中设置暗黑模式套图,那么应该删除此段代码)
    NSString *backImg = [@"YPNavigationBar.bundle" stringByAppendingPathComponent:@"btn_back"];
    _backImage = [UIImage imageNamed:backImg];
    
    _statusBarStyle = UIStatusBarStyleDefault;
    
    _statusBarHidden = NO;
}

@end
