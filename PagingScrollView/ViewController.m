//
//  ViewController.m
//  PagingScrollView
//
//  Created by Do Minh Hai on 11/9/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "ViewController.h"
#define PHOTO_WIDTH  320
#define PHOTO_HEIGHT  480
#define NUM_PHOTO 6
@interface ViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UIPageControl* pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView* NaviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 190, 50)];
    titleLabel.center = CGPointMake(self.view.bounds.size.width/2, 30);
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"Paging ScrollView";
    [NaviView addSubview:titleLabel];
    self.navigationItem.titleView = NaviView;
    
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGSize size = self.view.bounds.size;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((size.width - PHOTO_WIDTH) * 0.5,  0,
                                                                     PHOTO_WIDTH, PHOTO_HEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.contentSize = CGSizeMake(PHOTO_WIDTH * NUM_PHOTO, PHOTO_HEIGHT);
    self.scrollView.pagingEnabled = YES;
    
    for (int i = 1; i < NUM_PHOTO + 1; i++) {
        NSString * fileName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:fileName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake((i - 1) * PHOTO_WIDTH, 0, PHOTO_WIDTH, PHOTO_HEIGHT);
        [self.scrollView addSubview:imageView];
    }
    
    [self.view addSubview:self.scrollView];
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, size.height - 64- 40, size.width, 40)];
    self.pageControl.backgroundColor = [UIColor lightGrayColor];
    self.pageControl.numberOfPages = NUM_PHOTO;
    [self.pageControl addTarget:self
                         action:@selector(onPageChange:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
}
-(void) viewDidDisappear:(BOOL)animated
{
    self.scrollView.delegate = nil;
}
-(void) onPageChange: (id)sender
{
    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage* PHOTO_WIDTH, 0);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage  = self.scrollView.contentOffset.x/PHOTO_WIDTH;
}
@end
