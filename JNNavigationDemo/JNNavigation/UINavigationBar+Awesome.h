//
//  UINavigationBar+Awesome.h
//  JNNavigation
//
//  Created by Jonear on 16-2-15.
//  Copyright (c) 2015 Jonear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)
- (void)jn_setBackgroundColor:(UIColor *)backgroundColor;
- (void)jn_setElementsAlpha:(CGFloat)alpha;
- (void)jn_setTranslationY:(CGFloat)translationY;
- (void)jn_reset;

- (void)jn_setBackgroundAlpha:(CGFloat)alpha;
- (void)jn_setBottomLineHidden:(BOOL)isHidden;
@end
