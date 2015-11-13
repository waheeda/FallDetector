//
//  UIView+UIViewRect.m
//  UnitedWay211
//
//  Created by Firdous on 18/04/2014.
//  Copyright (c) 2014 mohsin. All rights reserved.
//

#import "UIView+UIViewRect.h"

@implementation UIView (UIViewRect)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    [self setFrame:frame];
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    [self setFrame:frame];
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    [self setFrame:frame];
}

- (CGFloat)getViewYandHeight{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)getViewXandWidth{
    return self.frame.origin.x + self.frame.size.width;
}
@end
