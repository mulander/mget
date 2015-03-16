# Common #

## Where can I get help? ##

You can ask Your questions on our [mailing list here](http://groups.google.com/group/movie-get/topics).
You can also find us on #mget at irc.freenode.org

## What are .mpkg files? ##

![http://gus.damnedangels.net/stuff/vzcrmpkg.png](http://gus.damnedangels.net/stuff/vzcrmpkg.png)

There are just plain text files. The first line of a .mpkg file should be a [shebang](http://en.wikipedia.org/wiki/Shebang_(Unix)) pointing to the mpkg runtime wrapper. This line is only required for Unix based operating systems. The rest of the file consists of links to media on sites supported by mget (in example youtube.com)

## How does mget handle .mpkg files? ##
On Windows mget recognizes the .mpkg file format so you can double-click it to start downloading its content. Also you have access to the context menu avaible when you click a .mpkg file with your right mouse button. From the context menu you can choose to download or download and convert the content of your .mpkg file.

## How do I create a .mpkg file ##
Open your favorite text editor and place the [shebang](http://en.wikipedia.org/wiki/Shebang_(Unix)) on the first line, in example
```
 #!/usr/bin/mpkg -dCi
```
now go to your favorite movie site supported by mget, and gather some links, when you are ready type them line by line beneath the shebang line.
```
 #!/usr/bin/mpkg -dCi
 http://youtube...
 http://youtube...
 http://youtube...
```
when you are done just save the file as some\_file.mpkg
And that's it! Just be sure to have each movie link on a seperate line. You can skip the shebang line but it's not recommended. Also if you edit your file with notepad select File->Save As... from the menu and for the file name enter some\_file.mpkg. If you don't provide the extensions the file will be saved as a plain .txt file and mget won't recognize it.

Lines starting with # are treated as comments.
Blank lines in the file will be ignored.
# Windows #

## Where are the files I downloaded? ##

Try searching in _C:\Program Files\mget\Downloads_ or _C:\Users\YOUR\_USERNAME\Downloads_ on Windows Vista. If you started your download using a .mpkg file then check in the same place where the .mpkg file is located.

## How can I easily download a movie from one of the supported sites? ##

Just visit the url in your browser. In example http://www.youtube.com/watch?v=xG_AjSFRNIw.
When you decide that You want this video downloaded then just change http:// to mget:// (mget://www.youtube.com/watch?v=xG\_AjSFRNIw) in your browser address bar and hit enter. Your browser will tell you that it needs to open an external application to handle your request. The moment you agree to run mget.bat the download process will begin.

# Linux #