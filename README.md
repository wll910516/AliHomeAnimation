# 学习支付宝首页动画

## 关键方法
1. iOS私有API，可实现UIView滑动效果
``` 
UIPanGestureRecognizer *pan = [self.tableView valueForKey:[NSString stringWithFormat:@"%@%@",@"pan",@"GestureRecognizer"]];
    [self.view addGestureRecognizer:pan];
```
2. UIScrollViewDelegate代理方法，实现头部两个视图透明度的切换
```
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
```
```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
```






