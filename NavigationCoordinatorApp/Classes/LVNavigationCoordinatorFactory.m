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
#import "LVMainTabBarController.h"

@implementation LVNavigationCoordinatorFactory

static LVNavigationCoordinator *instance;

+ (void)mapApplicationRoutes:(LVNavigationCoordinator *)navigationCoordinator{
    
    NSLog(@"shared navigator persistence key:%@", [[TTNavigator navigator] persistenceKey]);
    TTURLMap *map = [navigationCoordinator defaultURLMap];
    
    // set the first path to load on startup
    [navigationCoordinator setDefaultStartUpPaths:[NSArray arrayWithObjects:@"tt://tabBarMain", @"tt://splitview", @"tt://catalog", @"tt://launcherTest", @"tt://imageTest2", nil]];
    
    if (TTIsPad()) {
        // map the root navigator to the tab view
        // Main tab , which serves as the apps container view controller
        [map                    from:@"tt://tabBarMain" 
              toSharedViewController:[LVMainTabBarController class]];
        
        
        [map                    from: @"tt://splitview"
              toSharedViewController: [SplitCatalogController class]];
        
        [map                    from: @"tt://anotherTab"
              toSharedViewController: [DetailDummyViewController class]];

        
                
        SplitCatalogController* controller =
        (SplitCatalogController*)[[TTNavigator navigator] viewControllerForURL:@"tt://splitview"];
        
        // TTSplitView (SplitCatalogController's super) is set up with primary navigator attached to detail pane
        //  and secondary navigator attached to master pane

        
        // set up multiple navigators from split view to 
        [navigationCoordinator wireNavigatorsFromSplitView:controller];
        
        TTDASSERT([controller isKindOfClass:[SplitCatalogController class]]);
        map = controller.rightNavigator.URLMap; 
        
        // set up master pane navigator to respond to catalog path
        [controller.leftNavigator.URLMap from: @"tt://catalog"
                       toSharedViewController: [CatalogController class]];
        
        // all remaining routes will forward to the detail pane
        
        
    } else {
        [map                    from: @"tt://catalog"
              toSharedViewController: [CatalogController class]];
    }
    
    [map            from: @"tt://navRoot"
  toSharedViewController: [DetailDummyViewController class]];

    
    [map            from: @"tt://photoTest1"
                  parent: @"tt://navRoot"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];    

    
    
    [map            from: @"tt://photoTest2"
                  parent: @"tt://navRoot"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];   
    
    [map            from: @"tt://imageTest1"
                  parent: @"tt://navRoot"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];   
    
    [map            from: @"tt://tableTest"
                  parent: @"tt://navRoot"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];   
    
    [map            from: @"tt://tableItemTest"
                  parent: @"tt://navRoot"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];   
    
    [map            from: @"tt://tableControlsTest"
                  parent: @"tt://navRoot"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];   
    
    [map            from: @"tt://styledTextTableTest"
                  parent: @"tt://navRoot"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];   
    
    [map            from: @"tt://tableWithShadow"
                  parent: @"tt://navRoot"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];   
    
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
                  parent: @"tt://navRoot"
        toViewController: [DetailDummyViewController class]
                selector: nil
              transition: 0];
    
        
    // route generic path to web vc
    // [map from:@"*" toViewController:[TTWebController class]];
    
    
    // load detail pane with something...
    /*[navigationCoordinator navigateToPath:@"tt://launcherTest"];
    [navigationCoordinator navigateToPath:@"tt://imageTest2"];*/
    
}

+ (void)initialize{
    instance = [[LVNavigationCoordinator alloc] init];
    [LVNavigationCoordinatorFactory mapApplicationRoutes:instance];
}

+ (LVNavigationCoordinator *)navigationCoordinator{
    return instance;
}

@end
