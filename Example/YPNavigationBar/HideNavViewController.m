//
//  HideNavViewController.m

//
//  Created by 胡彦鹏 on 2020/10/6.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "HideNavViewController.h"
#import "YPNavigationBar.h"
#import "Masonry.h"
#import "CustomTableView.h"

@interface HideNavViewController ()

@end

@implementation HideNavViewController

- (void)dealloc {
    NSLog(@"HideNavViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.yp_navigationBar.hidden = YES;
    
    if (self.showBackBtn) {
        UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
        self.yp_navigationItem.leftBarButtonItem = backItem;
    }
    
    CustomTableView * tableView = [[CustomTableView alloc] initWithFrame:self.yp_containerView.bounds];
    tableView.navigationController = self.navigationController;
    [self.yp_containerView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.yp_containerView);
    }];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
