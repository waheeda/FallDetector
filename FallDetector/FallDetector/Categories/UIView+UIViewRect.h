//
//  UIView+UIViewRect.h
//  UnitedWay211
//
//  Created by Firdous on 18/04/2014.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewRect)

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setSize:(CGSize)size;
- (CGFloat)getViewYandHeight;
- (CGFloat)getViewXandWidth;

@end
