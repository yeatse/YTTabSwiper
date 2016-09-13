//
//  YTTabSwipingAnimator.m
//  TestTabbar
//
//  Created by Yang Chao on 16/9/12.
//  Copyright © 2016年 yeatse. All rights reserved.
//

#import "YTTabSwipingAnimator.h"

static const UIViewAnimationOptions YTViewAnimationOptionCurveEaseOut = (7 << 16);

@interface YTTabSwipingAnimator ()

@property (nonatomic) YTTabSwipingDirection direction;

@end

@implementation YTTabSwipingAnimator

- (instancetype)init {
    return [self initWithDirection:YTTabSwipingDirectionNone];
}

- (instancetype)initWithDirection:(YTTabSwipingDirection)direction {
    self = [super init];
    if (self) {
        self.direction = direction;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* containerView = [transitionContext containerView];
    
    UIView* fromViewContainer = [[UIView alloc] initWithFrame:containerView.bounds];
    [fromViewContainer addSubview:fromVC.view];
    [containerView addSubview:fromViewContainer];
    
    UIView* toViewContainer = [[UIView alloc] initWithFrame:containerView.bounds];
    [toViewContainer addSubview:toVC.view];
    [containerView addSubview:toViewContainer];
    
    CGFloat containerWidth = CGRectGetWidth(containerView.bounds);
    
    if (self.direction == YTTabSwipingDirectionRightToLeft) {
        toViewContainer.transform = CGAffineTransformMakeTranslation(containerWidth, 0);
    } else if (self.direction == YTTabSwipingDirectionLeftToRight) {
        toViewContainer.transform = CGAffineTransformMakeTranslation(-containerWidth, 0);
    }
    
    UIViewAnimationOptions animationOptions = [transitionContext isInteractive] ? UIViewAnimationOptionCurveLinear : YTViewAnimationOptionCurveEaseOut;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:animationOptions animations:^{
        if (self.direction == YTTabSwipingDirectionRightToLeft) {
            fromViewContainer.transform = CGAffineTransformMakeTranslation(-containerWidth, 0);
        } else if (self.direction == YTTabSwipingDirectionLeftToRight) {
            fromViewContainer.transform = CGAffineTransformMakeTranslation(containerWidth, 0);
        }
        toViewContainer.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [fromViewContainer removeFromSuperview];
        [toViewContainer removeFromSuperview];
        
        BOOL shouldComplete = ![transitionContext transitionWasCancelled];
        if (shouldComplete) {
            [containerView addSubview:toVC.view];
        } else {
            [containerView addSubview:fromVC.view];
        }
        [transitionContext completeTransition:shouldComplete];
    }];
}

@end
