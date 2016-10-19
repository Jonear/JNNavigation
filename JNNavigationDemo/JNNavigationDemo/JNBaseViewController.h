//
//  JNBaseViewController.h
//  JNNavigationDemo
//
//  Created by NetEase on 16/10/19.
//  Copyright © 2016年 NetEase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+NavationBarTheme.h"
#import "UIViewController+NavgationItem.h"

@interface JNBaseViewController : UIViewController

// 子类集成重写
- (FNNavationBarType)jn_navationBarType;

@end
