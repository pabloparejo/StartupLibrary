//
//  PARLibraryCollectionViewController.h
//  StartupLibrary
//
//  Created by parejo on 3/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

@import UIKit;
#import "PARLibrary.h"

@class PARLibraryCollectionViewController;

@protocol PARLibraryCollectionViewControllerDelegate <NSObject>

@optional
- (void) libraryViewController:(PARLibraryCollectionViewController *) libraryVC
                 didSelectBook:(PARBook *) book;
@end

@interface PARLibraryCollectionViewController : UICollectionViewController <PARLibraryCollectionViewControllerDelegate>

@property (weak, nonatomic) id<PARLibraryCollectionViewControllerDelegate> delegate;
- (id)initWithModel:(PARLibrary *) library;

@end

