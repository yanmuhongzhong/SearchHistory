//
//  ViewController.m
//  HZSearch
//
//  Created by Pig.Zhong on 2018/4/23.
//  Copyright © 2018年 hongzhong. All rights reserved.
//

#import "ViewController.h"
#import "CouponSearchController.h"

// 屏幕宽高
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.frame = CGRectMake((kDeviceWidth - 128) * 0.5, (KDeviceHeight - 40) * 0.5, 128, 40);
    [btn setTitle:@"弹出搜索界面" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn addTarget:self action:@selector(rightmengbutClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}


- (void)rightmengbutClick {
    
    CouponSearchController *searchVC = [[CouponSearchController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
