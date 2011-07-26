//
//  LVNavigationCoordinator.m
//  NavigationCoordinatorApp
//
//  Created by Rusty Zarse on 7/25/11.
//  Copyright 2011 LeVous, LLC. All rights reserved.
//

#import "LVNavigationCoordinator.h"
#import "Three20/Three20.h"

@interface LVNavigationCoordinator (Private) 
- (void)setupNavigators; 
@end


@implementation LVNavigationCoordinator
@synthesize defaultURLMap, defaultStartUpPath, masterPaneNavigator, detailPaneNavigator;

#pragma mark - init and dealloc

- (void)dealloc{
    TT_RELEASE_SAFELY(rootViewController);
    [super dealloc];
}

- (id)init{
    if ((self = [super init])) {
        TTNavigator* navigator = [TTNavigator navigator];
        navigator.supportsShakeToReload = YES;
        navigator.persistenceMode = TTNavigatorPersistenceModeAll;
        // provide the default map for convenience and simplicity
        [self setDefaultURLMap:navigator.URLMap];
    }
    return self;
}

#pragma mark - Class initialization

- (void)configureRootViewController{
    rootViewController = [[TTRootViewController alloc] init];
    [[TTNavigator navigator].window addSubview:rootViewController.view];
    [TTNavigator navigator].rootContainer = rootViewController;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setupMasterPaneNavigator {
    TTURLMap* map = self.masterPaneNavigator.URLMap;
    
    // Forward all unhandled URL actions to the detail navigator.
    [map              from: @"*"
                  toObject: self
                  selector: @selector(openDetailPaneURLAction:)];
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setupDetailPaneNavigator {
    TTURLMap* map = self.detailPaneNavigator.URLMap;
    
    // any unhandled route will attempt a web url
    [map                    from: @"*"
                toViewController: [TTWebController class]];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setupNavigators {
    [self setupDetailPaneNavigator];
    [self setupMasterPaneNavigator];
}

- (void)wireNavigatorsToSplitView:(TTSplitViewController *)splitView{
    [self setMasterPaneNavigator:[splitView secondaryNavigator]];
    [self setDetailPaneNavigator:[splitView primaryNavigator]];
    [self setupNavigators];
}

#pragma mark - TTNavigator delegation

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)openDetailPaneURLAction:(NSURL*)url {
    [[self detailPaneNavigator] setRootViewController:nil];
    [[self detailPaneNavigator] openURLAction:[TTURLAction actionWithURLPath:url.absoluteString]];
}

#pragma mark - Present first screen

- (void)presentFirstScreen{
    // load default startup path
    [[self masterPaneNavigator] openURLs:[self defaultStartUpPath], nil];
    
    /*********************
     RZ 2011-07-25
       More testing needed prior to removing this completely.  It was in the sample but may not be necessary.
       If tested thoroughly, remove this and the configureRootViewController method 
    *********************/
    //[self configureRootViewController];
    
    TTNavigator* navigator = [TTNavigator navigator];
    if (TTIsPad() || ![navigator restoreViewControllers]) {
        [navigator openURLAction:[TTURLAction actionWithURLPath:[self defaultStartUpPath]]];
    }
    
    [rootViewController showController: navigator.rootViewController
                            transition: UIViewAnimationTransitionNone
                              animated: NO];

}


@end
