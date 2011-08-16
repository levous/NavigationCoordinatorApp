//
//  LVMainTabBarController.m
//  NavigationCoordinatorApp
//
//  Created by Rusty Zarse on 8/11/11.
//  Copyright 2011 LeVous, LLC. All rights reserved.
//

#import "LVMainTabBarController.h"
#import <Three20/Three20+Additions.h>

@implementation LVMainTabBarController


- (void)viewDidLoad{
    [self setTabURLs:[NSArray arrayWithObjects:
                      @"tt://splitview", 
                      @"tt://anotherTab",
                      nil]];
}


@end
