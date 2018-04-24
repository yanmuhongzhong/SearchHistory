//
//  UIView+BBLayout.h
//  baobaotong
//
//  Created by 顾宏钟 on 2017/11/30.
//  Copyright © 2017年 zzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BBLayout)

@property (nonatomic, assign) CGFloat bb_x;           ///< Shortcut for frame.origin.x.
@property (nonatomic, assign) CGFloat bb_y;           ///< Shortcut for frame.origin.y
@property (nonatomic, assign) CGFloat bb_top;           ///< Shortcut for frame.origin.x.
@property (nonatomic, assign) CGFloat bb_left;           ///< Shortcut for frame.origin.y
@property (nonatomic, assign) CGFloat bb_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic, assign) CGFloat bb_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic, assign) CGFloat bb_width;       ///< Shortcut for frame.size.width.
@property (nonatomic, assign) CGFloat bb_height;      ///< Shortcut for frame.size.height.
@property (nonatomic, assign) CGFloat bb_centerX;     ///< Shortcut for center.x
@property (nonatomic, assign) CGFloat bb_centerY;     ///< Shortcut for center.y
@property (nonatomic, assign) CGPoint bb_origin;      ///< Shortcut for frame.origin.
@property (nonatomic, assign) CGSize  bb_size;        ///< Shortcut for frame.size.

@end
