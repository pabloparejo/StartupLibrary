//
//  PARNotesViewController.m
//  
//
//  Created by Pablo Parejo Camacho on 14/8/15.
//
//

#import "PARNotesViewController.h"
#import "PARNote.h"

#define CELL_ID @"default"

@interface PARNotesViewController ()

@end

@implementation PARNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDelegate
- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PARNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Creamos la celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    cell.textLabel.text = note.text;
    
    return cell;
}

/*- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PARBook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Message to delegate
    if ([self.delegate respondsToSelector:@selector(libraryViewController:didSelectBook:)]) {
        [self.delegate libraryViewController:self
                               didSelectBook:book];
    }
    
    [PARSettings saveLastBookSelected:indexPath];
}*/


@end
