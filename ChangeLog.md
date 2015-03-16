**mget (1.50)**
  * Fixed support for:
    1. dailymotion.com ([issue #62](https://code.google.com/p/mget/issues/detail?id=#62));
    1. gazeta.pl ([issue #62](https://code.google.com/p/mget/issues/detail?id=#62));
    1. glumbert.com ([issue #62](https://code.google.com/p/mget/issues/detail?id=#62));
    1. itvp.pl ([issue #62](https://code.google.com/p/mget/issues/detail?id=#62));
    1. sevenload.com ([issue #62](https://code.google.com/p/mget/issues/detail?id=#62));
    1. veoh.com ([issue #62](https://code.google.com/p/mget/issues/detail?id=#62));
    1. patrz.pl ([issue #53](https://code.google.com/p/mget/issues/detail?id=#53),[issue #56](https://code.google.com/p/mget/issues/detail?id=#56),[issue #57](https://code.google.com/p/mget/issues/detail?id=#57));
    1. smog.pl ([issue #54](https://code.google.com/p/mget/issues/detail?id=#54));
  * Removed support for:
    1. stage6.com ([issue #61](https://code.google.com/p/mget/issues/detail?id=#61));
    1. loadup.ru ([issue #63](https://code.google.com/p/mget/issues/detail?id=#63));
    1. czechtv ([issue #63](https://code.google.com/p/mget/issues/detail?id=#63));
  * Added support for:
    1. last.fm (mp3 and video) ([issue #59](https://code.google.com/p/mget/issues/detail?id=#59));
  * Ruby is no longer required on MS Windows (the installer contains all the required files).

_-- mulander, defc0n 12.06.2008_


**mget (1.20)**

  * Fixed support for:
    1. Sevenload ([issue #43](https://code.google.com/p/mget/issues/detail?id=#43));
    1. Stage6 ([issue #48](https://code.google.com/p/mget/issues/detail?id=#48));
    1. YouTube ([issue #43](https://code.google.com/p/mget/issues/detail?id=#43), [issue #47](https://code.google.com/p/mget/issues/detail?id=#47));
  * Fixed log path for MS Windows ([issue #46](https://code.google.com/p/mget/issues/detail?id=#46));
  * Fixed ffmpeg conversion ([issue #45](https://code.google.com/p/mget/issues/detail?id=#45));
  * Fixed function 'input' ([issue #50](https://code.google.com/p/mget/issues/detail?id=#50));
  * Added support for mpkg files ([issue #51](https://code.google.com/p/mget/issues/detail?id=#51)).

_-- defc0n 5.05.2008_


**mget-qt (1.19.1)**
  * Fixed a bug where the application ignored all input entered by hand ([issue #42](https://code.google.com/p/mget/issues/detail?id=#42))

_-- mulander 4.11.2007_


**mget (1.19)** and **mget-qt (1.19.0)**

  * Added support for:
    1. ceskatelevize.cz ([issue #31](https://code.google.com/p/mget/issues/detail?id=#31)); # contributed by Marcin Babnis
    1. en.sevenload.com ([issue #32](https://code.google.com/p/mget/issues/detail?id=#32));
    1. veoh.com         ([issue #33](https://code.google.com/p/mget/issues/detail?id=#33));
    1. liveleak.com     ([issue #39](https://code.google.com/p/mget/issues/detail?id=#39));
    1. loadup.ru        ([issue #41](https://code.google.com/p/mget/issues/detail?id=#41)).
  * Fixed support for:
    1. Wrzuta  ([issue #27](https://code.google.com/p/mget/issues/detail?id=#27));
    1. Youtube ([issue #37](https://code.google.com/p/mget/issues/detail?id=#37));          # contributed by huf
    1. Stage6  ([issue #40](https://code.google.com/p/mget/issues/detail?id=#40)).
  * Updated link in --version information                       ([issue #25](https://code.google.com/p/mget/issues/detail?id=#25))
  * Added a script to generate test cases for MovieSite classes ([issue #28](https://code.google.com/p/mget/issues/detail?id=#28))

_-- mulander, defc0n 3.11.2007_


**mget (1.18)**

  * Added support for:
    1. collegehumor.com ([issue #24](https://code.google.com/p/mget/issues/detail?id=#24));
  * Fixed support for:
    1. YouTube ([issue #20](https://code.google.com/p/mget/issues/detail?id=#20)).

_-- mulander, defc0n 18.09.2007_


**mget (1.17)**

  * Added support for:
    1. gazeta.pl ([issue #11](https://code.google.com/p/mget/issues/detail?id=#11));
    1. dailymotion.com ([issue #9](https://code.google.com/p/mget/issues/detail?id=#9));
    1. tvn24.pl ([issue #13](https://code.google.com/p/mget/issues/detail?id=#13));
    1. porkolt.com ([issue #15](https://code.google.com/p/mget/issues/detail?id=#15));
  * Fixed support for:
    1. itvp.pl;
    1. patrz.pl ([issue #14](https://code.google.com/p/mget/issues/detail?id=#14));
    1. video.google.com.


_-- mulander, defc0n 19.06.2007_


**mget (1.16)**

  * Added support for allocone.fr.

_-- mulander, defc0n 8.01.2007_


**mget (1.15)**

  * Added support for:
    1. funpic.hu ([issue #7](https://code.google.com/p/mget/issues/detail?id=#7));
    1. glumbert.hu ([issue #5](https://code.google.com/p/mget/issues/detail?id=#5));
    1. habtv.hu;
    1. interia.pl;
    1. onet.pl;
  * Added documentation (pod/man/html) ([issue #8](https://code.google.com/p/mget/issues/detail?id=#8));
  * Fixed Windows Installer ([issue #5](https://code.google.com/p/mget/issues/detail?id=#5)).

_-- mulander, defc0n 6.01.2007_


**mget (1.10)**

  * Added support for:
    1. movies.yahoo.com (requires mplayer);
    1. itvp.pl (requires mplayer) ([issue #3](https://code.google.com/p/mget/issues/detail?id=#3));
  * Fixed some minor bugs;
  * Behaviour changes:
    1. log files are now stored in one place;
    1. files are downloaded to sub-directories
> > > only when the list of movies is supplied
> > > from a file ( by the --input command ).

_-- mulander, defc0n, 22.12.2006_


**mget (1.01)**

  * Added support for:
    1. wrzuta.pl audio (mp3) download;
  * Fixed deleting leftover files from convertion.

_-- defc0n, 28.10.2006_


**mget (1.00)**

  * Added support for:
    1. youtube videos rated as adult ([issue #1](https://code.google.com/p/mget/issues/detail?id=#1));
    1. wrzuta.pl;
  * Added features:
    1. read links from a file;
    1. always download/never download flag;
    1. always convert/never convert flag;
    1. added always remove/never remove (letover file after conversion) flag;
    1. silencing wget output;
    1. statistics when using file for input;
  * Removed support for:
    1. smog.pl;
  * Code is now object oriented;
  * Fixed default answer (Enter stands for "Yes" now);
  * Behaviour changes:
    1. direct links are not shown by default (--show to see them);
    1. name is not required now (--name to specify a name);
    1. all videos are now downloaded to a directory structure Site/SiteXXXXXX.ext
> > > Site stands for movie site (example. Youtube, MetaCafe etc.)
> > > XXXXXX stands for 6 digits (example. 000000, 000001, 000002 etc.)
> > > .ext stands for the file extension (example. .flv, .mpg etc.).

_-- mulander, defc0n, 27.10.2006_


**mget (0.08)**

  * Fixed Windows usage.

_-- defc0n, 24.10.2006_


**mget (0.07)**

  * Fixed function 'convert'.

_-- defc0n, 23.10.2006_


**mget (0.06)**

  * Fixed windows behaviour.

_-- defc0n, 18.10.2006_


**mget (0.05)**

  * Added support for:
    1. MySpace Video;
    1. patrz.pl;
    1. smog.pl;
  * Fixed metacafe downloading;
  * Converting flv to avi using ffmpeg.

_-- defc0n, 18.10.2006_


