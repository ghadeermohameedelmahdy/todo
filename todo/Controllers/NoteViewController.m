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
        [_statusOutlet setHidden:NO];
        [_statusLbl setHidden:NO];
        if(_todo.status == 1){
            [_statusOutlet setSelectedSegmentIndex:0];
            [_statusOutlet setSelectedSegmentTintColor:UIColor.yellowColor];
            [_statusOutlet setEnabled:NO forSegmentAtIndex:1];
        }else  if(_todo.status == 2){
             [_statusOutlet setSelectedSegmentIndex:1];
            [_statusOutlet setSelectedSegmentTintColor:UIColor.greenColor];
            [_statusOutlet setEnabled:NO forSegmentAtIndex:0];
        }
        
    }else{
        _todo = [TODO new];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
           [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
             currentDate = [NSDate date];
           _dateCreationLbl.text = [dateFormatter stringFromDate:currentDate];
        [_statusOutlet setHidden:YES];
         [_statusLbl setHidden:YES];
    }
}


- (IBAction)dateAction:(UIDatePicker *)sender {
}

- (IBAction)alarmBtn:(UIButton *)sender {
    _localNotification  = [[UNMutableNotificationContent alloc] init];
    _localNotification.title = [NSString localizedUserNotificationStringForKey:@"Time Down!" arguments:nil];
    _localNotification.body = [NSString localizedUserNotificationStringForKey:@"Your notification is arrived!"
                                                                   arguments:nil];
    _localNotification.sound = [UNNotificationSound defaultSound];
    
    // 1. set trigger
    //----------------------------
    // Deliver the notification with date:
    //-------------------------------------
    //NSDate *myDate = [NSDate dateWithTimeIntervalSinceNow:1000];
    // NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:myDate];
    //UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:NO];
    
    // Deliver the notification in seconds
    //-------------------------------------
     UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                   triggerWithTimeInterval:5 repeats:NO];

    // 2. set icon badge to +1
    //------------------------
    _localNotification.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber] + 1);
    
    // 3. schedule localNotification
    //------------------------------
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Time Down"
                                                                          content:_localNotification trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Add NotificationRequest succeeded!");
        }
    }];
    [[[UIApplication sharedApplication] delegate] application:[UIApplication sharedApplication] didReceiveRemoteNotification:center fetchCompletionHandler:nil];

}
- (IBAction)addBtnAction:(UIButton *)sender {
    if([_addOutlet.titleLabel.text isEqual:@"Add"]){
        if([_titleNote.text isEqual:@""] || [_descNote.text isEqual:@""]){
           [ self showErrorMessage:@"Data is missing!" :@"Title & Description fields are required to add TODO!"];
        }else{
            _todo.todoID = [model generateID];
            _todo.status = 0;
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
   _todo.status = sender.selectedSegmentIndex + 1;
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
     _todo.creationDate = currentDate;
}

@end

