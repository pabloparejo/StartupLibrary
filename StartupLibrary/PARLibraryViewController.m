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
    self.title = @"StartUp Library";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.model numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.model countForKey:[self.model keyForSection:section]];
}


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
    PARBookViewController *bookVC = [[PARBookViewController alloc] initWithModel:book];
    [self.navigationController pushViewController:bookVC animated:YES];
}

@end
