//
//  Model.h
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TODO.h"


@interface Model : NSObject

-(int) generateID ;
-(void) addTODO :(TODO*) todo ;
-(void) editTODO :(TODO*) todo ;
-(void) removeTODO :(int) todo ;
-(TODO*) getTODO :(int) todo ;
-(NSMutableArray*) getAllTODO ;
@end

