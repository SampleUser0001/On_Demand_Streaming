# オンデマンド動画配信サイトを作成する

- [オンデマンド動画配信サイトを作成する](#オンデマンド動画配信サイトを作成する)
  - [コマンド](#コマンド)
  - [暗号化](#暗号化)
    - [暗号化手順](#暗号化手順)
  - [URL](#url)
  - [備考](#備考)

## コマンド
だいぶ遠回りしたがこれだけでよかったらしい…  

```
docker-compose up --build
```

## 暗号化
ダウンロードされたくないらしいけど、暗号化しておけばよくね？（暗号化はカネがかかるけど。）

### 暗号化手順
暗号鍵生成。（実際にはもっとわかりにくい名前にするんだろうな多分。）  
実際には然るべきサービスを使って生成するらしい。
```
openssl rand 16 > video.key
```

IV生成
```
openssl rand -hex 16
```

video.keyinfoファイル作成
```
touch video.keyinfo
```

中身は…
```
video.key
video.key
abcdef0123456789abcdef0123456789
```

※実際には下記らしい。
```
鍵ファイル生成の際に使用するURL
「暗号鍵生成」で生成したkeyファイルのファイルパス
「IV生成」で生成されたキー
```

動画暗号化  
事前にkeyファイル、keyinfoファイル、mp3ファイルを同じディレクトリにおいておく。
```
ffmpeg -i Mountain.mp4 -c:v copy -c:a copy -f hls -hls_key_info_file video.keyinfo -hls_time 9 -hls_playlist_type vod -hls_segment_filename "Mountain%3d.ts" Mountain.m3u8
```

作成されたファイルがこちら。然るべきパス（このリポジトリの場合はmovie配下）に置く。  
video.keyファイルも一緒に置く必要がある？（URLの都合かもしれない。）
```
-rw-r--r-- 1 ittimfn ittimfn 10151824 Jul 30 22:23 Mountain000.ts
-rw-r--r-- 1 ittimfn ittimfn  9244720 Jul 30 22:23 Mountain001.ts
-rw-r--r-- 1 ittimfn ittimfn  1364896 Jul 30 22:23 Mountain002.ts
-rw-r--r-- 1 ittimfn ittimfn      292 Jul 30 22:23 Mountain.m3u8
```

## URL

http://localhost

## 備考

- [Docker Hub : nginx](https://hub.docker.com/_/nginx)
- [Qiita : 簡単に作れる動画配信](https://qiita.com/yo_dazy/items/e14464367ec8d4a26b6a)  
  - HTMLだけ拝借。(Docker Hubのnginxに全部入ってるよ…)
- [pixabay](https://pixabay.com/ja/videos/)  
  - 動画取得元。
  - [ここ](https://pixabay.com/ja/videos/%E5%B1%B1-%E7%A9%BA-%E9%9C%A7-%E4%B8%98-%E7%A9%BA%E6%B0%97-%E6%A3%AE%E6%9E%97-34608/)からダウンロード。
- [blog.foresta.me : ffmpeg を使って mp4 を 暗号化されたHLS を生成する](https://blog.foresta.me/posts/generate_encrypted_hls_with_ffmpeg/)
