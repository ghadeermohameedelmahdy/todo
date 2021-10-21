//
//  NoteViewController.h
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+alert.h"
#import "Delegate.h"
#import "TODO.h"
#import "Model.h"
#import <UserNotifications/UserNotifications.h>
@interface NoteViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
//Actions
- (IBAction)dateAction:(UIDatePicker *)sender;
- (IBAction)alarmBtn:(UIButton *)sender;
-(IBAction)addBtnAction:(UIButton *)sender;
- (IBAction)cancelBtn:(UIButton *)sender;
- (IBAction)status:(UISegmentedControl *)sender;
//Outlets
@property (weak, nonatomic) IBOutlet UIDatePicker *dateOutlet;

@property (weak, nonatomic) IBOutlet UITextField *titleNote;

@property (weak, nonatomic) IBOutlet UITextField *descNote;
@property (weak, nonatomic) IBOutlet UIPickerView *priorityPicker;
@property (weak, nonatomic) IBOutlet UIButton *addOutlet;

@property (weak, nonatomic) IBOutlet UILabel *dateCreationLbl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statusOutlet;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

//Properties
@property id<Delegate> viewController;
@property BOOL isEdit;
@property TODO* todo;
@property (strong,nonatomic) UNMutableNotificationContent * localNotification ;

@end


