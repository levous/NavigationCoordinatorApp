//
//  LVNavigationState.m//
//  Created by Rusty Zarse on 7/14/11.
//  Copyright 2011 LeVous, LLC Corporation. All rights reserved.
//

#import "LVNavigationState.h"
#import <Three20/Three20.h>

@implementation LVNavigationStateItem
@synthesize viewController, navigationPath;
+ (LVNavigationStateItem *)stateItemWithNavigationPath:(NSString *)path andViewController:(id)aViewController{
    LVNavigationStateItem *item = [[[LVNavigationStateItem alloc] init] autorelease];
    [item setNavigationPath:path];
    [item setViewController:aViewController];
    return item;
}

@end

@implementation LVNavigationState

@synthesize navigationStateDictionary;

- (void)dealloc{
    TT_RELEASE_SAFELY(navigationStateDictionary);
    [super dealloc];
}

- (id)init{
    if ((self = [super init])){
        navigationStateDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)recordActivePath:(NSString *)path navigator:(TTNavigator *)navigator viewController:(id)viewController{
    LVNavigationStateItem *item = [LVNavigationStateItem stateItemWithNavigationPath:path andViewController:viewController];
    [[self navigationStateDictionary] setObject:item forKey:[navigator persistenceKey]];
}

- (LVNavigationStateItem *)navigationStateItemForPath:(NSString *)path{
    for(NSString *key in [[self navigationStateDictionary] allKeys]){
        LVNavigationStateItem *item = [[self navigationStateDictionary] objectForKey:key];
        if([[item navigationPath] compare:path] == NSOrderedSame){
            return item;
        }
    }
    return nil;
}


@end
