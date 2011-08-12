//
//  LVNavigationState.h
//
//  Created by Rusty Zarse on 7/14/11.
//  Copyright 2011 LeVous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TTNavigator;

@interface LVNavigationStateItem : NSObject {
    
}
@property(retain, nonatomic) id viewController;
@property(retain, nonatomic) NSString *navigationPath;

/**
 Initializes a new LVNavigationStateItem with the provided path and view controller
 */
+ (LVNavigationStateItem *)stateItemWithNavigationPath:(NSString *)path andViewController:(id)aViewController;
@end

@interface LVNavigationState : NSObject {
    
}

/** Holds the current state for each navigator using navigator as the dictionary key */
@property(retain, nonatomic) NSMutableDictionary *navigationStateDictionary;


/** Searches for the path in the state items registered per navigator.  Returns the first match or nil */
- (LVNavigationStateItem *)navigationStateItemForPath:(NSString *)path;

- (void)recordActivePath:(NSString *)path navigator:(TTNavigator *)navigator viewController:(id)viewController;
@end
