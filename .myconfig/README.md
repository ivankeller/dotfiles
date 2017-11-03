.myconfig is for storing my dotfiles to git

Instructions there : https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

In $HOME directory, use command config instead of git

ex:  

```config add <file>```

instead of  

```git add <file>```

and then similarly:

```config commit -m "my message"```

pushing:

```config push dotfiles master```
