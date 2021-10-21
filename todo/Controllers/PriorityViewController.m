//
//  PriorityViewController.m
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import "PriorityViewController.h"
#import "NoteViewController.h"
@interface PriorityViewController ()

@end

@implementation PriorityViewController
{
    NoteViewController* noteController ;
    Model* model;
    NSMutableArray* arraySearch;
    NSMutableArray* allData;
    NSMutableArray* lowPrio;
    NSMutableArray* highPrio;
    NSMutableArray* medPrio;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   //model
    model = [[Model alloc] init];
    arraySearch = [NSMutableArray new];
    _searchBar.delegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    lowPrio = [NSMutableArray new];
    medPrio= [NSMutableArray new];
    highPrio= [NSMutableArray new];
    [self refereshTable];
}

- (IBAction)addBarBtn:(id)sender {
    noteController = [[self storyboard] instantiateViewControllerWithIdentifier:@"note"];
    lowPrio = [NSMutableArray new];
    medPrio= [NSMutableArray new];
    highPrio= [NSMutableArray new];
    noteController.isEdit = NO;
    noteController.modalPresentationStyle = UIModalPresentationPopover;
    noteController.viewController = self;
    
    [self presentViewController:noteController animated:true completion:nil];
}

#pragma mark - table view delegate methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
           return [highPrio count];
       else  if(section == 1)
             return [medPrio count];
       else  if(section == 2)
              return [lowPrio count];
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"prioritycell"];
    
          TODO* todo ;
          switch (indexPath.section) {
              case 0:
                  todo = [highPrio objectAtIndex:indexPath.row];
                  break;
              case 1:
                  todo = [medPrio objectAtIndex:indexPath.row];
                  break;
              case 2:
                  todo = [lowPrio objectAtIndex:indexPath.row];
                  break;
              default:
                  break;
          }
    cell.textLabel.text = todo.title;
    cell.detailTextLabel.text = todo.desc;
   
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString* title;
   
    switch (section) {
              case 0:
               title = @"High Priority";
                  break;
              case 1:
               title = @"Meduim Priority";
                  break;
              case 2:
               title = @"Low Priority";
                  break;
               default:
               break;
          }
    return title;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
       TODO* todo = [self->allData objectAtIndex:indexPath.row];
       UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
           self->noteController = [[self storyboard] instantiateViewControllerWithIdentifier:@"note"];
           self->noteController.isEdit = YES;
           self->noteController.todo = todo;
           self->noteController.modalPresentationStyle = UIModalPresentationPopover;
           self->noteController.viewController = self;
           [self presentViewController:self->noteController animated:true completion:nil];
       }];
       editAction.backgroundColor = [UIColor blueColor];
 UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
            UIAlertController* alert = [self showConfirmMessage: @"Delete TODO" : @"Do you confirm to delete it?" ];
                           UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * action) {
                              
                               [self->model removeTODO: todo.todoID];
                               [self->allData removeObject:todo];
                               [self->_tableView reloadData];
                                
                           }];
                       [alert addAction:defaultAction ];
                       [self presentViewController:alert animated:true completion:nil];
       }];
       deleteAction.backgroundColor = [UIColor redColor];
return @[deleteAction,editAction];
}

#pragma mark - search bar delegate methods
- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    [arraySearch filterUsingPredicate:resultPredicate];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterContentForSearchText:searchText];
    [allData removeAllObjects];
    [lowPrio removeAllObjects];
    [medPrio removeAllObjects];
    [highPrio removeAllObjects];
        TODO* todo;
        NSString *title = @"";
        if ([searchText length] > 0)
        {

            for (int i = 0; i < [arraySearch count] ; i++)
            {
                todo=[arraySearch objectAtIndex:i];
                title= todo.title;
                if (title.length >= searchText.length)
                {
                    NSRange titleResultsRange = [title rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    if (titleResultsRange.length > 0)
                    {
                                 if(todo.priority == 0)
                                   [ lowPrio addObject:todo];
                                 else  if(todo.priority == 1)
                                     [medPrio addObject:todo];
                               else  if(todo.priority == 2)
                                      [highPrio addObject:todo];
                              [allData addObject:todo];
                             }
                }
            }
        }else{
            [self loadDataFromModel];
        }
        [_tableView reloadData];
   
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder ];
    [_tableView reloadData];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [allData removeAllObjects];
    [highPrio removeAllObjects];
    [lowPrio removeAllObjects];
    [medPrio removeAllObjects];
    [self loadDataFromModel];
    [_tableView reloadData];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void) loadDataFromModel{
    allData = [model getAllTODO];
    for(int i=0;i< [allData count] ; i++){
      TODO* todo = [allData objectAtIndex:i];
          if(todo.priority == 0)
            [ lowPrio addObject:todo];
          else  if(todo.priority == 1)
              [medPrio addObject:todo];
        else  if(todo.priority == 2)
               [highPrio addObject:todo];
      }
    [arraySearch addObjectsFromArray:allData];
}

-(void) refereshTable{
    [self loadDataFromModel];
    [_tableView reloadData];
}


@end

