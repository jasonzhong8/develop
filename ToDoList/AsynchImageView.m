//
//  AsynchImageView.m
//  ToDoList
//
//  Created by Jun Zhong on 2015-04-01.
//  Copyright (c) 2015 Jun Zhong. All rights reserved.
//

#import "AsynchImageView.h"


@implementation AsynchImageView

- (NSMutableData*) data {
    if (_data == nil) {
        _data = [NSMutableData data];
    }
    return _data;
}
- (id)initWithFrameURLStringAndTag:(CGRect)frame :(NSString*) urlString :(NSInteger) tag;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.urlString = urlString;
        // image is grey tile before loading
        self.backgroundColor = [UIColor grayColor];
        // set the tag so we can find this image on the UI if we need to
        self.tag = tag;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrameURLStringAndTag:frame :@"" :0];
}

- (void)loadImageFromNetwork {
    
    // spawn a new thread to load the image in the background, from the network
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:MAX_TIME_TO_WAIT_FOR_IMAGE];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // if the load faield then draw a timeout message on the image here, instead of displaying the actual image...
    self.image=[UIImage imageNamed:@"TimeOut.jpg"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.darrenvenn.completedImageLoad" object:nil];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // we have received the complete image, so update it now and notify the ShowPix VC that we have completed...
    self.image=[UIImage imageWithData:self.data];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.darrenvenn.completedImageLoad" object:nil];
}

@end
