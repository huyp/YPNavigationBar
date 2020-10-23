//
//  UIImage+YPCategory.m

//
//  Created by 胡彦鹏 on 2020/9/29.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "UIImage+YPCategory.h"

@implementation UIImage (YPCategory)

#pragma mark - 截图
+ (UIImage *)imageFromView:(UIView *)theView {
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
