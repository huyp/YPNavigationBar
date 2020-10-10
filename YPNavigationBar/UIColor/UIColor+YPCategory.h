//
//  UIColor+YPCategory.h
//  YPNavigationBar
//
//  Created by b2c on 2020/8/5.
//

#import <UIKit/UIKit.h>

@interface UIColor (YPCategory)

/// 自定义动态颜色
+ (UIColor *)yp_dynamicColorWithAnyModel:(UIColor *)anyColor darkModel:(UIColor *)darkColor;
/// hex颜色
+ (UIColor *)yp_hexColorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
/// 颜色转图片
+ (UIImage *)yp_imageWithColor:(UIColor *)color;

@end
