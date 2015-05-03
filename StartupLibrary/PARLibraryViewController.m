//
//  PARLibraryViewController.m
//  StartupLibrary
//
//  Created by parejo on 2/5/15.
//  Copyright (c) 2015 PabloParejo. All rights reserved.
//

#import "PARLibraryViewController.h"
#import "PARBook.h"
#import "PARBookViewController.h"

#define SELF_TITLE @"Startup Library"

@interface PARLibraryViewController ()
@property (strong, nonatomic) PARLibrary *model;
@end

@implementation PARLibraryViewController

- (id)initWithModel:(PARLibrary *) library{
    if (self = [super init]) {
        _model = library;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SELF_TITLE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.model numberOfSections];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.model keyForSection:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.model countForKey:[self.model keyForSection:section]];
}



#pragma mark - TableViewDelegate
- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PARBook *book = [self.model bookForKey:[self.model keyForSection:indexPath.section] atIndex:indexPath.row];
    // Creamos la celda
    static NSString *cellId = @"BookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellId];
    }

    cell.textLabel.text= book.title;
    cell.detailTextLabel.text = book.author;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PARBook *book = [self.model bookForKey:[self.model keyForSection:indexPath.section] atIndex:indexPath.row];
    
    // Message to delegate
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:)]) {
        [self.delegate libraryViewController:self
                               didSelectBook:book];
    }
}

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.textColor = [UIColor colorWithRed:36.f/255.f
                                                 green:50.f/255.f
                                                  blue:63.f/255.f
                                                 alpha:1];
}

# pragma mark - PARLibraryViewControllerDelegate

- (void) libraryViewController:(PARLibraryViewController *)libraryVC didSelectBook:(PARBook *)book{
    PARBookViewController *bookVC = [[PARBookViewController alloc] initWithModel:book];
    [self.navigationController pushViewController:bookVC animated:YES];
}

@end
