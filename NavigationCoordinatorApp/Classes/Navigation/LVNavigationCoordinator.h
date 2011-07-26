//
//  LVNavigationCoordinator.h
//  NavigationCoordinatorApp
//
//  Created by Rusty Zarse on 7/25/11.
//  Copyright 2011 LeVous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TTNavigator, TTURLMap, TTRootViewController, TTSplitViewController;

@interface LVNavigationCoordinator : NSObject {
    TTRootViewController* rootViewController;
}

@property(assign, nonatomic) TTNavigator *masterPaneNavigator, *detailPaneNavigator;
@property(assign, nonatomic) TTURLMap *defaultURLMap;
@property(copy, nonatomic) NSString *defaultStartUpPath;

- (void)wireNavigatorsToSplitView:(TTSplitViewController *)splitView;
- (void)presentFirstScreen;
- (BOOL)handleOpenURL:(NSURL *)URL;

@end
