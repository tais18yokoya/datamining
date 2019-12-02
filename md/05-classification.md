
# 分類1（多値分類）

キーワード：分類

キーワード：多値分類

## アヤメの分類

```r
library(tidyverse)
library(caret)
my_data <- iris
head(my_data)
```

**練習：各変数の平均をSpeciesごとに求めてください．**

```r
my_data %>%
  group_by(Species) %>%
  summarize(sl_mean = mean(Sepal.Length), sw_mean = mean(Sepal.Width),
            pl_mean = mean(Petal.Length), pw_mean = mean(Petal.Width))
```

**練習：横軸がSepal.Length，縦軸がSepal.Width，点の色がSpeciesに相当するような散布図を描いてください．**

```r
my_data %>%
  ggplot(mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()
```

## 分類のための手法

## k最近傍法

```r
set.seed(0)
```

```r
library(tidyverse)
library(caret)
my_data <- iris
my_result <- train(form = Species ~ ., data = my_data, method = "knn")
```

```r
my_test <- tribble(
~Sepal.Length, ~Sepal.Width, ~Petal.Length, ~Petal.Width,
          5.0,          3.5,           1.5,          0.5,
          6.5,          3.0,           5.0,          2.0
)
```

```r
my_result %>% predict(my_test)
```

```r
my_result %>% predict(my_test, type = "prob")
```

## 訓練データの再現

キーワード：混同行列

キーワード：正解率

キーワード：訓練正解率

```r
set.seed(0)
```

```r
library(tidyverse)
library(caret)
my_data <- iris
my_result <- train(form = Species ~ ., data = my_data, method = "knn")
my_pred <- my_result %>% predict(my_data) # 訓練データの再現
table(my_pred, my_data$Species)           # 混同行列の作成
```

```r
mean(my_pred == my_data$Species)
```

```r
confusionMatrix(data = my_pred, reference = my_data$Species)
# 結果は割愛
```

## 予測性能の見積り

キーワード：検証正解率

```r
set.seed(0)
```

```r
library(tidyverse)
library(caret)
my_data <- iris
my_result <- train(form = Species ~ ., data = my_data, method = "knn")
my_result$results
```

## 交差検証とパラメータチューニング

**練習：アヤメの分類をk最近傍法で行う場合の検証正解率を，5分割交差検証（反復10回）で調べてください。**

```r
set.seed(0)
```

```r
my_result <- train(form = Species ~ ., data = my_data, method = "knn",
                   trControl = trainControl(method = "repeatedcv", number = "5", repeats = 10))
my_result$results
```

**練習：アヤメの分類をk最近傍法で行う場合の最良のkを，1から10の中から選んでください。**

```r
set.seed(0)
```

```r
library(tidyverse)
library(caret)
my_data <- iris
my_result <- train(form = Species ~ ., data = my_data, method = "knn",
                   tuneGrid = expand.grid(k = c(1:10)))
#ggplot(my_knn_result) # エラーバーが不要ならこれでよい。
ggplot(data = my_result$results, mapping = aes(x = k, y = Accuracy)) +
  geom_point() +
  geom_line() +
  geom_errorbar(mapping = aes(x = k, ymin = Accuracy - AccuracySD, ymax = Accuracy + AccuracySD), width = 0.2)
```

## ニューラルネットワーク

```r
set.seed(0)
```

```r
library(tidyverse)
library(caret)
my_data <- iris
my_result <- train(form = Species ~ ., data = my_data, method = "nnet",
                   preProcess = c("center", "scale")) # 標準化
```

```r
my_result$results
```

## 分類木

キーワード：分類木

キーワード：木，グラフ

キーワード：葉

```r
set.seed(0)
```

```r
library(tidyverse)
library(caret)
my_data <- iris
my_result <- train(form = Species ~ ., data = my_data, method = "rpart")
```

```r
rpart.plot::rpart.plot(my_result$finalModel, digit = 3, type = 5)
```

```r
my_result$results
```

## バギング，ランダムフォレスト，ブースティング

キーワード：バギング

キーワード：ランダムフォレスト

キーワード：ブースティング

```r
set.seed(0)
```

```r
library(tidyverse)
library(caret)
my_data <- iris
my_result <- train(form = Species ~ ., data = my_data, method = "rf")
my_result$results
```

```r
set.seed(0)
```

```r
library(tidyverse)
library(caret)
my_data <- iris
my_result <- train(form = Species ~ ., data = my_data, method = "xgbTree")
my_result$results %>% filter(Accuracy == max(my_result$results$Accuracy)) # 検証正解率が最大になるとき
```

## 変数の重要度

```r
set.seed(0)
```

```r
library(tidyverse)
library(caret)
my_data <- iris
my_result <- train(form = Species ~ ., data = my_data, method = "rf")
varImp(my_result) # 変数の重要度
```

```r
plot(varImp(my_result))
```
