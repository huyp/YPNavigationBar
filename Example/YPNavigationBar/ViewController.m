//
//  ViewController.m
//  YPNavigationBar
//
//  Created by b2c on 2020/10/10.
//

#import "ViewController.h"
#import "YPNavigationBar.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yp_navigationItem.title = @"首页";
    
    CustomTableView * tableView = [[CustomTableView alloc] initWithFrame:self.yp_containerView.bounds];
    tableView.navigationController = self.navigationController;
    [self.yp_containerView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.yp_containerView);
    }];
}

@end
