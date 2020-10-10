//
//  ScrollViewController.m

//
//  Created by 胡彦鹏 on 2020/10/6.
//  Copyright © 2020 b2c. All rights reserved.
//

#import "ScrollViewController.h"
#import "YPNavigationBar.h"
#import "Masonry.h"

@interface ScrollViewController () {
    UIScrollView * scrollview;
}

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.yp_navigationItem.title = @"滚动视图手势";
    scrollview = [[UIScrollView alloc] initWithFrame:self.yp_containerView.bounds];
    [self.yp_containerView addSubview:scrollview];
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.yp_containerView);
    }];
    scrollview.pagingEnabled = YES;
    scrollview.bounces = NO;
}

- (void)viewDidLayoutSubviews {
    CGSize size = self.yp_containerView.bounds.size;
    scrollview.contentSize = CGSizeMake(size.width*3, size.height);
    
    UIView * yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    yellowView.backgroundColor = [UIColor yellowColor];
    [scrollview addSubview:yellowView];
    
    UIView * greenView = [[UIView alloc] initWithFrame:CGRectMake(size.width, 0, size.width, size.height)];
    greenView.backgroundColor = [UIColor greenColor];
    [scrollview addSubview:greenView];
    
    UIView * cyanView = [[UIView alloc] initWithFrame:CGRectMake(size.width*2, 0, size.width, size.height)];
    cyanView.backgroundColor = [UIColor cyanColor];
    [scrollview addSubview:cyanView];
}

@end
