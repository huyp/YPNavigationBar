//
//  AppDelegate.m

//
//  Created by b2c on 2020/9/22.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import "CustomTabBarController.h"
#import "ViewController.h"
#import "YPNavigationBar.h"

@interface AppDelegate ()

@property (nonatomic, strong) CustomTabBarController *tabBar;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 导航默认值的设置
    [YPNavigationConfigure sharedInstance].titleColor = [UIColor purpleColor];
    
    CustomNavigationController * nav = [[CustomNavigationController alloc] initWithRootViewController:[ViewController new]];
    
    self.tabBar = [[CustomTabBarController alloc] init];
    [self.tabBar addChildViewController:nav];
    
    self.window.rootViewController = self.tabBar;
    [self.window makeKeyAndVisible];
        
    return YES;
}

@end
