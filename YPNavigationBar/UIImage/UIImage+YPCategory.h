//
//  UIImage+YPCategory.h

//
//  Created by 胡彦鹏 on 2020/9/29.
//  Copyright © 2020 b2c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YPCategory)

/**
 将传入的View截图,返回Image
 @param theView 传入的view
 */
+ (UIImage *)imageFromView:(UIView *)theView;

@end
