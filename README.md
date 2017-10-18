# Installing
_These instructions need to be modified for windows._

```
cd ~
git clone http://github.com/username/dotvim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
cd ~/.vim
git submodule update --init
```

# Updating a Module
```
cd ~/.vim/bundle/<bundle-directory>
git pull origin master
```

## Updating All Bundles
```
git submodule foreach git pull origin master
```

# Notes
When you follow this method, generating helptags dirties the submodule’s git repository tree.  

Nils Haldenwang has written a [blog post](http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules) describing a simple fix, which just involves adding the line ignore = dirty to the .gitmodules file for each submodule that reports a dirty tree when you run git status.
