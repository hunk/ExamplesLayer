//
//  OscillationLineViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/7/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//

#import "OscillationLineViewController.h"

@interface OscillationLineViewController ()

@end

@implementation OscillationLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Oscillation lines";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(setup) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(setup2) withObject:nil afterDelay:0.1];
}

-(void)setup{
    
    //with layers
    CGPoint basePoint = CGPointMake(self.view.center.x-15, self.view.center.y);
    
    for (int i = 0; i < 3; i++) {
        CALayer* layer = [CALayer layer];
        layer.backgroundColor = [UIColor redColor].CGColor;
        layer.anchorPoint = CGPointMake(0.0, 1.0); // At the bottom-left corner
        layer.position = CGPointMake(basePoint.x+(i*10), basePoint.y); // In superview's coordinate
        layer.bounds = CGRectMake(0.0, 0.0, 5, 10);// In its own coordinate
        [self.view.layer addSublayer:layer];
        
        CGRect toBounds = layer.bounds;
        toBounds.size.height = (arc4random() % 20) + 20;
        
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        animation.fromValue = [NSValue valueWithCGRect:layer.bounds];
        animation.toValue = [NSValue valueWithCGRect:toBounds];
        animation.repeatCount = HUGE_VALF; // Forever
        animation.autoreverses = YES;
        animation.duration = 0.3 + ( (float)((arc4random() % 3)+1)/10);
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
         [layer addAnimation:animation forKey:@"oscillation"];
    }
}

-(void)setup2{
    //with UIViews
    CGPoint basePoint = CGPointMake(self.view.center.x-15, self.view.center.y+100);
    
    for (int i = 0; i < 3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(basePoint.x+i*10, basePoint.y, 5, 10)];
        view.backgroundColor = [UIColor redColor];
        view.layer.anchorPoint = CGPointMake(0.0, 1.0);
        [self.view addSubview:view];
        
        CGRect toBounds = view.layer.bounds;
        toBounds.size.height = (arc4random() % 20) + 20;
        
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        animation.fromValue = [NSValue valueWithCGRect:view.layer.bounds];
        animation.toValue = [NSValue valueWithCGRect:toBounds];
        animation.repeatCount = HUGE_VALF; // Forever
        animation.autoreverses = YES;
        animation.duration = 0.3 + ( (float)((arc4random() % 3)+1)/10);
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [view.layer addAnimation:animation forKey:@"oscillation"];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
