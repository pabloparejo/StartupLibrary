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
#import "PARLibraryTabController.h"

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
    
    PARLibraryTabController *tabVC = [PARLibraryTabController new];

    [tabVC setViewControllers:@[libraryCollectionVC, libraryTableVC] animated:NO];
    
    [libraryCollectionVC configureForTabBar];
    [libraryTableVC configureForTabBar];

    
    UISplitViewController *splitVC = [UISplitViewController new];
    
    [splitVC setDelegate:bookVC];
    [splitVC setViewControllers:@[[tabVC wrappedInNavigationController],
                                  [bookVC wrappedInNavigationController]]];
    [self.window setRootViewController:splitVC];
}

-(void) configureForIphoneWithModel:(PARLibrary *) library{
    PARLibraryTableViewController *libraryTableVC = [[PARLibraryTableViewController alloc] initWithModel:library];
    PARLibraryCollectionViewController *libraryCollectionVC = [[PARLibraryCollectionViewController alloc] initWithModel:library];
    
    [libraryCollectionVC configureForTabBar];
    [libraryTableVC configureForTabBar];
    
    PARLibraryTabController *tabVC = [PARLibraryTabController new];
    
    [libraryTableVC setDelegate:tabVC];
    [libraryCollectionVC setDelegate:tabVC];
    
    [tabVC setViewControllers:@[libraryCollectionVC, libraryTableVC] animated:NO];
    [self.window setRootViewController:[tabVC wrappedInNavigationController]];
}

#pragma mark - User Defaults
-(PARBook *) lastBookSelectedInModel: (PARLibrary *)model{
    
    NSIndexPath *indexPath = [PARSettings indexPathForLastBookSelected];
    if (!indexPath) {
        // User has open the app for the first time
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [PARSettings saveLastBookSelected:indexPath];
    }
    
    PARBook *book = [model bookAtIndexPath:indexPath];
    return book;
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.utad.Everpobre" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Everpobre" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Everpobre.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
