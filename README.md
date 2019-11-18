# データマイニング入門

* 実行環境：[RStudio Cloud](https://rstudio.cloud/)
* 実行環境（バックアップ）：[Try Jupyter with R](https://jupyter.org/try)

## RStudio Cloud

[RStudio Cloud](https://rstudio.cloud/)を使う。

1. 「Sign Up」をクリックしてアカウントを作る。（サービスの連携が気にならなければ，Sign up with GoogleやSign up with GitHubでもよい。）
1. 「Log in」をクリックしてログインする。
1. 「New Project」をクリックしてプロジェクトを作る。
1. プロジェクト名を「Untitled Project」から「data mining」に変える。（授業では，常にこのプロジェクトを使う。）

**授業開始時にRStudio Cloudにログインしておくこと。**

番号|見やすい表示|ファイル
---|---|---
1|イントロダクション|
2|[R入門](md/02-introduction.md)|02-introduction.Rmd
3|[単回帰](md/03-regression.md)|03-regression.Rmd
4|[重回帰](md/04-regression.md)|04-regression.Rmd

ファイルの使い方：

```r
# 2「R入門」
system("wget https://raw.githubusercontent.com/taroyabuki/datamining/master/02-introduction.Rmd")
# 02-introduction.Rmdというファイルができるから，クリックして開く。
# メモをこのファイルに書き込みながら試す。以下を全部できれば終了。
# カーソルのある行のコードは，Ctrl＋Enterで実行できる。
```

```r
# 3「単回帰」
system("wget https://raw.githubusercontent.com/taroyabuki/datamining/master/03-regression.Rmd")
```

```r
# 4「重回帰」
system("wget https://raw.githubusercontent.com/taroyabuki/datamining/master/04-regression.Rmd")
system("mkdir -p data/")

```

## レポート

## 1回目

```r
# テンプレート
system("wget https://raw.githubusercontent.com/taroyabuki/datamining/master/report1.Rmd")
system("mkdir -p data/house-prices-advanced-regression-techniques")
system("wget -P data/house-prices-advanced-regression-techniques https://raw.githubusercontent.com/taroyabuki/datamining/master/data/house-prices-advanced-regression-techniques/train.csv")
system("wget -P data/house-prices-advanced-regression-techniques https://raw.githubusercontent.com/taroyabuki/datamining/master/data/house-prices-advanced-regression-techniques/test.csv")
```

提出先：https://docs.google.com/forms/d/e/1FAIpQLSdryfqTuzbxoy3PV-_7r5Q_47gOtxB3OOLtNfnPLxSKZTCGUA/viewform
