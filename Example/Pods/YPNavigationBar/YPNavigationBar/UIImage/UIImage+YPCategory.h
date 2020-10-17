//
//  UIImage+YPCategory.h

//
//  Created by 胡彦鹏 on 2020/9/29.
//  Copyright © 2020 b2c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YPCategory)

/**
 加载bundle中的图片
 @param name image名称
 @param bundleName bundle名称
 */
+ (UIImage *)imageName:(NSString *)name ofBundle:(NSString *)bundleName;

@end
