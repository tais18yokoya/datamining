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

ファイルの使い方：

たとえば2を学ぶ場合，RStudioのコンソールで次を実行する（最後がファイル名）。

```r
system("wget https://raw.githubusercontent.com/taroyabuki/datamining/master/02-introduction.Rmd")
```

02-introduction.Rmdというファイルができるから，クリックして開く。

```r
system("wget https://raw.githubusercontent.com/taroyabuki/datamining/master/03-regression.Rmd")
```

メモをこのファイルに書き込みながら試す。以下を全部できれば終了。
カーソルのある行のコードは，Ctrl＋Enterで実行できる。
