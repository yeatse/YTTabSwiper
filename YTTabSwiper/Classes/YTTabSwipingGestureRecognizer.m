//
//  YTTabSwipingGestureRecognizer.m
//  TestTabbar
//
//  Created by yeatse on 16/9/13.
//  Copyright © 2016年 yeatse. All rights reserved.
//

#import "YTTabSwipingGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface YTTabSwipingGestureRecognizer ()

@property (nonatomic) BOOL dragging;

@end

@implementation YTTabSwipingGestureRecognizer

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];

    if (self.state == UIGestureRecognizerStateFailed) return;

    CGPoint velocity = [self velocityInView:self.view];
    
    // check direction only on the first move
    if (!self.dragging && !CGPointEqualToPoint(velocity, CGPointZero)) {
        if (ABS(velocity.y) > ABS(velocity.x)) {
            // Fails the gesture if we swipe it vertically.
            self.state = UIGestureRecognizerStateFailed;
        }
        self.dragging = YES;
    }
}

- (void)reset {
    [super reset];
    self.dragging = NO;
}

@end
