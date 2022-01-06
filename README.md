# apk反编译工具
一键反编译apk，并使用jd-gui打开反编译的jar

输出结果在apk同目录下的同名文件夹中，反编译的jar在dex2jar-outputs中

## 使用方法
### 方式一
可以添加别名
```
vim /etc/profile

alias test.sh="sh /xxx/yyy/zzz/apk.sh"

source /etc/profile

```

执行
```
sh apk *.apk
```

### 方式二
```
sh /*脚本目录*/apk.sh *.apk
```

## TODO
1. 目前仅添加mac版本
