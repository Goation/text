//
//  ViewController.m
//  MNFishEat
//
//  Created by qingyun on 16/3/17.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *blueImage;
@property (weak, nonatomic) IBOutlet UIImageView *redImage;
@property (weak, nonatomic) IBOutlet UIImageView *yellowImage;
@property (nonatomic) CGPoint blueCenter;
@property (nonatomic) CGPoint redCenter;
@property (nonatomic) CGPoint yellowCenter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self refish];
    NSLog(@"x:%f",self.blueImage.center.x);
    [self rotationGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.blueCenter = self.blueImage.center;
    self.redCenter = self.redImage.center;
    self.yellowCenter = self.yellowImage.center;
    
    [self.view setNeedsLayout];
}
#pragma mark -GestureRecognizer
-(void)rotationGestureRecognizer
{
    //旋转
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationRecognizer:)];
    [self.view addGestureRecognizer:rotationRecognizer];
}
-(void)rotationRecognizer:(UIRotationGestureRecognizer *)recognizer
{
    NSLog(@"旋转：%s",__func__);
}
#pragma mark -touchEven
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    //NSLog(@"t:%f",point.x);
    //放大
    if ([self isPointInRect:point]) {
        
        UIImageView *imageView =(UIImageView *) touch.view;
        
        [UIView animateWithDuration:1 animations:^{
            imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            imageView.center = point;
        }];
    }else
    { //还原
        if (touch.tapCount == 2) {
            [self refish];
            //[self.view setNeedsLayout];
        }
    }
}


-(BOOL)isPointInRect:(CGPoint)point
{
    if (CGRectContainsPoint(self.blueImage.frame, point) || CGRectContainsPoint(self.redImage.frame, point) || CGRectContainsPoint(self.yellowImage.frame, point)) {
        return YES;
    }
    return NO;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    //判断当前点是否在当前视图上任意位置
    if (CGRectContainsPoint(self.blueImage.frame, point)) {
        [UIView animateWithDuration:.5 animations:^{
            self.blueImage.center = point;
        }];
    }
    if (CGRectContainsPoint(self.redImage.frame, point)) {
        [UIView animateWithDuration:.5 animations:^{
            self.redImage.center = point;
        }];
    }

    if (CGRectContainsPoint(self.yellowImage.frame, point)) {
        [UIView animateWithDuration:.5 animations:^{
            self.yellowImage.center = point;
        }];
    }
}
-(void)refish
{
    [UIView animateWithDuration:.5 animations:^{
        self.blueImage.center = self.blueCenter;
        self.redImage.center = self.redCenter;
        self.yellowImage.center = self.yellowCenter;
        
        NSLog(@"rx:%f",self.blueImage.center.x);
    }];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //恢复放大
    UITouch *touch = [touches anyObject];
    UIImageView *imageView =(UIImageView *) touch.view;
    
    [UIView animateWithDuration:1 animations:^{
        imageView.transform = CGAffineTransformIdentity;
    }];
}
@end
