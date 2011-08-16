//
//  LVTestNavigationCoordinatorFactory.m
//  NavigationCoordinatorApp
//
//  Created by Rusty Zarse on 8/11/11.
//  Copyright 2011 LeVous, LLC. All rights reserved.
//

#import "LVTestNavigationCoordinatorFactory.h"
#import <Three20/Three20.h>
#import "LVMainTabBarController.h"
#import "CatalogController.h"

@implementation LVTestNavigationCoordinatorFactory

static LVNavigationCoordinator *defaultInstance;

+ (void)mapTestRoutes:(LVNavigationCoordinator *)navigationCoordinator{
    
    UIWindow *launchWindow = [[UIApplication sharedApplication] keyWindow];
    TTNavigator* navigatorMaster = [TTNavigator navigator];
    navigatorMaster.persistenceMode = TTNavigatorPersistenceModeAll;
    navigatorMaster.window = launchWindow;   
    navigatorMaster.persistenceKey = @"testRoot";     
    TTURLMap *navMap = navigatorMaster.URLMap;
    
    // Main tab , which serves as the apps container view controller
    [navMap from:@"navApp://tabBarMain" toSharedViewController:[LVMainTabBarController class]];
    // Main tab , which serves as the apps container view controller
    [navMap from:@"navApp://catalog" toSharedViewController:[CatalogController class]];
    
    
        
    // for the app, now we should [launchWindow makeKeyAndVisible]; 
    
}

+ (void)initialize{
    defaultInstance = [[LVNavigationCoordinator alloc] init];
    [self mapTestRoutes:defaultInstance];
}

+ (LVNavigationCoordinator *)defaultTestNavigationCoordinator{
    return defaultInstance;
}


@end
