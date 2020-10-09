//
//  YPNavViewController.m

//
//  Created by 胡彦鹏 on 2020/10/6.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "YPNavViewController.h"
#import "YPNavigationBar.h"
#import "Masonry.h"
#import "CustomTableView.h"

@interface YPNavViewController ()

@end

@implementation YPNavViewController

- (void)dealloc {
    NSLog(@"YPNavViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yp_navigationBar.backgroundColor = [UIColor redColor];
    self.yp_navigationItem.title = @"滑动tableView调整导航alpha";
    
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = 1.0;
    if (offset <= 200) {
        alpha = (200.f-offset)/200.f;
    } else {
        alpha = 0.0;
    }
    self.yp_navigationBar.alpha = alpha;
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
