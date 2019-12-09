ある学生の生活

|実験|授業|天気|家を|
|--|--|--|--|
|有|無|雨|出ない|
|有|有|晴れ|出る|
|有|有|雨|出ない|
|無|有|雨|出ない|
|無|有|晴れ|出る|

1. 上のデータをExcelで作り，CSV形式（student-life.csv）で保存する．（テキストエディタでCSVファイルを作ってもよい．）
1. RStudio Cloudにアップロードする．（右下のファイルタブのUploadボタンを押す。）

データを作るときは，後で問題が起きないように，ASCII文字だけを使う．（例：有→T，無→F，雨→rainy，晴れ→sunny，出ない→F，出る→T．ラベルはexperiment，weather，lecture，goout，など）

```r
install.packages(c("RWeka", "e1071", "partykit", "rpart.plot"))
```

```r
library(tidyverse)
library(caret)
my_data <- read_csv("student-life.csv")
my_data
```

```r
# 出力変数を因子にする．
my_data$goout <- as.factor(my_data$goout)
my_data
```

```r
# 決定木の描画
my_result <- train(form = goout ~ ., data = my_data, method = "J48")
plot(my_result$finalModel)
```

```r
# 訓練データの再現，混同行列の作成
my_pred <- my_result %>% predict(my_data)
confusionMatrix(data = my_pred, reference = my_data$goout)
```

**練習：J48を使って決定木を作る作業を，アヤメ（iris）でもやってみる．**
