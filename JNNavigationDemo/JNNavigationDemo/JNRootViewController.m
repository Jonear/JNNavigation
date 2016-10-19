//
//  JNRootViewController.m
//  JNNavigationDemo
//
//  Created by Jonear on 16/10/19.
//  Copyright © 2016年 Jonear. All rights reserved.
//

#import "JNRootViewController.h"

@interface JNRootViewController ()

@end

@implementation JNRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor redColor]];
    
    self.title = [NSString stringWithFormat:@"view %zd", self.navigationController.viewControllers.count];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [button1 setBackgroundColor:[UIColor greenColor]];
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    [self addNavRightBtnWithTitle:@"ok" selector:@selector(rightItemClick:)];
    [self setCustomTintColor:[UIColor blueColor]];
}

- (void)buttonClick:(id)sender {
    JNRootViewController *vc = [[JNRootViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightItemClick:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (FNNavationBarType)jn_navationBarType {
    NSInteger num = self.navigationController.viewControllers.count;
    return num%(FNNavationBarType_Black+1);
}

@end
