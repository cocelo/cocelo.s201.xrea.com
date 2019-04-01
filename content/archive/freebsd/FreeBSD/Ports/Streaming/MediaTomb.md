+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Streaming/MediaTomb"
date = "2010-01-23T00:31:37Z"
+++


# インストール  {#ifbe21ca}

```
# cd /usr/ports/net/mediatomb
# make install clean
```

# MySQLの設定  {#r17ccb2f}

```
# mysql -u root -p
mysql> CREATE DATABASE mediatomb;
mysql> GRANT ALL ON mediatomb.* TO 'mediatomb'@'localhost';
mysql> SET PASSWORD FOR 'mediatomb'@'localhost'=PASSWORD("mediatomb");
mysql> FLUSH PRIVILEGES;
mysql> quit
```

# MediaTombの設定  {#p3a6146a}

```
# vi /usr/local/etc/mediatomb/config.xml
```


```
<?xml version="1.0" encoding="UTF-8"?>
<config version="1" xmlns="http://mediatomb.cc/config/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://mediatomb.cc/config/1 http://mediatomb.cc/config/1.xsd">
  <server>
    <ui enabled="yes">
      <accounts enabled="yes" session-timeout="30">
        <account user="mediatomb" password="mediatomb"/>
      </accounts>
    </ui>
    <name>MediaTomb</name>
    <udn>uuid:e7639477-3097-4ad4-8867-b006261eda14</udn>
    <home>/var/mediatomb</home>
    <webroot>/usr/local/share/mediatomb/web</webroot>
    <storage>
      <sqlite3 enabled="no">
        <database-file>mediatomb.db</database-file>
      </sqlite3>
      <mysql enabled="yes">
        <host>localhost</host>
        <username>mediatomb</username>
        <password>mediatomb</password>
        <database>mediatomb</database>
      </mysql>
    </storage>
    <protocolInfo extend="yes"/><!-- For PS3 support change to "yes" -->
    <!--
       Uncomment the lines below to get rid of jerky avi playback on the
       DSM320 or to enable subtitles support on the DSM units
    -->
    <!--
    <custom-http-headers>
      <add header="X-User-Agent: redsonic"/>
    </custom-http-headers>

    <manufacturerURL>redsonic.com</manufacturerURL>
    <modelNumber>105</modelNumber>
    -->
    <!-- Uncomment the line below if you have a Telegent TG100 -->
    <!--
       <upnp-string-limit>101</upnp-string-limit>
    -->
  </server>
  <import hidden-files="no">
    <filesystem-charset>UTF-8</filesystem-charset>
    <metadata-charset>CP932</metadata-charset>
    <scripting script-charset="UTF-8">
      <common-script>/usr/local/share/mediatomb/js/common.js</common-script>
      <playlist-script>/usr/local/share/mediatomb/js/playlists.js</playlist-script>
      <virtual-layout type="js">
        <import-script>/usr/local/share/mediatomb/js/user.js</import-script>
      </virtual-layout>
    </scripting>
    <mappings>
      <extension-mimetype ignore-unknown="no">
        <map from="mp3" to="audio/mpeg"/>
        <map from="ogg" to="application/ogg"/>
        <map from="m4v" to="video/mp4"/>
        <map from="mp4" to="video/mp4"/>
        <map from="mpg" to="video/mpeg"/>
        <map from="mpeg" to="video/mpeg"/>
        <map from="vob" to="video/mpeg"/>
        <map from="vro" to="video/mpeg"/>
        <map from="ts" to="video/mpeg"/>
        <map from="m2ts" to="video/avc"/>
        <map from="mts" to="video/avc"/>
        <map from="asf" to="video/x-ms-asf"/>
        <map from="asx" to="video/x-ms-asf"/>
        <map from="wma" to="audio/x-ms-wma"/>
        <map from="wax" to="audio/x-ms-wax"/>
        <map from="wmv" to="video/x-ms-wmv"/>
        <map from="wvx" to="video/x-ms-wvx"/>
        <map from="wm" to="video/x-ms-wm"/>
        <map from="wmx" to="video/x-ms-wmx"/>
        <map from="m3u" to="audio/x-mpegurl"/>
        <map from="pls" to="audio/x-scpls"/>
        <map from="flv" to="video/x-flv"/>
        <!-- Uncomment the line below for PS3 divx support -->
        <map from="avi" to="video/divx"/>
        <!-- Uncomment the line below for D-Link DSM / ZyXEL DMA-1000 -->
        <!-- <map from="avi" to="video/avi"/> -->
      </extension-mimetype>
      <mimetype-upnpclass>
        <map from="audio/*" to="object.item.audioItem.musicTrack"/>
        <map from="video/*" to="object.item.videoItem"/>
        <map from="image/*" to="object.item.imageItem"/>
      </mimetype-upnpclass>
      <mimetype-contenttype>
        <treat mimetype="audio/mpeg" as="mp3"/>
        <treat mimetype="application/ogg" as="ogg"/>
        <treat mimetype="audio/x-flac" as="flac"/>
        <treat mimetype="image/jpeg" as="jpg"/>
        <treat mimetype="audio/x-mpegurl" as="playlist"/>
        <treat mimetype="audio/x-scpls" as="playlist"/>
        <treat mimetype="audio/x-wav" as="pcm"/>
        <treat mimetype="video/x-msvideo" as="avi"/>
      </mimetype-contenttype>
    </mappings>
  </import>
  <transcoding enabled="no">
    <mimetype-profile-mappings>
      <transcode mimetype="video/x-flv" using="vlcmpeg"/>
      <transcode mimetype="application/ogg" using="vlcmpeg"/>
      <transcode mimetype="application/ogg" using="oggflac2raw"/>
      <transcode mimetype="audio/x-flac" using="oggflac2raw"/>
    </mimetype-profile-mappings>
    <profiles>
      <profile name="oggflac2raw" enabled="no" type="external">
        <mimetype>audio/L16</mimetype>
        <accept-url>no</accept-url>
        <first-resource>yes</first-resource>
        <accept-ogg-theora>no</accept-ogg-theora>
        <agent command="ogg123" arguments="-d raw -f %out %in"/>
        <buffer size="1048576" chunk-size="131072" fill-size="262144"/>
      </profile>
      <profile name="vlcmpeg" enabled="no" type="external">
        <mimetype>video/mpeg</mimetype>
        <accept-url>yes</accept-url>
        <first-resource>yes</first-resource>
        <accept-ogg-theora>yes</accept-ogg-theora>
        <agent command="vlc" arguments="-I dummy %in --sout #transcode{venc=ffmpeg,vcodec=mp2v,vb=4096,fps=25,aenc=ffmpeg,acodec=mpga,ab=192,samplerate=44100,channels=2}:standard{access=file,mux=ps,dst=%out} vlc:quit"/>
        <buffer size="14400000" chunk-size="512000" fill-size="120000"/>
      </profile>
    </profiles>
  </transcoding>
</config>
```

# 起動  {#e67ec29e}

```
# vi /etc/rc.conf
```


```
# MediaTomb
mediatomb_enable="YES"
mediatomb_flags="--port 8089"
mediatomb_logfile="/var/log/mediatomb.log"
mediatomb_pidfile="/var/run/mediatomb/mediatomb.pid"
```


```
# mkdir /var/run/mediatomb
# chown mediatomb:mediatomb /var/run/mediatomb
# /usr/local/etc/rc.d/mediatomb start
```

http://サーバ:8089/、ユーザー名mediatomb、パスワードmediatombで繋がる。
