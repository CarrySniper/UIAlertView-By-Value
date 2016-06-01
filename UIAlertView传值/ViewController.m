//
//  ViewController.m
//  UIAlertView传值
//
//  Created by 思久科技 on 16/6/1.
//  Copyright © 2016年 Seejoys. All rights reserved.
//

#import "ViewController.h"

// 1、包含头文件：
#import <objc/runtime.h>
// 2、定义静态唯一key
static char alertInfoKey;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"标题"
                                                    message:@"内容消息"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    
    //显示
    [alert show];
    
    
    //定义要传递的值
    NSString *passByValue = @"这是一个字符串";
    objc_setAssociatedObject(
                             alert,                     //对象
                             &alertInfoKey,             //键的引用
                             passByValue,               //传递的值
                             OBJC_ASSOCIATION_ASSIGN    //策略assign
                             );
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        NSLog(@"点击取消");
    }else{
        NSString *getValue = objc_getAssociatedObject(
                                                      alertView,        //对象
                                                      &alertInfoKey     //键的引用
                                                      );
        NSLog(@"取值：%@",getValue);
    }
}


//适配iPad iOS8 —— 替换 actionSheet: clickedButtonAtIndex:
//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == uia) {
//        
//    }else{
//        NSString *getValue = objc_getAssociatedObject(alertView, &alertInfoKey);
//        NSLog(@"%@",data);
//    }
//        
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
