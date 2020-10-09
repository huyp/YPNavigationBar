//
//  CustomNavigationController.m

//
//  Created by b2c on 2020/9/22.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    self.viewControllers.firstObject.hidesBottomBarWhenPushed =NO;
}


@end
