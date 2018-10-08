# データマイニング入門

## 授業の開始時に

http://localhost:8888 にアクセスする。

アクセスできない場合は，端末で`docker container start jupyter`を実行してから，再度アクセスする。

## すべての授業が終わったら

1. ターミナルで以下を実行し，利用していないコンテナ・イメージ等を削除する。

```{bash}
docker system prune
```

2. Docker Toolbox（Windowsの場合）またはDocker for Mac（macOSの場合）をアンインストールする。
