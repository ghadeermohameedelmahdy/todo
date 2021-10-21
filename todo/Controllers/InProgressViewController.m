//
//  InProgressViewController.m
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import "InProgressViewController.h"
#import "NoteViewController.h"

@interface InProgressViewController ()

@end

@implementation InProgressViewController

{
    NoteViewController* noteController ;
    Model* model;
    NSMutableArray* arraySearch;
    NSMutableArray* allData;
    NSMutableArray* inprogress;
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
    inprogress = [NSMutableArray new];

    [self refereshTable];
}


#pragma mark - table view delegate methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return [inprogress count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"inprogresscell"];
    TODO* todo = [inprogress objectAtIndex:indexPath.row ];
    NSString* img;
    if(todo.priority == 0)
          img = @"low.png";
    else  if(todo.priority == 1)
           img = @"med.png";
    else  if(todo.priority == 2)
           img = @"high.png";
    cell.textLabel.text = todo.title;
    cell.detailTextLabel.text = todo.desc;
     cell.imageView.image = [UIImage imageNamed:img];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   NSString* title;
     if([inprogress count] ==0){
         title = @" No TODOs to show !";
     }
     else{
         title=@"INPROGRESS TODOs";
     }
     return title;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
       TODO* todo = [self->inprogress objectAtIndex:indexPath.row];
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
                               [self->inprogress removeObject:todo];
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
    [inprogress removeAllObjects];
  
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
                        [inprogress addObject:todo];
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
    [inprogress removeAllObjects];
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
             if(todo.status == 1)
               [ inprogress addObject:todo];
         }
    [arraySearch addObjectsFromArray:inprogress];
}

-(void) refereshTable{
    [_tableView reloadData];
}

@end
