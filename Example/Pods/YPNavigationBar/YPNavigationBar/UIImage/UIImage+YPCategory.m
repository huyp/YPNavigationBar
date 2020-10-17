//
//  UIImage+YPCategory.m

//
//  Created by 胡彦鹏 on 2020/9/29.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "UIImage+YPCategory.h"

@implementation UIImage (YPCategory)

+ (UIImage *)imageName:(NSString *)name ofBundle:(NSString *)bundleName {
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    NSString *image_path = [bundlePath stringByAppendingPathComponent:name];;
    return [[UIImage alloc] initWithContentsOfFile:image_path];
}

@end
