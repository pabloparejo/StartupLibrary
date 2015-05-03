//
//  AppDelegate.m
//  StartupLibrary
//
//  Created by parejo on 1/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "AppDelegate.h"
#import "PARLibraryViewController.h"
#import "PARBookViewController.h"
#import "PARLibrary.h"
#import "UIViewController+Combinators.h"

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
    UIColor *fontColor =[UIColor colorWithRed:36.f/255.f
                                         green:50.f/255.f
                                          blue:63.f/255.f
                                         alpha:1];
    
    UIColor *background = [UIColor colorWithRed:36.f/255.f
                                         green:186.f/255.f
                                          blue:157.f/255.f
                                         alpha:1];
    
    [[UINavigationBar appearance] setBarTintColor:background];
    [[UIBarButtonItem appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[[UITableViewHeaderFooterView appearance] contentView] setBackgroundColor:background];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:fontColor,
                                                           NSFontAttributeName:[UIFont fontWithName:@"UVFFunkydori" size:30]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

# pragma mark - InterfaceIdiom configuration

-(void) configureForIpadWithModel:(PARLibrary *) library{
    PARLibraryViewController *libraryVC = [[PARLibraryViewController alloc] initWithModel:library];
    PARBookViewController *bookVC = [[PARBookViewController alloc] initWithModel:[library bookForKey:[library keyForSection:0] atIndex:0]];
    
    [libraryVC setDelegate:bookVC];
    
    UISplitViewController *splitVC = [UISplitViewController new];
    
    [splitVC setDelegate:bookVC];
    [splitVC setViewControllers:@[[libraryVC wrappedInNavigationController],
                                  [bookVC wrappedInNavigationController]]];
    [self.window setRootViewController:splitVC];
}

-(void) configureForIphoneWithModel:(PARLibrary *) library{
    PARLibraryViewController *libraryVC = [[PARLibraryViewController alloc] initWithModel:library];
    [libraryVC setDelegate:libraryVC];
    [self.window setRootViewController:[libraryVC wrappedInNavigationController]];
}

@end
