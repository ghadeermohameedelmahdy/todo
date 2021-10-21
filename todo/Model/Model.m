//
//  Model.m
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import "Model.h"

@implementation Model
{
    NSUserDefaults*  savedData;
}
-(instancetype)init{
    
        savedData = [NSUserDefaults standardUserDefaults];
    if( [savedData valueForKey:@"generator"] == nil){
        [savedData setInteger:0 forKey:@"generator"];
    }
    return self;
}
-(int) generateID {
    
    int lastID = (int)[savedData integerForKey:@"generator"] +1;
    [savedData setInteger:lastID forKey:@"generator"];
    lastID = (int)[savedData integerForKey:@"generator"] ;
    printf(" last id %d\n",lastID);
    return lastID ;
}
-(void) addTODO :(TODO*) todo {
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:todo];
    NSString* todoID =[NSString stringWithFormat:@"%@%d" ,@"object",todo.todoID ];
    [savedData setObject:data forKey:todoID];
}
-(void) editTODO :(TODO*) todo {
     NSString* todoID =[NSString stringWithFormat:@"%@%d" ,@"object",todo.todoID ];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:todo];
    [savedData setObject:data forKey:todoID];
    
}
-(void) removeTODO :(int) todo {
     NSString* todoID =[NSString stringWithFormat:@"%@%d" ,@"object",todo ];
    [savedData removeObjectForKey:todoID];
}
-(TODO*) getTODO :(int) todo {
    NSString* todoID =[NSString stringWithFormat:@"%@%d" ,@"object",todo ];
    NSData* data =   [savedData objectForKey:todoID];
    TODO* getter = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return getter;
}

-(NSMutableArray *)getAllTODO{
    NSMutableArray* allTODO = [NSMutableArray new];
    int lastID = (int)[savedData integerForKey:@"generator"] ;
    while(lastID >0){
       TODO* todo = [self getTODO:lastID];
      if(todo != nil)
        [allTODO addObject:todo];
      lastID --;
    }
    return allTODO;
}

@end
