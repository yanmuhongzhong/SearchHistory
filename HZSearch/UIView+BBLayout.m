//
//  UIView+BBLayout.m
//  baobaotong
//
//  Created by 顾宏钟 on 2017/11/30.
//  Copyright © 2017年 zzy. All rights reserved.
//

#import "UIView+BBLayout.h"

@implementation UIView (BBLayout)

- (CGFloat)bb_x
{
    return self.frame.origin.x;
}

- (void)setBb_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)bb_y
{
    return self.frame.origin.y;
}

- (void)setBb_y:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)bb_left
{
    return self.frame.origin.x;
}

- (void)setBb_left:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)bb_top
{
    return self.frame.origin.y;
}

- (void)setBb_top:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
- (CGFloat)bb_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBb_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bb_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBb_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bb_width {
    
    return self.frame.size.width;
}

- (void)setBb_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)bb_height {
    return self.frame.size.height;
}

- (void)setBb_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)bb_centerX {
    return self.center.x;
}

- (void)setBb_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)bb_centerY {
    return self.center.y;
}

- (void)setBb_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)bb_origin {
    return self.frame.origin;
}

- (void)setBb_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)bb_size {
    return self.frame.size;
}

- (void)setBb_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
