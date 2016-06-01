# UIAlertView-By-Value
UIAlertView使用Runtime机制实现传值

##代码

```
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
    
    // 3、初始化
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"标题"
                                                    message:@"内容消息"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    
    // 4、显示
    [alert show];
    
    
    // 5、定义要传递的值
    NSString *passByValue = @"这是一个字符串";
    objc_setAssociatedObject(
                             alert,                     //对象
                             &alertInfoKey,             //键的引用
                             passByValue,               //传递的值
                             OBJC_ASSOCIATION_ASSIGN    //策略assign
                             );
}

#pragma mark - UIAlertViewDelegate
/**
 *  6、实现UIAlertViewDelegate方法
 *
 *  @param alertView   UIAlertView对象
 *  @param buttonIndex 选中下标
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex) {
        NSLog(@"点击取消");
    }else{
        // 6、取值
        NSString *getValue = objc_getAssociatedObject(
                                                      alertView,        //对象
                                                      &alertInfoKey     //键的引用
                                                      );
        NSLog(@"取值：%@",getValue);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
```
