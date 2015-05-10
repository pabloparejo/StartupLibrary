//
//  PARLibraryCollectionViewController.m
//  StartupLibrary
//
//  Created by parejo on 3/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARLibraryCollectionViewController.h"
#import "PARBookCollectionViewCell.h"
#import "PARHeaderCollectionReusableView.h"
#import "PARBook.h"
#import "PARBookViewController.h"

#define CELL_ID @"PARBookCollectionViewCell"
#define HEADER_ID @"PARHeaderCollectionReusableView"
#define SELF_TITLE @"Startup Library"

@interface PARLibraryCollectionViewController ()
@property (strong, nonatomic) PARLibrary *model;
@end

@implementation PARLibraryCollectionViewController

-(id) initWithModel:(PARLibrary *)library{
    if (self = [super init]) {
        _model = library;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:CELL_ID bundle:nil]
          forCellWithReuseIdentifier:CELL_ID];
    [self.collectionView registerNib:[UINib nibWithNibName:HEADER_ID bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:HEADER_ID];
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"collection"] tag:0];
    [self.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.model numberOfSections];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.model countForSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PARBookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    PARBook *book = [self.model bookAtIndexPath:indexPath];
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
    
    return cell;
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        PARHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                     withReuseIdentifier:HEADER_ID
                                                                                            forIndexPath:indexPath];
        [header.sectionTitle setText:[self.model titleForSection:indexPath.section]];
        return header;
        
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PARBook *book = [self.model bookAtIndexPath:indexPath];
    
    // Message to delegate
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:)]) {
        [self.delegate libraryViewController:self
                               didSelectBook:book];
    }
}

# pragma mark - PARLibraryViewControllerDelegate

- (void) libraryViewController:(PARLibraryCollectionViewController *)libraryVC didSelectBook:(PARBook *)book{
    PARBookViewController *bookVC = [[PARBookViewController alloc] initWithModel:book];
    [self.navigationController pushViewController:bookVC animated:YES];
}

#pragma mark - Utils

- (void) configureForTabBar{
    self.title = SELF_TITLE;
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"collection"] tag:0];
    [self.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
}

@end
