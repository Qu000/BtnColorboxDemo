//
//  ViewController.m
//  BtnColorbox
//
//  Created by qujiahong on 2017/11/3.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define JHRGB(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define JHRandomColor JHRGB(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface ViewController ()

@property (nonatomic, strong) NSArray * titlesArr;

@property (nonatomic, strong) UILabel * numberLab;

@end

@implementation ViewController

-(NSArray *)titlesArr{
    if (!_titlesArr) {
        _titlesArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    return _titlesArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}
-(void)setUI{
    UIView * displayView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 80)];
    displayView.backgroundColor = JHRandomColor;
    [self.view addSubview:displayView];
    [self setLabel:displayView];
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, displayView.frame.size.height+40, SCREEN_WIDTH, SCREEN_HEIGHT-20-displayView.frame.size.height-40)];
    
    [self.view addSubview:bgView];
    [self setButton:bgView];
}
-(void)setLabel:(UIView *)view{
    
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 80);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    [view addSubview:lab];
    self.numberLab = lab;
}
-(void)setButton:(UIView *)view{
    NSInteger totalLoc = 3;
    CGFloat W = 80;
    CGFloat H = W;
    CGFloat margin=(self.view.frame.size.width-totalLoc * W)/(totalLoc+1);
    
    for (NSInteger i = 0; i < self.titlesArr.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.titlesArr[i] forState:UIControlStateNormal];
        btn.tintColor = [UIColor whiteColor];
        btn.backgroundColor = JHRandomColor;
        
        /*计算frame*/
        NSInteger row = i / totalLoc;//行号
        NSInteger loc = i % totalLoc;//列号
        //0/3=0,1/3=0,2/3=0,3/3=1;
        //0%3=0,1%3=1,2%3=2,3%3=0;
        CGFloat X= margin + (margin + W) * loc;
        CGFloat Y= margin + (margin + H) * row;
        btn.frame = CGRectMake(X, Y, W, H);
        
        //设置tag值(这里的tag，只是为了让button的每次点击都有不同的动画效果)
        btn.tag = i;
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn];
    }
}

-(void)clickBtn:(UIButton *)btn{
    
    NSString *stringInt = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    
    btn.layer.transform = CATransform3DMakeScale(0.5*arc4random_uniform([stringInt floatValue]), 0.5*arc4random_uniform([stringInt floatValue]), 1);
    
    self.numberLab.text = btn.titleLabel.text;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        btn.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
    }];
}

@end
