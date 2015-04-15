//
//  ShowPixVCViewController.h
//  ToDoList
//
//  Created by Jun Zhong on 2015-04-01.
//  Copyright (c) 2015 Jun Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynchImageView.h"
#define TOTAL_NUMBER_OF_IMAGES 50 // number of images that will be loaded on the scrollview

@interface ShowPixVCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *pixScrollView;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel1;

@property (strong, nonatomic) NSMutableArray *images;
@property (assign) NSInteger numberOfImagesProcessed;

@property (nonatomic,assign) NSTimeInterval timeStartedLoading;
@property (nonatomic,assign) NSTimeInterval timeCompletedLoading;

@end
