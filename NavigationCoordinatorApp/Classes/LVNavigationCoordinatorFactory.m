//
//  LVNavigationCoordinatorFactory.m
//  NavigationCoordinatorApp
//
//  Created by Rusty Zarse on 7/25/11.
//  Copyright 2011 LeVous, LLC. All rights reserved.
//

#import "LVNavigationCoordinatorFactory.h"
#import "SplitCatalogController.h"
#import "CatalogController.h"
#import "DetailDummyViewController.h"

@implementation LVNavigationCoordinatorFactory

static LVNavigationCoordinator *instance;

+ (void)mapApplicationRoutes:(LVNavigationCoordinator *)navigationCoordinator{
    
    // route generic path to web vc
    TTURLMap *map = [navigationCoordinator defaultURLMap];
    [map from:@"*" toViewController:[TTWebController class]];
    
    // set the first path to load on startup
    [navigationCoordinator setDefaultStartUpPath:@"tt://catalog"];
    
    if (TTIsPad()) {
        [map                    from: @"tt://catalog"
              toSharedViewController: [SplitCatalogController class]];
        
        SplitCatalogController* controller =
        (SplitCatalogController*)[[TTNavigator navigator] viewControllerForURL:@"tt://catalog"];
        
        // set up multiple navigators
        [navigationCoordinator wireNavigatorsToSplitView:controller];
        
        TTDASSERT([controller isKindOfClass:[SplitCatalogController class]]);
        map = controller.primaryNavigator.URLMap; 
        
        // set up master pane navigator to respond to catalog path
        [[[navigationCoordinator masterPaneNavigator] URLMap] from: @"tt://catalog"
                                                  toViewController: [CatalogController class]];
        
        // all remaining routes will forward to the detail pane
        
        
    } else {
        [map                    from: @"tt://catalog"
              toSharedViewController: [CatalogController class]];
    }
    
    [map            from: @"tt://photoTest1"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://photoTest2"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://imageTest1"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://tableTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://tableItemTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://tableControlsTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://styledTextTableTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://tableWithShadow"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://tableWithBanner"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://tableDragRefresh"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://composerTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://searchTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://activityTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://styleTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://styledTextTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://buttonTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://tabBarTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://youTubeTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://imageTest2"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://scrollViewTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://launcherTest"
        toViewController: [DetailDummyViewController class]];
    
    [map            from: @"tt://dlprogress"
                  parent: @"tt://catalog"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];
    
    
    // load detail pane with something...
    [[navigationCoordinator detailPaneNavigator] openURLs:@"http://google.com/", @"http://three20.info/", nil];
    
}

+ (void)initialize{
    instance = [[LVNavigationCoordinator alloc] init];
    [LVNavigationCoordinatorFactory mapApplicationRoutes:instance];
}

+ (LVNavigationCoordinator *)navigationCoordinator{
    return instance;
}

@end
