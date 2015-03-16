## Arch Linux ##

Go to the [mget page](http://aur.archlinux.org/packages.php?do_Details=1&ID=7610) on AUR.

Download the [tarball](http://aur.archlinux.org/packages/mget/mget.tar.gz)

Extract it in your /var/abs/local

Issue the following commands:

```
cd /var/abs/local/mget
makepkg
pacman -A mget-1.17-1.pkg.tar.gz
```

Now you are ready to use the script :)

PS.

Don't forget to vote for mget on AUR if you like it :)


## Debian/Ubuntu ##

Add the following line to your /etc/apt/sources.list
```
deb http://mget.ircfans.org/ ./
```

In console:
```
apt-get update && apt-get install mget
```


## Windows ##

Visit the [download section](http://code.google.com/p/mget/downloads/list) on the [mget project homepage](http://movie-get.org/).

![http://gus.damnedangels.net/small.php?image=x7s4mget_4.png](http://gus.damnedangels.net/small.php?image=x7s4mget_4.png)

Download the [windows installer for mget 1.20](http://mget.googlecode.com/files/mget-1.20.1-win.exe)

![http://gus.damnedangels.net/small.php?image=dgebmget_5.png](http://gus.damnedangels.net/small.php?image=dgebmget_5.png)

Run the mget windows installer.

![http://gus.damnedangels.net/stuff/f216mget_14.png](http://gus.damnedangels.net/stuff/f216mget_14.png)

![http://gus.damnedangels.net/stuff/fzw3mget_15.png](http://gus.damnedangels.net/stuff/fzw3mget_15.png)

![http://gus.damnedangels.net/stuff/khb9mget_16.png](http://gus.damnedangels.net/stuff/khb9mget_16.png)

![http://gus.damnedangels.net/stuff/n5mmmget_17.png](http://gus.damnedangels.net/stuff/n5mmmget_17.png)

Now, that we have mget installed we can ask defc0n for some media ;)

![http://gus.damnedangels.net/stuff/9fcvmget_18.png](http://gus.damnedangels.net/stuff/9fcvmget_18.png)

Defc0n send us a .mpkg file (you can download this example [Media Package here](http://code.google.com/p/mget/downloads/detail?name=RoadRunner.mpkg)). This file is recognized by mget, so we can double click the file (or in case of google talk click open) and mget will know how to take care of it.

A black console window will appear, you can see the download progress in it.

![http://gus.damnedangels.net/stuff/ci1zmget_19.png](http://gus.damnedangels.net/stuff/ci1zmget_19.png)

When it's done the files will be located in the same folder as your .mpkg file. In our case it's the Stage6 directory.

![http://gus.damnedangels.net/stuff/t9jumget_20.png](http://gus.damnedangels.net/stuff/t9jumget_20.png)

You can run a .mpkg file by double clicking on it, or you can right click and select the desired action from the context menu.

Have fun :)