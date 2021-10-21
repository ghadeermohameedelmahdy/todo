//
//  UIViewController+alert.m
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import "UIViewController+alert.h"



@implementation UIViewController (alert)
-(UIAlertController*) showConfirmMessage : (NSString*) titleMsg :(NSString*) msg{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:titleMsg
                               message:msg
                               preferredStyle:UIAlertControllerStyleAlert];

//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault
//                                   handler:^(UIAlertAction * action) {
//        
//    }];
//     [alert addAction:defaultAction];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                      handler:^(UIAlertAction * action) {
        [self dismissViewControllerAnimated:true completion:nil];
    }];
   
    [alert addAction:cancelAction];
    return alert;
}
-(void) showErrorMessage :(NSString*) titleMsg :(NSString*) msg{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:titleMsg
                                  message:msg
                                  preferredStyle:UIAlertControllerStyleAlert];

       UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                             handler:nil];
       [alert addAction:defaultAction];
    [self presentViewController:alert animated:true completion:nil];
    
}
@end
