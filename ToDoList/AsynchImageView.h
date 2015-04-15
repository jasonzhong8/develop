//
//  AsynchImageView.h
//  ToDoList
//
//  Created by Jun Zhong on 2015-04-01.
//  Copyright (c) 2015 Jun Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_TIME_TO_WAIT_FOR_IMAGE 30.0 // timeout if the image was not loaded after 30 seconds

@interface AsynchImageView : UIImageView

@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSString *urlString;

- (id)initWithFrameURLStringAndTag:(CGRect)frame :(NSString*) urlString :(NSInteger) tag;
- (void)loadImageFromNetwork;

@end