//
//  FNViewController.m
//  FengNiao
//
//  Created by Jonear on 16/4/20.
//  Copyright © 2016年 Jonear. All rights reserved.
//

#import "UIViewController+NavgationItem.h"

@implementation UIViewController (NavgationItem)

#pragma mark - common 
- (UIButton *)getNavButtonWithTitle:(NSString *)title selector:(SEL)selector color:(UIColor *)color {
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    [rightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:color forState:UIControlStateNormal];
    [rightBtn setTitleColor:[color colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
    [rightBtn sizeToFit];
    
    return rightBtn;
}

- (UIButton *)getNavButtonWithImage:(UIImage *)image selector:(SEL)selector {
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [rightBtn setImage:image forState:UIControlStateNormal];
    [rightBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return rightBtn;
}

#pragma mark - navButton
- (UIButton *)addNavLeftBtnWithTitle:(NSString *)title selector:(SEL)selector {
   return [self addNavLeftBtnWithTitle:title selector:selector color:self.navigationController.navigationBar.tintColor];
}

- (UIButton *)addNavLeftBtnWithTitle:(NSString *)title selector:(SEL)selector color:(UIColor *)color {
    UIButton *rightBtn = [self getNavButtonWithTitle:title selector:selector color:color];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.leftBarButtonItem = rightBtnItem;
    
    return rightBtn;
}

- (UIButton *)addNavLeftBtnWithImage:(UIImage *)image selector:(SEL)selector {
    UIButton *rightBtn = [self getNavButtonWithImage:image selector:selector];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.leftBarButtonItem = rightBtnItem;
    
    return rightBtn;
}

- (UIButton *)addNavRightBtnWithTitle:(NSString *)title selector:(SEL)selector {
    return [self addNavRightBtnWithTitle:title selector:selector color:self.navigationController.navigationBar.tintColor];
}

- (UIButton *)addNavRightBtnWithTitle:(NSString *)title selector:(SEL)selector color:(UIColor *)color {
    UIButton *rightBtn = [self getNavButtonWithTitle:title selector:selector color:color];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    return rightBtn;
}

- (UIButton *)addNavRightBtnWithImage:(UIImage *)image selector:(SEL)selector {
    UIButton *rightBtn = [self getNavButtonWithImage:image selector:selector];
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    return rightBtn;
}

@end
