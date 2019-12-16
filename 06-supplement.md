ある学生の生活

|実験|授業|天気|家を|
  |--|--|--|--|
  |有|無|雨|出ない|
  |有|有|晴れ|出る|
  |有|有|雨|出ない|
  |無|有|雨|出ない|
  |無|有|晴れ|出る|

1. 上のデータをExcelで作り，CSV形式（student-life.csv）で保存する．（テキストエディタでCSVファイルを作ってもよい．）
1. RStudio Cloudにアップロードする．（右下のFilesタブのUploadボタンを押す。）
1. RStudio Cloudで新しい「R Script」を作り，以下のコードを貼り付け，実行して結果を確認する．

データを作るときは，後で問題が起きないように，ASCII文字だけを使う．（例：有→T，無→F，雨→rainy，晴れ→sunny，出ない→F，出る→T．ラベルはexperiment，weather，lecture，goout，など）

```r
install.packages(c("RWeka", "e1071", "partykit", "rpart.plot"))
```

```r
library(tidyverse)
library(caret)
my_data <- read_csv("student-life.csv")
# my_data <- read_csv("https://gist.githubusercontent.com/taroyabuki/3ef73490cf8e5d3db1927c210e32891c/raw/5e3f84c2bae0ca4fffd05199467c181f700626e3/students-life.csv")
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

```r
# 少し詳しく調べる場合
library(doParallel)
cl <- makeCluster(detectCores())
registerDoParallel(cl)

my_result <- train(form = Species ~ ., data = iris, method = "J48")
my_result$results
my_result <- train(form = Species ~ ., data = iris, method = "J48",
                   tuneLength = 10,
                   trControl = trainControl(method = "repeatedcv", number = 5, repeats = 20))
my_result$results %>% filter(Accuracy == max(Accuracy))

my_result <- train(form = Species ~ ., data = iris, method = "rpart")
my_result$results
my_result <- train(form = Species ~ ., data = iris, method = "rpart",
                   tuneGrid = expand.grid(cp = seq(0, 0.2, 0.01)),
                   trControl = trainControl(method = "repeatedcv", number = 5, repeats = 20))
my_result$results %>% filter(Accuracy == max(Accuracy))
```
