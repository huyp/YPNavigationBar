//
//  CustomTableView.m

//
//  Created by 胡彦鹏 on 2020/10/7.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "CustomTableView.h"
#import "YPNavigationBar.h"
#import "YPNavViewController.h"
#import "NativeViewController.h"
#import "HideNavViewController.h"
#import "ScrollViewController.h"
#import "CustomNavigationController.h"

@implementation CustomTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.data = @[@"push自定义导航页面", @"push原生导航页面", @"push隐藏导航页面", @"present自定义导航页面", @"present原生导航页面", @"present隐藏导航页面",  @"push滚动页面",@"导航显隐使用yp_navigationBar.hidden",@"分割线颜色yp_navigationBar.lineColor"].mutableCopy;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([NSStringFromClass(self.navigationController.visibleViewController.class) isEqualToString:@"YPNavViewController"]) {
        return 100;
    }
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row < self.data.count) {
        cell.textLabel.text = self.data[indexPath.row];
    } else {
        cell.textLabel.text = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= self.data.count) {
        return;
    }
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[YPNavViewController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[NativeViewController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[HideNavViewController new] animated:YES];
            break;
        case 3: {
            YPNavViewController * vc = [YPNavViewController new];
            vc.showBackBtn = YES;
            CustomNavigationController * nav = [[CustomNavigationController alloc] initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [self.navigationController.visibleViewController presentViewController:nav animated:YES completion:nil];
            break;
        }
        case 4: {
            NativeViewController * vc = [NativeViewController new];
            vc.showBackBtn = YES;
            CustomNavigationController * nav = [[CustomNavigationController alloc] initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [self.navigationController.visibleViewController presentViewController:nav animated:YES completion:nil];
            break;
        }
        case 5: {
            HideNavViewController * vc = [HideNavViewController new];
            vc.showBackBtn = YES;
            CustomNavigationController * nav = [[CustomNavigationController alloc] initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [self.navigationController.visibleViewController presentViewController:nav animated:YES completion:nil];
            break;
        }
        case 6:
            [self.navigationController pushViewController:[ScrollViewController new] animated:YES];
            break;
        case 7:
            if (self.navigationController.visibleViewController.isCustomBarInit) {
                self.navigationController.visibleViewController.yp_navigationBar.hidden = !self.navigationController.visibleViewController.yp_navigationBar.isHidden;
            } else {
                self.navigationController.navigationBar.hidden = !self.navigationController.navigationBar.isHidden;
            }
            break;
        case 8:
        if (self.navigationController.visibleViewController.isCustomBarInit) {
            self.navigationController.visibleViewController.yp_navigationBar.lineColor = [UIColor blueColor];
        }
        break;
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([NSStringFromClass(self.navigationController.visibleViewController.class) isEqualToString:@"YPNavViewController"]) {
        [(YPNavViewController *)self.navigationController.visibleViewController scrollViewDidScroll:scrollView];
    }
}

@end
