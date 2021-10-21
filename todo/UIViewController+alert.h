//
//  UIViewController+alert.h
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (alert)
-(UIAlertController*) showConfirmMessage :(NSString*) titleMsg :(NSString*) msg;
-(void) showErrorMessage :(NSString*) titleMsg :(NSString*) msg;
@end

NS_ASSUME_NONNULL_END
