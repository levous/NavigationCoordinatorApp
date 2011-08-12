//
//  LVNavigationCoordinatorTests.m
//  NavigationCoordinatorApp
//
//  Created by Rusty Zarse on 8/11/11.
//  Copyright 2011 LeVous, LLC. All rights reserved.
//

#import "LVNavigationCoordinatorTests.h"
#import "LVNavigationCoordinator.h"
#import "LVTestNavigationCoordinatorFactory.h"
#import "LVNavigationState.h"
#import "CatalogController.h"

@implementation LVNavigationCoordinatorTests

- (void)test_lvNavCoordinator_loads_tab{
    // given a path
    NSString *tabPath = @"navApp://catalog";
    LVNavigationCoordinator *coordinator = [LVTestNavigationCoordinatorFactory defaultTestNavigationCoordinator];
    [coordinator navigateToPath:tabPath];
    LVNavigationState *currentState = [coordinator activeNavigationState];
    LVNavigationStateItem *mappedStateItem = [currentState navigationStateItemForPath:tabPath];
    
    STAssertEquals([CatalogController class], [[mappedStateItem viewController] class], @"HMM");
    
    

}

@end