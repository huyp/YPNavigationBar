//
//  ViewController2.m
//  YPNavigationBar
//
//  Created by b2c on 2020/8/7.
//

#import "ViewController2.h"
#import "ViewController3.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.yp_navigationBar.yp_backgroundColor = [UIColor redColor];
    self.yp_navigationItem.title = @"yp导航";
    self.yp_containerView.backgroundColor = [UIColor greenColor];
    
    UIImageView * messageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message"]];
    messageV.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapMessageV = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(message)];
    [messageV addGestureRecognizer:tapMessageV];
    
    UIButton * messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(0, 0, 21, 44);
    [messageBtn sizeToFit];
    messageBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [messageBtn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right1 = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    self.yp_navigationItem.rightBarButtonItems = @[right1];
//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"下一页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    btn.center = CGPointMake(self.yp_containerView.bounds.size.width/2.0, self.yp_containerView.bounds.size.height/2.0);
    [self.yp_containerView addSubview:btn];
}

- (void)next {
    ViewController3 * v3 = [ViewController3 new];
    [self.navigationController pushViewController:v3 animated:YES];
}

- (void)message {
    NSLog(@"message");
}

- (void)setting {
    NSLog(@"setting");
}

@end
