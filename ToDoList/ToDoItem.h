//
//  ToDoItem.h
//  ToDoList
//
//  Created by Jun Zhong on 2015-03-30.
//  Copyright (c) 2015 Jun Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
