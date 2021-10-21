//
//  TODO.m
//  todo
//
//  Created by Ghadeer El-Mahdy on 3/23/20.
//  Copyright © 2020 Ghadeer El-Mahdy. All rights reserved.
//

#import "TODO.h"

@implementation TODO
- (void)encodeWithCoder:(nonnull NSCoder *)coder {
     [coder encodeInt:_todoID forKey:@"todoID"];
    [coder encodeObject:_title forKey:@"title"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeObject:_creationDate forKey:@"creationDate"];
    [coder encodeObject:_complitionDate forKey:@"complitionDate"];
    [coder encodeInteger :_priority forKey:@"priority"];
    [coder encodeInteger :_status forKey:@"status"];
}

- ( instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self.todoID = [coder decodeIntForKey:@"todoID"];
    self.title = [coder decodeObjectForKey:@"title"];
    self.desc = [coder decodeObjectForKey:@"desc"];
    self.complitionDate = [coder decodeObjectForKey:@"complitionDate"];
    self.creationDate = [coder decodeObjectForKey:@"creationDate"];
    self.priority = [coder decodeIntegerForKey:@"priority"];
    self.status = [coder decodeIntegerForKey:@"status"];
    return self;
}

@end


