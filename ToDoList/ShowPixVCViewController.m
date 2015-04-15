//
//  ShowPixVCViewController.m
//  ToDoList
//
//  Created by Jun Zhong on 2015-04-01.
//  Copyright (c) 2015 Jun Zhong. All rights reserved.
//

#import "ShowPixVCViewController.h"

@interface ShowPixVCViewController ()

@end

@implementation ShowPixVCViewController

// This ViewController contains one UIScrollView that has images loaded onto to, as well as
// a back button to dismiss the VC and go back to the intial screen.

// lazy instantiating getter for the array of images
- (NSMutableArray*) images {
    if (_images == nil) {
        _images = [[NSMutableArray alloc] initWithCapacity:1000];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // here we draw the array images on the UIScrollView but we don't yet load them.
    // The images will initially display as gray tiles.
    int heightFromTop = 6;
    for (int i=0; i < TOTAL_NUMBER_OF_IMAGES; i++) {
        // Each image file is of the format Magnolia0000x.jpg and they are all the same size.
        // We draw two images per row with a border of size 6 around each image.
        NSString *urlString = [NSString stringWithFormat:@"http://darrenvenn.com/TestImages/Magnolia%05d.jpg",i];
        int spaceFromLeft = 6 + ((i%2) * 184);
        [self.images addObject:[[AsynchImageView alloc] initWithFrameURLStringAndTag:CGRectMake(spaceFromLeft, heightFromTop, 179, 105):urlString:i]];
        [self.pixScrollView addSubview:[self.images objectAtIndex:i]];
        if (spaceFromLeft != 6) {
            heightFromTop = heightFromTop + 106; // mark the next y-axis beginning point on every second image (since there are 2 per row)
        }
    }
    
    heightFromTop = heightFromTop - 6;
    self.statusLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(6, heightFromTop, 308, 50)];
    self.statusLabel1.backgroundColor = [UIColor blackColor];
    self.statusLabel1.textColor = [UIColor whiteColor];
    self.statusLabel1.font = [UIFont fontWithName:@"Noteworthy-Bold" size:(16.0)];
    self.statusLabel1.text = @"loading images...";
    self.statusLabel1.textAlignment = NSTextAlignmentCenter;
    [self.pixScrollView addSubview:self.statusLabel1];
    
    // set the size of the scrollView, based on total number of images.
    self.pixScrollView.contentSize = CGSizeMake(320, heightFromTop + 6 + 50);
    // every time an images completes loading, respond by executing the doStats method:
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doStats) name:@"com.darrenvenn.completedImageLoad" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) doStats {
    // an image completed loading, so add one to the number processed, and, if all are now complete, update the load message.
    self.numberOfImagesProcessed++;
    if (self.numberOfImagesProcessed == TOTAL_NUMBER_OF_IMAGES) {
        self.timeCompletedLoading = [NSDate timeIntervalSinceReferenceDate];
        self.statusLabel1.text = [NSString stringWithFormat:@"Images loaded in %f seconds.",(self.timeCompletedLoading - self.timeStartedLoading)];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // We only start to load the images once the view has appeared. This is just for clarity's sake. This processing may happen elsewhere, e.g. in ViewDidLoad or viewWillAppear.
    self.numberOfImagesProcessed = 0;
    self.timeStartedLoading = [NSDate timeIntervalSinceReferenceDate];
    for (AsynchImageView *currImage in self.images) {
        [currImage loadImageFromNetwork];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
