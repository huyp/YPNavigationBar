# YPNavigationBar

## 场景
iOS开发经常会遇到某个页面的导航栏背景色,透明度,或者显隐状态和其他页面不同.使用系统的方法会导致导航互相影响,这个组件就是为了解决这个问题.

这是采用隐藏原生导航,添加自定义NavigationBar的方案.将导致导航切换扁平化.

## 使用方法
1. 设置导航的默认属性在appDelegate中设置,具体属性详见 YPNavigationConfigure.h
```
[YPNavigationConfigure sharedInstance].titleColor = [UIColor purpleColor];
```

2. 将原有系统的navigationItem,navigationBar替换为yp_navigationItem,yp_navigationBar.

   yp_navigationBar重写了backgroundColor的实现.现在可以使用这个属性正确的为导航设置背景色了.

```
    self.yp_navigationBar.backgroundColor = [UIColor redColor];
    self.yp_navigationItem.title = @"导航的title";
```

yp_navigationBar在UINavigationBar基础上增加了3个新的属性,方便开发者使用.

```
/// 当前所在ViewController
@property (nonatomic, weak) UIViewController * currentVC;
/// 背景图
@property (nonatomic, strong) UIImage * backgroundImage;
/// 分割线颜色
@property (nonatomic, strong) UIColor * lineColor;
```

3. 在UI布局方面,使用新增的controller属性,yp_containerView作为约束基础.

```
[self.yp_containerView addSubview:tableView];
[tableView mas_makeConstraints:^(MASConstraintMaker *make) {
make.edges.equalTo(self.yp_containerView);
}];
```

## 特别说明

1. 当开发者使用 yp_navigationBar or  yp_navigationItem属性后,这个controller将自动使用本组件.不使用则对controller没有影响.
2. 当开发者使用本组件时,使用相对于yp_containerView进行约束布局.
3. 如果项目中需要隐藏导航不要使用原生的方法,请使用本组件的yp_navigationBar.hidden = YES;