//
//  YPNavigationConfigure.h
//
//  Created by b2c on 2020/9/22.
//  Copyright © 2020 b2c. All rights reserved.
//

/**
 导航默认值
 在AppDelegate or SceneDelegate中修改默认值
 */

#import <UIKit/UIKit.h>

@interface YPNavigationConfigure : NSObject

/// 背景色
@property (nonatomic, strong) UIColor * backgroundColor;
/// 背景图
@property (nonatomic, strong) UIImage * backgroundImage;
/// title-font
@property (nonatomic, strong) UIFont * titleFont;
/// title-color
@property (nonatomic, strong) UIColor * titleColor;
/// 左侧键图片
@property (nonatomic, strong) UIImage * leftImage;

/// 单例
+ (instancetype)sharedInstance;

- (instancetype)init NS_UNAVAILABLE;

@end
