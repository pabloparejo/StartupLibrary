//
//  PARLibraryCollectionViewController.h
//  StartupLibrary
//
//  Created by parejo on 3/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import UIKit;
#import "PARLibraryViewControllerDelegate.h"
#import "CoreDataCollectionViewController.h"
@interface PARLibraryCollectionViewController : CoreDataCollectionViewController <UICollectionViewDelegate>


@property (weak, nonatomic) id<PARLibraryViewControllerDelegate> delegate;

- (void) configureForTabBar;
@end

