//
//  ViewController.m
//  MVVMDemo
//
//  Created by Vicent on 16/8/22.
//  Copyright © 2016年 Vicent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *ageLb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)requestEvent:(id)sender {
    if (!self.activityIndicatorView.isAnimating) {
        [self mvcDesignning];
    }
}

//MVC
- (void)mvcDesignning {
    self.btn.enabled = NO;
    [self.activityIndicatorView startAnimating];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *resultDic = [self simulatingPost];
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.btn.enabled = YES;
            [self.activityIndicatorView stopAnimating];
            self.nameLb.text = resultDic[@"name"];
            self.ageLb.text = resultDic[@"age"];
        });
    });
}

- (NSDictionary *)simulatingPost {
    int randomNum = arc4random() % 100;
    NSArray *array = @[@"Jim",@"Tom",@"Lucy"];
    NSDictionary *resultDic = @{@"name":[NSString stringWithFormat:@"%@",array[randomNum%3]],@"age":[NSString stringWithFormat:@"%d",randomNum]};
    return resultDic;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
