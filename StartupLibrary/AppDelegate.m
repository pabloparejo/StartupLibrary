//
//  AppDelegate.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "AppDelegate.h"
#import "PARLibraryTableViewController.h"
#import "PARLibraryCollectionViewController.h"
#import "PARBookViewController.h"
#import "PARLibrary.h"
#import "UIViewController+Combinators.h"
#import "PARSettings.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    PARLibrary *library = [PARLibrary new];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self configureForIpadWithModel:library];
    }else{
        [self configureForIphoneWithModel:library];
    }
    
    [self configureAppearance];
    [self.window makeKeyAndVisible];
    return YES;
}

# pragma mark - Appearance
-(void) configureAppearance{
    UIColor *background =[UIColor colorWithRed:3.f/255.f
                                         green:6.f/255.f
                                          blue:18.f/255.f
                                         alpha:1];

    
    [[UINavigationBar appearance] setBarTintColor:background];
    [[UIBarButtonItem appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont fontWithName:@"UVFFunkydori" size:30]}];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:38.f/255.f green:173.f/255.f blue:138.f/255.f alpha:1]];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

# pragma mark - TabBarItems


# pragma mark - InterfaceIdiom configuration


-(void) configureForIpadWithModel:(PARLibrary *) library{
    PARLibraryTableViewController *libraryTableVC = [[PARLibraryTableViewController alloc] initWithModel:library];
    PARLibraryCollectionViewController *libraryCollectionVC = [[PARLibraryCollectionViewController alloc] initWithModel:library];
    
    PARBookViewController *bookVC = [[PARBookViewController alloc] initWithModel:[self lastBookSelectedInModel:library]];
    
    [libraryTableVC setDelegate:bookVC];
    [libraryCollectionVC setDelegate:bookVC];
    
    UITabBarController *tabVC = [UITabBarController new];
    [tabVC setViewControllers:@[[libraryTableVC wrappedInNavigationController], [libraryCollectionVC wrappedInNavigationController]] animated:NO];
    
    [libraryCollectionVC configureForTabBar];
    [libraryTableVC configureForTabBar];

    
    UISplitViewController *splitVC = [UISplitViewController new];
    
    [splitVC setDelegate:bookVC];
    [splitVC setViewControllers:@[tabVC,
                                  [bookVC wrappedInNavigationController]]];
    [self.window setRootViewController:splitVC];
}

-(void) configureForIphoneWithModel:(PARLibrary *) library{
    PARLibraryTableViewController *libraryTableVC = [[PARLibraryTableViewController alloc] initWithModel:library];
    PARLibraryCollectionViewController *libraryCollectionVC = [[PARLibraryCollectionViewController alloc] initWithModel:library];
    
    [libraryCollectionVC configureForTabBar];
    [libraryTableVC configureForTabBar];
    
    [libraryTableVC setDelegate:libraryTableVC];
    [libraryCollectionVC setDelegate:libraryCollectionVC];
    
    UITabBarController *tabVC = [UITabBarController new];
    [tabVC setViewControllers:@[[libraryTableVC wrappedInNavigationController], [libraryCollectionVC wrappedInNavigationController]] animated:NO];
    [self.window setRootViewController:tabVC];
}

#pragma mark - User Defaults
-(PARBook *) lastBookSelectedInModel: (PARLibrary *)model{
    
    NSIndexPath *indexPath = [PARSettings indexPathForLastBookSelected];
    if (!indexPath) {
        // User has open the app for the first time
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [PARSettings saveLastBookSelected:indexPath];
    }
    
    return [model bookAtIndexPath:indexPath];
}

@end
