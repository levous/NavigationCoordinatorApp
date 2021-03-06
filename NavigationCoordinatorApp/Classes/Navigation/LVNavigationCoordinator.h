//
//  LVNavigationCoordinator.h
//  NavigationCoordinatorApp
//
//  Created by Rusty Zarse on 7/25/11.
//  Copyright 2011 LeVous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@class LVNavigationState, LVNavigationStateItem;

@interface LVNavigationCoordinator : NSObject<TTNavigatorDelegate> {
}

@property(retain, nonatomic) NSMutableSet *registeredNavigators;
@property(assign, nonatomic) TTURLMap *defaultURLMap;
@property(retain, nonatomic) NSArray *defaultStartUpPaths;
@property(retain, nonatomic) LVNavigationState *activeNavigationState;
@property(retain, nonatomic) NSMutableDictionary *pathHandlers;


- (void)wireNavigatorsFromSplitView:(TTSplitViewController *)splitView;
- (void)presentFirstScreen;
- (BOOL)handleOpenURL:(NSURL *)URL;

#pragma mark - Path Navigation

/** Navigates the application using the provided path */
- (BOOL)navigateToPath:(NSString *)path;
/** Navigates the application using the provided path, passing the data dictionary to mapped the view controller*/
- (BOOL)navigateToPath:(NSString *)path withDataDictionary:(NSDictionary *)data;

@end
