//
//  NoteViewController.m
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import "NoteViewController.h"



@interface NoteViewController ()

@end

@implementation NoteViewController
{
    NSArray* priorityLevels ;
    Model* model;
    NSDate* currentDate ;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    model = [[Model alloc] init];
    priorityLevels = @[@"Low",@"Meduim",@"High"];
    _priorityPicker.delegate = self;
    _priorityPicker.dataSource = self;
    if(_isEdit == YES){
        [_addOutlet setTitle:@"Edit" forState:UIControlStateNormal];
        [_priorityPicker selectRow:_todo.priority inComponent:0 animated:true];
        [_titleNote setText:_todo.title];
        [_descNote setText:_todo.desc];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        _dateCreationLbl.text = [dateFormatter stringFromDate:_todo.creationDate];
        
    }else{
        _todo = [TODO new];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
           [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
             currentDate = [NSDate date];
           _dateCreationLbl.text = [dateFormatter stringFromDate:currentDate];
    }
}


- (IBAction)alarmBtn:(UIButton *)sender {
}
- (IBAction)addBtnAction:(UIButton *)sender {
    if([_addOutlet.titleLabel.text isEqual:@"Add"]){
        if([_titleNote.text isEqual:@""] || [_descNote.text isEqual:@""]){
           [ self showErrorMessage:@"Data is missing!" :@"Title & Description fields are required to add TODO!"];
        }else{
            _todo.todoID = [model generateID];
            [self setTODOData];
            [model addTODO:_todo];
            [self dismissViewControllerAnimated:true completion:^{
                [self->_viewController refereshTable];
            }];
        }
    }else if([_addOutlet.titleLabel.text isEqual:@"Edit"]){
       
      UIAlertController* alert = [self showConfirmMessage: @"Edit TODO" : @"Do you confirm to edit it?" ];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
               [self setTODOData];
                [self->model editTODO:self->_todo];
               [self dismissViewControllerAnimated:true completion:^{
                             [self->_viewController refereshTable];
                         }];
                 
            }];
             [alert addAction:defaultAction ];
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (IBAction)cancelBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)status:(UISegmentedControl *)sender {
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [priorityLevels count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [priorityLevels objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _todo.priority = row;
}

-(void) setTODOData {
     
     _todo.desc = _descNote.text;
     _todo.title = _titleNote.text;
     _todo.complitionDate = nil;
     _todo.status = 0;
     _todo.creationDate = currentDate;
}
@end
