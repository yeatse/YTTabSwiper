//
//  YTTabSwiper.m
//  TestTabbar
//
//  Created by Yang Chao on 16/9/12.
//  Copyright © 2016年 yeatse. All rights reserved.
//

#import "YTTabSwiper.h"
#import "YTTabSwipingAnimator.h"
#import "YTTabSwipingGestureRecognizer.h"

@interface YTTabSwiper ()<UIGestureRecognizerDelegate>

@property (nonatomic) UIPanGestureRecognizer* panRecognizer;
@property (nonatomic) UIPercentDrivenInteractiveTransition* interactionController;

@property (nonatomic) YTTabSwipingDirection direction;

@end

@implementation YTTabSwiper

- (void)setTabBarController:(UITabBarController *)tabBarController {
    _tabBarController = tabBarController;
    
    UIPanGestureRecognizer* recognizer = [[YTTabSwipingGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    recognizer.maximumNumberOfTouches = 1;
    recognizer.delegate = self;
    [tabBarController.view addGestureRecognizer:recognizer];
    _panRecognizer = recognizer;
}

#pragma mark - UITabBarControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    NSUInteger fromIndex, toIndex;
    if (fromVC == tabBarController.moreNavigationController) {
        fromIndex = NSUIntegerMax;
    } else {
        fromIndex = [tabBarController.viewControllers indexOfObjectIdenticalTo:fromVC];
    }
    
    if (toVC == tabBarController.moreNavigationController) {
        toIndex = NSUIntegerMax;
    } else {
        toIndex = [tabBarController.viewControllers indexOfObjectIdenticalTo:toVC];
    }
    
    if (fromIndex < toIndex) {
        self.direction = YTTabSwipingDirectionRightToLeft;
    } else if (fromIndex > toIndex) {
        self.direction = YTTabSwipingDirectionLeftToRight;
    } else {
        self.direction = YTTabSwipingDirectionNone;
    }
    
    return [[YTTabSwipingAnimator alloc] initWithDirection:self.direction];
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.interactionController;
}

#pragma mark - UIPanGestureRecognizer

- (void)pan:(UIPanGestureRecognizer*)recognizer {
    UIView* view = self.tabBarController.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGFloat translationX = [recognizer translationInView:view].x;
        NSInteger nextIndex = -1;
        if (self.tabBarController.moreNavigationController.viewControllers.count <= 1) {
            // moreNavigationController isn't currently supported.
            if (translationX > 0 && self.tabBarController.selectedIndex >= 1) {
                nextIndex = self.tabBarController.selectedIndex - 1;
            } else if (translationX < 0 && self.tabBarController.selectedIndex < self.tabBarController.viewControllers.count - 1) {
                nextIndex = self.tabBarController.selectedIndex + 1;
            }
        }
        if (nextIndex >= 0) {
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            self.tabBarController.selectedIndex = nextIndex;
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat translationX = [recognizer translationInView:view].x;
        if (self.direction == YTTabSwipingDirectionRightToLeft) {
            CGFloat d = MAX(-translationX / CGRectGetWidth(view.bounds), 0);
            [self.interactionController updateInteractiveTransition:d];
        } else if (self.direction == YTTabSwipingDirectionLeftToRight) {
            CGFloat d = MAX(translationX / CGRectGetWidth(view.bounds), 0);
            [self.interactionController updateInteractiveTransition:d];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        BOOL shouldCancel;
        CGFloat velocityX = [recognizer velocityInView:view].x;
        if (ABS(velocityX) < 5) {
            shouldCancel = self.interactionController.percentComplete < 0.5;
        } else {
            shouldCancel = (velocityX < 0) ^ (self.direction == YTTabSwipingDirectionRightToLeft);
        }
        
        if (shouldCancel) {
            [self.interactionController cancelInteractiveTransition];
        } else {
            [self.interactionController finishInteractiveTransition];
        }
        
        self.interactionController = nil;
    }
}

@end
