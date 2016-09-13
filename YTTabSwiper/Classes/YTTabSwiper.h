//
//  YTTabSwiper.h
//  TestTabbar
//
//  Created by Yang Chao on 16/9/12.
//  Copyright © 2016年 yeatse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTTabSwiper : NSObject<UITabBarControllerDelegate>

@property (nonatomic, weak) IBOutlet UITabBarController* tabBarController;

@end
