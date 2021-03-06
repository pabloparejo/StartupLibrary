//
//  PARLibraryViewController.m
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARLibraryTableViewController.h"
#import "PARBook.h"
#import "PARBookViewController.h"
#import "PARBookTableViewCell.h"
#import "PARSettings.h"


#define CELL_ID @"PARBookTableViewCell"


@interface PARLibraryTableViewController ()
@property (strong, nonatomic) PARLibrary *model;
@end

@implementation PARLibraryTableViewController

- (id)initWithModel:(PARLibrary *) library{
    if (self = [super init]) {
        _model = library;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNibs];
    //[self.tableView setContentInset:UIEdgeInsetsMake(60,0,50,0)];
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableViewDelegate
- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PARBook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Creamos la celda
    PARBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    cell.bookImage.image = nil;
    [cell.loading startAnimating];
    if (book.image) {
        [cell.loading stopAnimating];
        cell.bookImage.image = book.image;
    }else{
        [book downloadCoverImage:^(void) {
            [self.tableView reloadData];
        }];
    }

    cell.titleLabel.text = book.title;
    cell.author.text = book.author;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PARBook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Message to delegate
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:)]) {
        [self.delegate libraryViewController:self
                               didSelectBook:book];
    }
    
    [PARSettings saveLastBookSelected:book.objectId];
}

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.textColor = [UIColor colorWithRed:36.f/255.f
                                                 green:50.f/255.f
                                                  blue:63.f/255.f
                                                 alpha:1];
}


-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 141;
}

#pragma mark - Utils

-(void) registerNibs{
    UINib *nib = [UINib nibWithNibName:CELL_ID bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CELL_ID];
}

- (void) configureForTabBar{
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"list"] tag:0];
    [self.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
}

@end
