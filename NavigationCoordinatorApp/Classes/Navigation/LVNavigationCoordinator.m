//
//  LVNavigationCoordinator.m
//  NavigationCoordinatorApp
//
//  Created by Rusty Zarse on 7/25/11.
//  Copyright 2011 LeVous, LLC. All rights reserved.
//

#import "LVNavigationCoordinator.h"
#import "Three20/Three20.h"
#import "LVNavigationState.h"

static int navigator_key_count = 1;

@interface LVNavigationCoordinator (Private) 
- (void)setupNavigators; 
- (TTNavigator *)normalizeNavigator:(TTNavigator *)navigator;
@end


@implementation LVNavigationCoordinator
@synthesize defaultURLMap, defaultStartUpPath, registeredNavigators, activeNavigationState;

#pragma mark - init and dealloc

- (void)dealloc{
    TT_RELEASE_SAFELY(rootViewController);
    [super dealloc];
}

- (id)init{
    if ((self = [super init])) {
        TTNavigator* navigator = [self normalizeNavigator:[TTNavigator navigator]];
        navigator.supportsShakeToReload = YES;
        navigator.persistenceMode = TTNavigatorPersistenceModeAll;
        // provide the default map for convenience and simplicity
        [self setDefaultURLMap:navigator.URLMap];
        // create the set to hold navigators
        [self setRegisteredNavigators:[NSMutableSet set]];
        // register the first, root navigator
        //TODO: since the state class will retain the navigators used as 
        //  activeNavigationStateItem keys,
        //  this needs to be proxied through registerNavigator and unRegisterNavigator 
        //  methods so that the state can be discarded as well.  Also, ensure persistence key is set
        [[self registeredNavigators] addObject:navigator];
        // initialize empty state
        [self setActiveNavigationState:[[[LVNavigationState alloc] init] autorelease]];
        
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
- (void)setupNavigators {
    
}

- (TTNavigator *)normalizeNavigator:(TTNavigator *)navigator{
    if ([navigator persistenceKey] == nil) {
        [navigator setPersistenceKey:[NSString stringWithFormat:@"navigator%i", ++navigator_key_count]];
    }
    
    return navigator;
}

- (void)wireNavigatorsFromSplitView:(TTSplitViewController *)splitView{
    [[self registeredNavigators] addObject:[self normalizeNavigator:[splitView secondaryNavigator]]];
    [[self registeredNavigators] addObject:[self normalizeNavigator:[splitView primaryNavigator]]];
    [self setupNavigators];
}

#pragma mark - TTNavigator delegation



#pragma mark - Path Navigation


- (UIViewController *)navigateWithURLAction:(TTURLAction *)urlAction{
    __block BOOL mapped = NO;
    __block UIViewController *mappedViewController = nil;
    __block TTNavigator *mappedNavigator;
    // enumerate the registered navigators, the first one that handles the url action wins
    [[self registeredNavigators] enumerateObjectsUsingBlock:^(id navigator, BOOL *stop) {
        // try to navigate using the navigator
        mappedViewController = [navigator openURLAction:urlAction];
        // if a viewcontroller was loaded, sweet!  
        if (mappedViewController) {
            *stop = YES;
            mapped = YES;
            mappedNavigator = (TTNavigator *)navigator;
        }
    }];
    
    if(mapped){
        // set new active nav state
        [[self activeNavigationState] recordActivePath:[urlAction urlPath] navigator:mappedNavigator viewController:mappedViewController];
    }
    
    return mappedViewController;
}

- (BOOL)navigateToPath:(NSString *)path{
    // call through to overload passing nil for data dictionary
    return [self navigateToPath:path withDataDictionary:nil];
}

- (BOOL)navigateToPath:(NSString *)path withDataDictionary:(NSDictionary *)data{
    // set up TTURLAction with path, data dictionary and standard animated transition
	TTURLAction *urlAction = [[[TTURLAction actionWithURLPath:path] applyQuery:data] applyAnimated:YES];
    // navigate, capturing the mapped view controller
    
    // which navigator should handle this path
	UIViewController *mappedViewController = [self navigateWithURLAction:urlAction];
    // verify successful map.  Return false on failure (could return an error through an out param to be Cocoa stylish)
    if(!mappedViewController){
        NSLog(@"No view controller matches path: %@", path);
        return NO;
    }
    
    // if we choose to raise a nav notification, this would be the place
    // return success
    return YES;
}


#pragma mark - Present first screen

- (void)presentFirstScreen{
    // load default startup path
    [self navigateToPath:[self defaultStartUpPath]];
    
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

#pragma mark - Handle External URL

- (BOOL)handleOpenURL:(NSURL *)URL{
    // this should prolly check first
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
    return YES;
}


@end
