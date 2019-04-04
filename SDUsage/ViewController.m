//
//  ViewController.m
//  SDUsage
//
//  Created by Insomnia on 2019/4/4.
//  Copyright © 2019 Insomnia. All rights reserved.
//

#import "ViewController.h"

#import <SDAnimatedImageView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL isAnimating;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.isAnimating = false;
    [self setButton];

    self.imageView = [UIImageView new];
    _imageView.layer.speed = 0.0;

    [_imageView sd_setImageWithURL:[NSURL URLWithString: @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554380798630&di=bfb07e4497a3ba1e96623ada5ddb52dc&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201302%2F25%2F20130225231122_fA3XG.gif"]];
    _imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_imageView];
    [_imageView setFrame:CGRectMake(150, 150, 180, 180)];
}

- (void)setButton {
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button1];
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"issue #2679" forState:UIControlStateNormal];
    [button1 setFrame:CGRectMake(100, 100, 180, 30)];
    [button1 addTarget:self action:@selector(click:)  forControlEvents:UIControlEventTouchUpInside];
   
}

- (void)click:(UIButton *)button {
    if (_isAnimating) {
         [self pauseLayer:_imageView.layer];
    } else {
        [self resumeLayer:_imageView.layer];
    }
}

-(void)pauseLayer:(CALayer*)layer {
    _isAnimating = false;
    CFTimeInterval pausedTime=[layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}


-(void)resumeLayer:(CALayer*)layer {
    _isAnimating = true;
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}



@end
