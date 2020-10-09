//
//  CustomTableView.h

//
//  Created by 胡彦鹏 on 2020/10/7.
//  Copyright © 2020 b2c. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, weak) UINavigationController *navigationController;

@end
