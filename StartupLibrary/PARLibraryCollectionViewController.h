//
//  PARLibraryCollectionViewController.h
//  StartupLibrary
//
//  Created by parejo on 3/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import UIKit;
#import "PARLibrary.h"
#import "PARLibraryViewControllerDelegate.h"
@interface PARLibraryCollectionViewController : UIViewController <  PARLibraryViewControllerDelegate,
                                                                    UICollectionViewDataSource,
                                                                    UICollectionViewDelegate>

@property (weak, nonatomic) id<PARLibraryViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (id)initWithModel:(PARLibrary *) library;
- (void) configureForTabBar;
@end

