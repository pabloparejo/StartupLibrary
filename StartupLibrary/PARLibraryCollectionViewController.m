//
//  PARLibraryCollectionViewController.m
//  StartupLibrary
//
//  Created by parejo on 3/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARLibraryCollectionViewController.h"
#import "PARBookCollectionViewCell.h"
#import "PARBook.h"
#import "PARBookViewController.h"
#import "PARSettings.h"

#import "CoreDataCollectionViewController.h"

#define CELL_ID @"PARBookCollectionViewCell"
#define HEADER_ID @"PARHeaderCollectionReusableView"

@interface PARLibraryCollectionViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) PARLibrary *model;
@end

@implementation PARLibraryCollectionViewController
@synthesize collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:CELL_ID bundle:nil]
          forCellWithReuseIdentifier:CELL_ID];

    [self.collectionView setContentInset:UIEdgeInsetsMake(0,0,40,0)];
    [self.collectionView layoutIfNeeded];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PARBookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];

    PARBook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.imageView.image = nil;
    [cell.loading startAnimating];
    if (book.image) {
        [cell.loading stopAnimating];
        cell.imageView.image = book.image;
    }else{
        [book downloadCoverImage:^(void) {
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }];
    }
    cell.titleLabel.text = book.title;
    return cell;
}

/*-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        PARHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                     withReuseIdentifier:HEADER_ID
                                                                                            forIndexPath:indexPath];
        [header.sectionTitle setText:[self.fetchedResultsController titleForSection:indexPath.section]];
        return header;
        
    }
    return nil;
}*/

#pragma mark <UICollectionViewDelegate>

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PARBook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Message to delegate
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:)]) {
        [self.delegate libraryViewController:self
                               didSelectBook:book];
    }
    
    [PARSettings saveLastBookSelected:indexPath];
}

#pragma mark - Utils

- (void) configureForTabBar{
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"collection"] tag:0];
    [self.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
}

@end
