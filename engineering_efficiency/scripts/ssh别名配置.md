
# ssh别名配置

进入~/.ssh目录，创建一个名为config的文件,输入如下内容:

```
Host github
    HostName github.com
    IdentityFile ~/.ssh/id_rsa_github
    User git
Host xyz
    HostName xxxx.com
    IdentityFile ~/.ssh/id_rsa
    User git

```