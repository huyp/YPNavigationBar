//
//  YPNavigationBarDefine.h
//  YPNavigationBar
//
//  Created by hyp on 2020/8/5.
//

/**
 1. 定义基本的屏幕参数
 2. 定义交换方法
 */

#ifndef YPNavigationBarDefine_h
#define YPNavigationBarDefine_h

#import <objc/runtime.h>

/// 系统版本高于11
#define YP_IOS11    ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)
/// 系统版本高于13
#define YP_IOS13    ([[UIDevice currentDevice].systemVersion doubleValue] >= 13.0)

/// 是否是iPAD
#define YP_IS_IPAD  ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
/// 是否是PLUS | X
#define YP_IS_PLUS  (YP_SCREEN_WIDTH == 414.f || YP_SCREEN_HEIGHT == 414.f)
/// 是否是刘海屏
#define YP_IS_NOTCHED_SCREEN        (YP_SCREEN_HEIGHT/YP_SCREEN_WIDTH > 2.16 || YP_SCREEN_WIDTH/YP_SCREEN_HEIGHT > 2.16)
/// 状态栏是否隐藏
#define YP_IS_STATUSBAR_HIDDEN      ([UIApplication sharedApplication].isStatusBarHidden)

/// 屏幕宽度
#define YP_SCREEN_WIDTH                     ([UIScreen mainScreen].bounds.size.width)
/// 屏幕高度
#define YP_SCREEN_HEIGHT                    ([UIScreen mainScreen].bounds.size.height)
/// 状态栏高度
#define YP_STATUSBAR_HEIGHT                 (YP_IS_NOTCHED_SCREEN ? 44.f : 20.f)
/// 竖向导航栏高度
#define YP_NAVBAR_VERTICAL_HEIGHT           (44.f)
/// 横向导航栏高度
#define YP_NAVBAR_HORIZONTAL_HEIGHT         (YP_IS_PLUS || YP_IS_IPAD ? 44.f : 32.f)
/// 导航栏高度
#define YP_NAVBAR_HEIGHT                    (YP_SCREEN_WIDTH > YP_SCREEN_HEIGHT ? YP_NAVBAR_HORIZONTAL_HEIGHT : YP_NAVBAR_VERTICAL_HEIGHT)

/// 使用static inline创建静态内联函数，方便调用，新方法默认自带前缀yp_
static inline void yp_swizzled_instanceMethod(Class oldClass, NSString *oldSelector, Class newClass) {
    NSString *newSelector = [NSString stringWithFormat:@"yp_%@", oldSelector];
    
    SEL originalSelector = NSSelectorFromString(oldSelector);
    SEL swizzledSelector = NSSelectorFromString(newSelector);
    
    Method originalMethod = class_getInstanceMethod(oldClass, NSSelectorFromString(oldSelector));
    Method swizzledMethod = class_getInstanceMethod(newClass, NSSelectorFromString(newSelector));
    
    BOOL isAdd = class_addMethod(oldClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isAdd) {
        class_replaceMethod(newClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#endif /* YPNavigationBarDefine_h */
