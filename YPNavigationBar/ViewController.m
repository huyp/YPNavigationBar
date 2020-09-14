//
//  ViewController.m
//  YPNavigationBar
//
//  Created by b2c on 2020/8/5.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "ModelDemo.h"
#import "MJExtension.h"

@interface ViewController ()

@property (strong , nonatomic) UIScrollView * scrollV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yp_navigationBar.yp_backgroundColor = [UIColor yellowColor];
    self.yp_navigationItem.title = @"首页";
    self.yp_containerView.backgroundColor = [UIColor purpleColor];
    NSLog(@"self.navigationItem: %@",self.navigationItem);
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    btn.center = CGPointMake(self.yp_containerView.bounds.size.width/2.0, self.yp_containerView.bounds.size.height/2.0);
    [self.yp_containerView addSubview:btn];
}

- (void)next {
    ViewController2 * v2 = [ViewController2 new];
    [self.navigationController pushViewController:v2 animated:YES];
}


@end
