//
//  YPNavigationConfigure.m
//
//  Created by b2c on 2020/9/22.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "YPNavigationConfigure.h"
#import "UIColor+YPCategory.h"
#import "UIImage+YPCategory.h"

@implementation YPNavigationConfigure

+ (instancetype)sharedInstance {
    static YPNavigationConfigure * shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[YPNavigationConfigure alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self defaultConfigure];
    }
    return self;
}

- (void)defaultConfigure {
    self.backgroundColor = [UIColor yp_dynamicColorWithAnyModel:[UIColor yp_hexColorWithHexString:@"#FFFFFF" alpha:1.0] darkModel:[UIColor yp_hexColorWithHexString:@"16161A" alpha:1.0]];
    self.backgroundImage = nil;
    self.titleFont = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
    self.titleColor = [UIColor yp_dynamicColorWithAnyModel:[UIColor yp_hexColorWithHexString:@"000000" alpha:1.0] darkModel:[UIColor yp_hexColorWithHexString:@"ffffff" alpha:1.0]];
    NSString * imgPath = @"YPNavigationBar.bundle/btn_back.png";
    UIImage * leftImage = [UIImage imageNamed:imgPath inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    self.leftImage = [leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
