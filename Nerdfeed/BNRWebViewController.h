//
//  BNRWebViewController.h
//  Nerdfeed
//
//  Created by 郑克明 on 16/1/4.
//  Copyright © 2016年 郑克明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRWebViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic,strong) NSURL *URL;
@property (nonatomic,weak) UINavigationController *masterNav;
@property (nonatomic,weak) UINavigationController *detailNav;

@end
