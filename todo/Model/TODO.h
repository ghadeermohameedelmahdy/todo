//
//  TODO.h
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TODO : NSObject<NSCoding>
@property int todoID ;
@property NSString *title;
@property NSString * desc;
@property NSInteger  status;
@property NSInteger priority;
@property NSDate* creationDate;
@property NSDate* complitionDate;
@end

