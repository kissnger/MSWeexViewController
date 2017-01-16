//
//  ViewController.m
//  MSWeexViewController
//
//  Created by Massimo on 2017/1/16.
//  Copyright © 2017年 Massimo. All rights reserved.
//

#import "ViewController.h"
#import <WeexSDK/WeexSDK.h>
@interface ViewController ()
@property (nonatomic, strong)WXSDKInstance *instance;
@property (nonatomic, strong)UIView *weexView;
@end

@implementation ViewController
{
  NSURL *jsUrl;
}

- (instancetype)initWithJS:(NSString *)jsPath{
  self = [super init];
  
  if (self) {
    NSString *path = [NSString stringWithFormat:@"http://lexch.cn/weexjs/%@",jsPath];
    jsUrl = [NSURL URLWithString:path];
  }
  return self;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  _instance = [[WXSDKInstance alloc] init];
  _instance.viewController = self;
  _instance.frame = self.view.bounds;
  __weak typeof(self) weakSelf = self;
  [_instance setOnCreate:^(UIView *view) {
    [weakSelf.weexView removeFromSuperview];
    weakSelf.weexView = view;
    [weakSelf.view addSubview:weakSelf.weexView];
    
  }];
  
  [_instance setOnFailed:^(NSError *err) {
    NSLog(@"创建失败：\n %@",err);
  }];

  [_instance setRenderFinish:^(UIView *view) {
    NSLog(@"创建成功");
  }];
  [_instance renderWithURL:jsUrl];
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc{
  [_instance destroyInstance];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
