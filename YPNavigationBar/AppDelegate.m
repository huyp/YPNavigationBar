//
//  AppDelegate.m
//  YPNavigationBar
//
//  Created by b2c on 2020/8/5.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    navi.navigationBar.translucent = YES;
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
