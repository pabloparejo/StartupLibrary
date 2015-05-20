//
//  PARLibraryTabController.m
//  StartupLibrary
//
//  Created by Pablo Parejo Camacho on 19/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARLibraryTabController.h"
#import "PARBookViewController.h"

@implementation PARLibraryTabController


# pragma mark - PARLibraryViewControllerDelegate

-(instancetype) init{
    if (self = [super init]) {
        self.title = @"Startup Library";
    }
    return self;
}

- (void) libraryViewController:(UIViewController *)libraryVC didSelectBook:(PARBook *)book{
    PARBookViewController *bookVC = [[PARBookViewController alloc] initWithModel:book];
    [self.navigationController pushViewController:bookVC animated:YES];
}

@end
