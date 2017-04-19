#!/bin/sh
# Install libiconv-1.13.1, zlib-1.2.11, freetype-2.7.1, libpng-1.2.50, libevent-2.1.8, libmcrypt-2.5.8, pcre-8.40 and jpeg.6 for PHP 7.1.3
# (c) 2017 mtxiaowangzi http://eveino.com/64.html
# https://github.com/mtxiaowangzi/My_nmp/blob/master/Pre_set/install_env_php.sh

CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)
if [ ! -f libiconv-1.13.1.tar.gz ];then
	wget http://oss.aliyuncs.com/aliyunecs/onekey/libiconv-1.13.1.tar.gz
fi
rm -rf libiconv-1.13.1
tar zxvf libiconv-1.13.1.tar.gz
cd libiconv-1.13.1
./configure --prefix=/usr/local
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..

if [ ! -f zlib-1.2.11.tar.gz ];then
	wget http://zlib.net/zlib-1.2.11.tar.gz
fi
rm -rf zlib-1.2.11
tar zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure
if [ $CPU_NUM -gt 1 ];then
    make CFLAGS=-fpic -j$CPU_NUM
else
    make CFLAGS=-fpic
fi
make install
cd ..
if [ ! -f freetype-2.7.1.tar.bz2 ];then
	wget https://nchc.dl.sourceforge.net/project/freetype/freetype2/2.7.1/freetype-2.7.1.tar.bz2
fi
rm -rf freetype-2.7.1
tar xvf freetype-2.7.1.tar.bz2
cd freetype-2.7.1
./configure --prefix=/usr/local/freetype.2.7.1
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..

if [ ! -f libpng-1.2.50.tar.gz ];then
    wget http://oss.aliyuncs.com/aliyunecs/onekey/libpng-1.2.50.tar.gz
fi
rm -rf libpng-1.2.50
tar zxvf libpng-1.2.50.tar.gz
cd libpng-1.2.50
./configure --prefix=/usr/local/libpng.1.2.50
if [ $CPU_NUM -gt 1 ];then
    make CFLAGS=-fpic -j$CPU_NUM
else
    make CFLAGS=-fpic
fi
make install
cd ..

if [ ! -f libevent-2.1.8-stable.tar.gz ];then
	wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
fi
rm -rf libevent-2.1.8-stable
tar zxvf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./configure
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..

if [ ! -f libmcrypt-2.5.8.tar.gz ];then
	wget http://oss.aliyuncs.com/aliyunecs/onekey/libmcrypt-2.5.8.tar.gz
fi
rm -rf libmcrypt-2.5.8
tar zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure --disable-posix-threads
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
/sbin/ldconfig
cd libltdl/
./configure --enable-ltdl-install
make
make install
cd ../..

if [ ! -f pcre-8.40.tar.gz ];then
	wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz
fi
rm -rf pcre-8.40
tar zxvf pcre-8.40.tar.gz
cd pcre-8.40
./configure
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..

if [ ! -f jpegsrc.v6b.tar.gz ];then
	wget http://oss.aliyuncs.com/aliyunecs/onekey/jpegsrc.v6b.tar.gz
fi
rm -rf jpeg-6b
tar zxvf jpegsrc.v6b.tar.gz
cd jpeg-6b
if [ -e /usr/share/libtool/config.guess ];then
cp -f /usr/share/libtool/config.guess .
elif [ -e /usr/share/libtool/config/config.guess ];then
cp -f /usr/share/libtool/config/config.guess .
fi
if [ -e /usr/share/libtool/config.sub ];then
cp -f /usr/share/libtool/config.sub .
elif [ -e /usr/share/libtool/config/config.sub ];then
cp -f /usr/share/libtool/config/config.sub .
fi
./configure --prefix=/usr/local/jpeg.6 --enable-shared --enable-static
mkdir -p /usr/local/jpeg.6/include
mkdir /usr/local/jpeg.6/lib
mkdir /usr/local/jpeg.6/bin
mkdir -p /usr/local/jpeg.6/man/man1
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install-lib
make install
cd ..

#load /usr/local/lib .so
touch /etc/ld.so.conf.d/usrlib.conf
echo "/usr/local/lib" > /etc/ld.so.conf.d/usrlib.conf
/sbin/ldconfig
