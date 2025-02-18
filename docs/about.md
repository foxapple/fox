
## 命名来源

一般而言，大多数程序员在工作中会追求一种沉浸式的开发体验，因此无论是 IDE 还是 Shell 终端的界面配置基本上都是以深色为主，以营造一种电影院式的氛围。

另一方面，程序员大多喜欢熬夜，对他们而言，夜越深，工作效率越高！

这两方面的事实会让人自然而然地联想到 “黑暗”、“黑夜” 等词汇。于是，项目的命名被关联到了 “黑夜女神” 一词。对应到希腊神话中，正是黑夜女神尼克斯（Nyx），罗马又称诺克斯（Nox）。

通过对比这两个词汇在键盘上的键位与输入效率，可以发现 “fox” 的输入效率是更高的。因此，此项目被命名为 “fox”。

![](https://chuquan-public-r-001.oss-cn-shanghai.aliyuncs.com/fox/fox-keyboard-layout.png)

## LOGO 设计

![](https://chuquan-public-r-001.oss-cn-shanghai.aliyuncs.com/fox/fox-logo.png)

一个个五彩斑斓的碎片代表 FOX 所管理的无数脚本，它们共同组成了 FOX 的全部功能。而所有这些脚本都是以 `fox` 作为主命令进行索引，方便用户快速调用。

## 常见问题
Q: 自动补全未生效

A: 首先执行 `fox system build` 编译生成最新的自动补全逻辑，然后执行 `source ~/.zshrc` 或重启终端重新加载自动补全逻辑。
