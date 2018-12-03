---
title: "回帰（Excelでの回帰分析）"
output: html_document
---

## 例題1：⾃動⾞の速度と停⽌距離（続き）

### 訓練データとテストデータ

引き続き，⾃動⾞の速度と停⽌距離のデータを使う。

```{r}
library(tidyverse)
library(caret)

my_data <- cars

# 正しい方法
#my_index <- sample(1:50, 10)

# 汎用的な方法
#my_index <- sample(1:nrow(my_data), 0.2 * nrow(my_data))

# 授業の再現
my_index <- c(5, 6, 10, 12, 20, 25, 31, 34, 40, 48)
my_train <- my_data[-my_index,]
my_test <- my_data[my_index,]

# Excel用に，ファイルを保存する。
write_csv(my_train, 'my_train.csv')
write_csv(my_test, 'my_test.csv')
```

**復習：** 線形単回帰分析を行う。（これと同じ結果をExcelで出せればよい。）

```{r}
my_result <- train(form = dist ~ speed, data = my_train, method = "lm")
summary(my_result)

# 訓練RMSE
my_train$prediction <- predict(object = my_result, newdata = my_train)
postResample(pred = my_train$prediction, obs = my_train$dist)
```

```{r}
# テストRMSE
my_test$prediction <- predict(object = my_result, newdata = my_test)
postResample(pred = my_test$prediction, obs = my_test$dist)
```

### Excelでの回帰分析

4つの方法がある。

1. 散布図
1. FORECAST.LINEAR()
1. 分析ツールの「回帰分析」
1. ソルバー

Excelのデータタブに，「データ分析」と「ソルバー」がない場合は，ファイル→オプション→

各種法の概略は以下の通り。

#### 散布図

1. my_train.csvをExcelで開く。
1. 横軸をspeed，縦軸をdistとする散布図を描く。
1. 散布図に近似曲線を追加する。
1. 近似曲線のオプションとして，数式を表示する。
1. 数式をメモする。（この作業があまりよくない。）
1. my_test.csvをExcelで開く。
1．上でメモした数式を使って，distの予測値を計算する。
1. テストRMSEを計算する。

#### FORECAST.LINEAR()

1. my_train.csvのデータの下に，my_test.csvのデータをコピーする。（わかりやすいように，色分けしておくとよい。）
1. `FORECAST.LINEAR(x, 既知のy, 既知のx)`でdistを予測する。ただし，`x`はspeed，`既知のy`は訓練データのdist，`既知のx`は訓練データのspeedである。
1. テストRMSEを計算する。
1．（この方法ではy=ax+bのaとbは直接は求められないが，speedが0の時の予測値がbである。）
1. （この方法ではy=ax+bのaとbは直接は求められないが，speedが1の時の予測値-bがaである。）

#### 分析ツールの「回帰分析」

1. 分析ツールの「回帰分析」を起動する。
1. 「入力Y範囲」を訓練データのdist，「入力X範囲」を訓練データのspeedとする。ラベル（見出し）も含める。
1. 「ラベル」を有効にする。
1. 一覧の出力先を`F1`とする。
1. 回帰分析の結果を使って，distの予測値を計算する。
1. テストRMSEを計算する。

#### ソルバー

1. y=ax+bを適当に決め，適当なセルに入力する。（ここではa=1，b=1とし，F1にaの値つまり`1`，F2にbの値つまり`1`を入力したとする。）
1. 訓練RMSEを求めるシートを作る。（ここではF3に訓練RMSEが格納されるとする。）
1. ソルバーを起動する。
1. 目的セルをF3とする。
1. 目標値を「最小値」とする。
1. 変数セルをF1:F2とする。
1. 「制約のない変数を非負数にする」のチェックを外す。
1. 「解決」
1. F1とF2の値を使って，distの予測値を計算する。
1. テストRMSEを計算する。

補足：残差の代わりに`Abs(実測値-予測値)/実測値`のような基準で訓練することもできる。この場合の結果は，dist = 2.93333 * speed - 9.73333となる。

**レポート課題04：Excelで線形単回帰分析をする4つの方法を試し，それぞれの手法の長所と短所をまとめてください。ヒント：以下のような項目に着目するといいでしょう。**

* わかりやすいか。
* 使いやすいか。
* データの変更が最終結果（テストRMSE）に反映されるか。
* どのような結果が得られるか。
* 回帰分析についての理解を深めるのに役立つか。
