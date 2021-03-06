//
//  JNBaseViewController.m
//  JNNavigationDemo
//
//  Created by Jonear on 16/10/19.
//  Copyright © 2016年 Jonear. All rights reserved.
//

#import "JNBaseViewController.h"

@interface JNBaseViewController ()

@end

@implementation JNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateNavBackItemIcon];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavigationBarWithType:[self jn_navationBarType] animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self removeCustomNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 子类集成
- (FNNavationBarType)jn_navationBarType {
    return FNNavationBarType_Normal;
}

@end
