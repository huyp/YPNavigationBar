//
//  NativeViewController.m

//
//  Created by 胡彦鹏 on 2020/10/6.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "NativeViewController.h"
#import "Masonry.h"
#import "CustomTableView.h"

@interface NativeViewController ()

@end

@implementation NativeViewController

- (void)dealloc {
    NSLog(@"NativeViewController dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"原生导航";
    
    if (self.showBackBtn) {
        UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
    CustomTableView * tableView = [[CustomTableView alloc] initWithFrame:self.view.bounds];
    tableView.navigationController = self.navigationController;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
