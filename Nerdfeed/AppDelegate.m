//
//  AppDelegate.m
//  Nerdfeed
//
//  Created by 郑克明 on 16/1/4.
//  Copyright © 2016年 郑克明. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRCoursesViewController.h"
#import "BNRWebViewController.h"


@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BNRCoursesViewController *cvc = [[BNRCoursesViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *masterNav = [[UINavigationController alloc] initWithRootViewController:cvc];
    
    //注意这里,webViewController的创建并不是在要圧入它的视图控制器(BNRCoursesViewController)里创建,而是直接在UINavigationController创建的地方创建,这是为了方便当使用UISplitViewController时,UISplitViewController可以直接获取到webViewController
    BNRWebViewController *wvc = [[BNRWebViewController alloc]init];
    cvc.webViewController = wvc;
    
    //判断设备类型
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //将webViewController包含在另一个NavigationController里
        UINavigationController *detailNav = [[UINavigationController alloc] initWithRootViewController:wvc];
        
        UISplitViewController *svc = [[UISplitViewController alloc] init];
        svc.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;
        //将"从视图"设置为SplitViewController的代理
        svc.delegate = wvc;
        svc.viewControllers = @[masterNav, detailNav];
        wvc.detailNav = detailNav;
        wvc.masterNav = masterNav;
        wvc.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
        wvc.navigationItem.leftBarButtonItem.title = @"Courses";
        NSLog(@"masterNav:%@ detailNav:%@",masterNav,detailNav);
        self.window.rootViewController = svc;
    }else{
        self.window.rootViewController = masterNav;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
