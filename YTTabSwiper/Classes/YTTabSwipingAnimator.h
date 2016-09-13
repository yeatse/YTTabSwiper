//
//  YTTabSwipingAnimator.h
//  TestTabbar
//
//  Created by Yang Chao on 16/9/12.
//  Copyright © 2016年 yeatse. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YTTabSwipingDirection) {
    YTTabSwipingDirectionNone,
    YTTabSwipingDirectionLeftToRight,
    YTTabSwipingDirectionRightToLeft
};

@interface YTTabSwipingAnimator : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDirection:(YTTabSwipingDirection)direction NS_DESIGNATED_INITIALIZER;

@end
