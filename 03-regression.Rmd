
# 機械学習

キーワード：クロスセクションデータ（cross-section data），時系列データ（time-series data）

|目標|説明|
|---|---|
|予測|未知の状況に対する予測をする。|
|パターンの発見|データから何らかのパターンを見出す。|
|理解|対象のしくみを理解する。|


キーワード：機械学習（machine learning）

キーワード：教師あり学習（supervised learning），出力変数（output variables），入力変数（input variables）

キーワード：教師なし学習（unsupervised learning）

キーワード：強化学習（rainforcement learning）

|名称|説明|
|---|---|
|**回帰（regression）**|出力変数が**量的（quantitative）**（つまり数値）であるもの。|
|**分類（classification）**|出力変数が**質的（qualitative）**または**カテゴリー（categorical）**であるもの。|


キーワード：回帰（regression），量的（quantitative），分類（classification），質的（qualitative），カテゴリー（categorical）

# 回帰1（単回帰）

## 自動車の停止距離

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
library(tidyverse)
library(caret)
my_data <- cars
ggplot(data = my_data, mapping = aes(x = speed, y = dist)) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE)
```

## データの確認

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_data <- cars # データに別名を付ける。
```

|目的|関数|
|---|---|
|データ数の確認|`dim`|
|表形式での表示|`head`|
|欠損値の有無，基本統計量の確認|`psych::describe`|
|可視化|`ggplot`|


```{r,cache=TRUE, warning=FALSE, message=FALSE}
dim(my_data) # データ数の表示
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
head(my_data) # 最初の数件の表示
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
psych::describe(my_data) # 基本統計量
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
ggplot(data = my_data, mapping = aes(x = speed, y = dist)) + # 可視化するデータ
  geom_point()                                               # 散布図
```

## 回帰分析1　回帰分析とは何か

キーワード：回帰分析（regression analysis）

キーワード：回帰式（regression equation）

|手法|説明|
|---|---|
|**線形回帰分析（linear regression analysis）**|入力変数と出力変数の関係を1次式つまり線形と仮定する回帰分析|
|**非線形回帰分析（non-linear regression analysis）**|線形回帰分析以外の回帰分析|


キーワード：線形回帰分析（linear regression analysis），非線形回帰分析（non-linear regression analysis）

キーワード：係数（coefficients）

|手法|説明|
|---|---|
|**単回帰分析（single regression analysis）**|入力変数が一つの場合の回帰分析|
|**重回帰分析（multiple regression analysis）**|入力変数が二つ以上の場合の回帰分析|


キーワード：単回帰分析（single regression analysis），重回帰分析（multiple regression analysis）

## 回帰分析2　訓練

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
g1 <- ggplot(data = my_data, mapping = aes(x = speed, y = dist)) +
  geom_point() +
  ggtitle("data")
g2 <- ggplot(data = my_data, mapping = aes(x = speed, y = dist)) +
  geom_point(size = 0) +
  stat_smooth(method = "lm", se = FALSE) +
  ggtitle("model")
tmp <- data.frame(speed = 21.5, dist = 66.96769)
g3 <- ggplot(data = my_data, mapping = aes(x = speed, y = dist)) +
  geom_point(size = 0) +
  stat_smooth(method = "lm", se = FALSE) +
  geom_pointrange(data = tmp, aes(ymin = 0, ymax = dist), linetype = "dotted") +
  geom_errorbarh(data = tmp, aes(xmin = 0, xmax = speed), linetype = "dotted") +
  ggtitle("prediction")
gridExtra::grid.arrange(g1, g2, g3, ncol = 3)
```

キーワード：訓練（training），訓練データ（training data）

キーワード：最小二乗法（least squares method）

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
```

キーワード：モデル式

|引数|値の例|内容|
|---|---|---|
|`form`|`dist ~ speed`|出力変数と入力変数を表すモデル式|
|`data`|`my_data`|訓練に使うデータ|
|`method`|`"lm"`|訓練に使う手法（「`lm`」はlinear model（線形モデル）のこと|


```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_result <- train(form = dist ~ speed, # モデル式
                   data = my_data,      # データ
                   method = "lm")       # 手法（線形回帰分析）
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_result$finalModel$coefficients # 係数の確認
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
tmp <- data.frame(speed = seq(from = min(my_data$speed), # speedの最小値から
                              to   = max(my_data$speed), #        最大値までを
                              length.out = 100))         # 100分割し，100個の点を得る。
tmp$dist <- my_result %>% predict(tmp)                   # 100個のspeedについて，distを予測する。
ggplot(mapping = aes(x = speed, y = dist)) + # x軸をspeed，y軸をdistとして，
  geom_point(data = my_data) +               # 訓練に使ったデータ（散布図）
  geom_line(data = tmp)                      # 上で作ったデータに対する予測（折れ線グラフ）
```

## 回帰分析3　予測

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
my_result <- train(form = dist ~ speed, data = my_data, method = "lm")
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_test <- data.frame(speed = c(21.5)) # 予測対象の準備
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_result %>% predict(my_test) # 予測対象に対する予測
```

**練習：速度が10.5のときの停止距離を求めてください。**

## 回帰分析4　訓練データの再現

キーワード：残差（residual）

キーワード：RMSE（root mean squared error）

キーワード：訓練RMSE

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
my_result <- train(form = dist ~ speed, data = my_data, method = "lm") # モデル生成
my_data$prediction <- my_result %>% predict(my_data)                   # 予測
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_data$residual <- my_data$dist - my_data$prediction # 残差
head(my_data)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# モデルを可視化する汎用的な方法
my_line <- data.frame(speed = seq(from = min(my_data$speed),    # speedの最小値から
                                  to = max(my_data$speed),      #        最大値までを
                                  length.out = 100))            #        分割し，100個の点を作る。
my_line$dist <- my_result %>% predict(my_line)                  # 100個のspeedについて，distを予測する。
ggplot(mapping = aes(x = speed, y = dist)) +                    # 横軸はspeed，縦軸はdist
  geom_point(data = my_data) +                                  # データを点で描く。
  geom_line(data = my_line) +                                   # モデルを線で描く。
  geom_linerange(data = my_data,                                # 残差を鉛直線分で描く。
                 mapping = aes(ymin = dist, ymax = prediction), #   範囲は，distからdistの予測値まで。
                 linetype = "dotted")                           #   点線にする。
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
sqrt(mean(my_data$residual^2))
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
RMSE(my_data$prediction, my_data$dist)
```

## 訓練RMSEの問題点

### 第1の例（訓練RMSEが0になる例）

キーワード：多項式（polynomial regression）

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
my_idx <- c(2, 7, 11, 18, 27, 30, 34, 38, 39, 44) # 抜き出すデータの番号
my_train <- my_data[my_idx, ]                     # データを抜き出す。
ggplot(mapping = aes(x = speed, y = dist)) + # x軸はspeed，y軸はdistとする。
  geom_point(data = my_train,                # 訓練データの描画
             color = "red", size = 3)        # 散布図
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_result <- train(form = dist ~ poly(speed, degree = 10, raw = TRUE),
                   data = my_train, method = "lm")
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_pred <- my_result %>% predict(my_train)
postResample(my_pred, my_train$dist)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
tmp <- data.frame(speed = seq(from = min(my_data$speed), # speedの最小値から
                              to   = max(my_data$speed), #        最大値までを
                              length.out = 100))         # 100分割し，100個の点を得る。
tmp$dist <- my_result %>% predict(tmp)                   # 100個のspeedについて，distを予測する。
ggplot(mapping = aes(x = speed, y = dist)) + # x軸はspeed，y軸はdistとする。
  coord_cartesian(ylim = c(0, 120)) +        # y座標の範囲を限定する。
  geom_point(data = my_train,                # 訓練データの描画
             color = "red", size = 3) +      # 散布図
  geom_point(data = my_data[-my_idx, ]) +    # 訓練に使わなかったデータ
  geom_line(data = tmp)                      # モデル（折れ線グラフ）
```

### 第2の例（訓練RMSEが同じになるデータ）

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
library(tidyverse)
library(caret)
my_data <- data.frame(
  X1 = c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5),
  X2 = c(8, 8, 8, 8, 8, 8, 8, 19, 8, 8, 8),
  Y1 = c(8.04, 6.95, 7.58, 8.81, 8.33, 9.96, 7.24, 4.26, 10.84, 4.82, 5.68),
  Y2 = c(9.14, 8.14, 8.74, 8.77, 9.26, 8.10, 6.13, 3.10, 9.13, 7.26, 4.74),
  Y3 = c(7.46, 6.77, 12.74, 7.11, 7.81, 8.84, 6.08, 5.39, 8.15, 6.42, 5.73),
  Y4 = c(6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.50, 5.56, 7.91, 6.89))
g1 <- ggplot(data = my_data,
             mapping = aes(x = X1, y = Y1)) +
  xlim(0, 20) + ylim(0, 15) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE, fullrange = TRUE) +
  ggtitle("a: {X1, Y1}")
g2 <- ggplot(data = my_data,
             mapping = aes(x = X1, y = Y2)) +
  xlim(0, 20) + ylim(0, 15) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE, fullrange = TRUE) +
  ggtitle("b: {X1, Y2}")
g3 <- ggplot(data = my_data,
             mapping = aes(x = X1, y = Y3)) +
  xlim(0, 20) + ylim(0, 15) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE, fullrange = TRUE) +
  ggtitle("c: {X1, Y3}")
g4 <- ggplot(data = my_data,
             mapping = aes(x = X2, y = Y4)) +
  xlim(0, 20) + ylim(0, 15) +
  geom_point() +
  stat_smooth(method = "lm", se = FALSE, fullrange = TRUE) +
  ggtitle("d: {X2, Y4}")
gridExtra::grid.arrange(g1, g2, g3, g4, ncol = 2)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_result1 <- train(form = Y1 ~ X1, data = my_data, method = "lm")
my_result2 <- train(form = Y2 ~ X1, data = my_data, method = "lm")
my_result3 <- train(form = Y3 ~ X1, data = my_data, method = "lm")
my_result4 <- train(form = Y4 ~ X2, data = my_data, method = "lm")
c(my_result1$results$RMSE,
  my_result2$results$RMSE,
  my_result3$results$RMSE,
  my_result4$results$RMSE)
```

**練習：{入力変数, 出力変数}の組み合わせが{X1, Y2}, {X1, Y3}, {X2, Y4}の場合について，回帰分析を行い，係数と訓練RMSEを求めて下さい。**

**練習：{入力変数, 出力変数}の組み合わせが{X1, Y2}, {X1, Y3}, {X2, Y4}の場合について，散布図と回帰直線を描いてください。**

## K最近傍法

キーワード：K最近傍法（K-nearest neighbor, KNN）

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
library(tidyverse)
library(caret)
my_data <- cars
my_result <- train(form = dist ~ speed, data = my_data, method = "knn")
my_data$prediction <- my_result %>% predict(my_data)  # 予測
my_data$residual <- my_data$dist - my_data$prediction # 残差
tmp <- data.frame(speed = seq(from = min(my_data$speed), to = max(my_data$speed), length.out = 100))
tmp$dist <- my_result %>% predict(tmp)
ggplot(mapping = aes(x = speed, y = dist)) +
  geom_point(data = my_data) + # データ
  geom_line(data = tmp)        # モデル
```

キーワード：インスタンスベースの学習（instance-based learning），怠惰学習（lazy learning），ノンパラメトリック（non-parametric），パラメトリック（parametric）

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
my_result <- train(form = dist ~ speed, data = my_data, method = "knn")
```

**練習：速度が21.5のときの停止距離を求めてください。**

**練習：データとモデルを一緒に描いてください。**

## 標準化

キーワード：標準化（standardization）

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
psych::describe(my_data)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_speed_mean <- mean(my_data$speed)
my_speed_sd <- sd(my_data$speed)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_scaled_speed <- (my_data$speed - my_speed_mean) / my_speed_sd
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
psych::describe(my_scaled_speed)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
tmp <- my_data$speed * my_speed_sd + my_speed_mean
psych::describe(tmp)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_scaled_data <- scale(my_data)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
c(attr(my_scaled_data, "scaled:center")["speed"], #平均
  attr(my_scaled_data, "scaled:scale")["speed"])  #標準偏差
```

## ニューラルネットワーク

キーワード：ニューラルネットワーク（neural network, NN）

```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
library(tidyverse)
library(caret)
my_data <- cars
my_result <- train(form = dist ~ speed, data = my_data, method = "nnet",
                   linout = TRUE,                     # 回帰（nnetで回帰を行う際は必須）
                   preProcess = c("center", "scale")) # 標準化
my_data$prediction <- my_result %>% predict(my_data)  # 予測
my_data$residual <- my_data$dist - my_data$prediction # 残差
tmp <- data.frame(speed = seq(from = min(my_data$speed), to = max(my_data$speed), length.out = 100))
tmp$dist <- my_result %>% predict(tmp)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
ggplot(mapping = aes(x = speed, y = dist)) +
  geom_point(data = my_data) + # データ
  geom_line(data = tmp)        # モデル
```

キーワード：ニューロン（neuron）

キーワード：標準シグモイド関数（standard sigmoid function ）

```{r,cache=TRUE, warning=FALSE, message=FALSE}
f <- function(x) { 1 / (1 + exp(-x)) }
plot(f, from = -6, to = 6)
```

キーワード：フィードフォワードニューラルネットワーク（feedforward neural network）

キーワード：パーセプトロン（Perceptron），多層パーセプトロン（multilayer perceptron, MLP）

|オプション|説明|
|---|---|
|`linout = TRUE`|ニューラルネットワークで回帰を行う。|
|`preProcess = c("center", "scale")`|訓練データの標準化，つまり訓練データの各変数の平均を0（`center`の効果），標準偏差を1（`scale`の効果）にする。|


```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
my_result <- train(form = dist ~ speed, data = my_data, method = "nnet",
                   linout = TRUE,                     # 回帰（nnetで回帰を行う際は必須）
                   preProcess = c("center", "scale")) # 標準化
```

**練習：速度が21.5のときの停止距離を求めてください。**

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_test <- data.frame(speed = c(21.5))
my_result %>% predict(my_test)
```

**練習：データとモデルを一緒に描いてください。**

```{r,cache=TRUE, warning=FALSE, message=FALSE}
w <- my_result$finalModel$wts          # 重み（訓練結果）
f <- function(x) { 1 / (1 + exp(-x)) } # 隠れ層の活性化関数（標準シグモイド関数）
g <- function(x) { x }                 # 出力層の活性化関数（何もしない）
h <- function(x) {                     # 標準化したspeedからdistを計算する関数（ニューロン数は3個）
  g(w[7] +
    w[8]  * f(w[1] + w[2] * x) +
    w[9]  * f(w[3] + w[4] * x) +
    w[10] * f(w[5] + w[6] * x))
}
my_line <- data.frame(speed = seq(from = min(my_data$speed),
                                  to = max(my_data$speed),
                                  length.out = 100))
my_line$dist <- h((tmp$speed - mean(my_data$speed)) / sd(my_data$speed)) # 標準化してから予測する。
ggplot(mapping = aes(x = speed, y = dist)) +
  geom_point(data = my_data) +
  geom_line(data = my_line)
# 結果は割愛
```

## 予測性能の見積り

キーワード：訓練データ（training data），検証データ（validation data）

キーワード：検証RMSE

```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
my_result <- train(form = dist ~ speed, data = my_data, method = "lm")
my_result$results
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_result <- train(form = dist ~ speed, data = my_data, method = "knn")
my_result$results
```

**練習：検証RMSEが最小の場合だけを表示させてください。**

```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
my_result <- train(form = dist ~ speed, data = my_data, method = "nnet",
                   linout = TRUE,                     # 回帰（nnetで回帰を行う際は必須）
                   preProcess = c("center", "scale")) # 標準化
my_result$results
```

## 交差検証

|手法|説明|
|---|---|
|**ホールドアウト法（holdout method）**|データの一部を訓練データとして訓練し，残りを検証データにして検証する。|
|**K分割交差検証（k-fold cross-validation）**|データをKグループに分け，(K-1)グループをまとめて訓練データとして訓練し，残りの1グループを検証データにして検証する。この作業をK回繰り返し，すべてのグループが1回ずつ検証データになるようにする。|
|**反復的K分割交差検証**|K分割交差検証を複数回繰り返す。|
|**一個抜き交差検証（leave-one-out cross-validation, LOOCV）**|i番目だけを除いたデータで訓練したモデルで，i番目のデータについての予測を行う。iを1からデータ数（n）まで動かすことで，すべてのデータについての予測値を得る。|
|**ブートストラップ（bootstrap）**|ブートストラップで訓練データと検証データを作る。Rの`train`はデフォルトではこれを使う。データのおよそ63.2\%を訓練に使う手法である。|


キーワード：ホールドアウト法（holdout method），K分割交差検証（k-fold cross-validation），反復的K分割交差検証，一個抜き交差検証（leave-one-out cross-validation, LOOCV），ブートストラップ（bootstrap）

|手法|`trainControl`の内容|
|---|---|
|ホールドアウト法|`method = "LGOCV", p = 0.75, number = 25`|
|K分割交差検証|`method = "cv", number = 10`|
|反復的K分割交差検証|`method = "repeatedcv", number = 10, repeats = 1`|
|一個抜き交差検証|`method = "LOOCV"`|
|ブートストラップ|`method = "boot", number = 25`（デフォルト）|
|何もしない|`method = "none"`（この記述がなければブートストラップ）|


```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
my_result <- train(form = dist ~ speed, data = my_data, method = "lm",
                   trControl = trainControl(method = "cv", number = 5))
my_result$results
```

## パラメータチューニング

```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
my_result <- train(form = dist ~ speed, data = my_data, method = "knn",
                   tuneGrid = expand.grid(k = c(1:15)), # パラメータチューニング
                   trControl = trainControl(method = "repeatedcv", number = 5, repeats = 20))
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
#ggplot(my_result) # エラーバーが不要ならこれでよい。
ggplot(data = my_result$results, mapping = aes(x = k, y = RMSE)) +
  geom_point() +
  geom_line() +
  geom_errorbar(mapping = aes(x = k, ymin = RMSE - RMSESD, ymax = RMSE + RMSESD), width = 0.2)
```

**練習：ニューラルネットワークのの隠れ層のニューロンの数を1から10まで変化させて，検証RMSEが最小になる場合を調べてください。decayは0.1程度に固定してかまいません。**

## 並列計算

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(doParallel)
cl <- makeCluster(detectCores())
registerDoParallel(cl)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
library(tidyverse)
library(caret)
my_data <- cars
system.time(
my_result <- train(form = dist ~ speed, data = my_data, method = "nnet",
                   linout = TRUE,
                   preProcess = c("center", "scale"),
                   trControl = trainControl(method = "repeatedcv", number = 5, repeats = 5)))
```

## 補足：モデルの柔軟さと予測性能

キーワード：過学習，オーバーフィッティング（over-fitting）

### K最近傍法

```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(0)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 並列処理の準備
library(doParallel)
cl <- makeCluster(detectCores())
registerDoParallel(cl)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
library(tidyverse)
library(caret)
my_data <- cars
my_folds <- createMultiFolds(y = my_data$dist, k = 5, times = 10) # 反復型5分割交差検証（反復10回）
my_results <- foreach (my_index = my_folds,                            # すべて分割方法をすべて試す。
                       .combine = rbind,                               # 結果は行方向に追記する。
                       .export = "my_data",                            # 並列処理のための準備
                       .packages = c("doParallel", "caret")) %dopar% { # 並列処理
  my_train       <- my_data[ my_index,]       # 訓練データ
  my_validation  <- my_data[-my_index,]       # 検証データ
  foreach (k = 1:15, .combine = rbind) %do% { # 1から15のkについて調べ，行として出力する。
    my_result <- train(form = dist ~ speed, data = my_train, method = "knn",
                       trControl = trainControl(method = "none"), # trainでは検証しない。
                       tuneGrid = expand.grid(k = c(k)))
    my_train_rmse       <- RMSE(predict(my_result, my_train),       my_train$dist)       # 訓練RMSE
    my_validation_rmse  <- RMSE(predict(my_result, my_validation),  my_validation$dist)  # 検証RMSE
    data.frame(k = k, training = my_train_rmse, validation = my_validation_rmse) # 結果をデータフレームにする。
  }
}
tmp <- gather(my_results, key = "data", value = "RMSE", training, validation) # 縦型に変換
ggplot(data = tmp, mapping = aes(x = k, y = RMSE, color = data)) +   # 横軸はk，縦軸はRMSE，訓練と検証で色分け
  stat_summary(geom = "line", fun.y = mean) +                        # RMSEの平均を折れ線グラフにする。
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.2) + # RMSEの標準偏差をエラーバーにする。
  scale_x_continuous(breaks = 1:15) +                                # 横軸は1から15まで。
  labs(x = "k", y = "mean(RMSE)")                                    # 軸にラベルを付ける。
```

### 回帰分析

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
library(tidyverse)
library(caret)
my_data <- cars
my_model <- lm(formula = dist ~ poly(speed, degree = 3, raw = TRUE), data = my_data)
tmp <- data.frame(speed = seq(from = min(my_data$speed), to = max(my_data$speed), length.out = 100))
tmp$dist <- my_model %>% predict(tmp)
ggplot(mapping = aes(x = speed, y = dist)) +
  geom_point(data = my_data) +
  geom_line(data = tmp)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
set.seed(5)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 並列処理の準備
library(doParallel)
cl <- makeCluster(detectCores())
registerDoParallel(cl)
```

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
library(tidyverse)
library(caret)
my_data <- cars
my_folds <- createMultiFolds(y = my_data$dist, k = 5, times = 10) # 反復型5分割交差検証（反復10回）
my_results <- foreach (my_index = my_folds,                            # すべて分割方法をすべて試す。
                       .combine = rbind,                               # 結果は行方向に追記する。
                       .export = "my_data",                            # 並列処理のための準備
                       .packages = c("doParallel", "caret")) %dopar% { # 並列処理
  my_train       <- my_data[ my_index,]       # 訓練データ
  my_validation  <- my_data[-my_index,]       # 検証データ
  foreach (d = 1:7, .combine = rbind) %do% { # 1次式から10次式まで調べ，行として出力する。
    my_model <- lm(formula = dist ~ poly(speed, degree = d, raw = TRUE), data = my_train)
    my_train_rmse       <- RMSE(predict(my_model, my_train),       my_train$dist)       # 訓練RMSE
    my_validation_rmse  <- RMSE(predict(my_model, my_validation),  my_validation$dist)  # 検証RMSE
    my_aic <- extractAIC(my_model)[2]
    data.frame(degree = d, training = my_train_rmse, validation = my_validation_rmse, AIC = my_aic)
  }
}
tmp <- gather(my_results, key = "data", value = "RMSE", training, validation) # 縦型に変換
ggplot(data = tmp, mapping = aes(x = degree, y = RMSE, color = data)) + # 横軸はdegree，縦軸はRMSE，訓練と検証で色分け
  stat_summary(geom = "line", fun.y = mean) +                           # RMSEの平均を折れ線グラフにする。
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.2) +    # RMSEの標準偏差をエラーバーにする。
  scale_x_continuous(breaks = 1:7) +                                    # 横軸は1から7まで。
  labs(x = "degree", y = "mean(RMSE)")                                  # 軸にラベルを付ける。
```

キーワード：赤池情報量規準（Akaike's Information Criterion, AIC）

```{r,cache=TRUE, warning=FALSE, message=FALSE}
# 説明のためのコード（現時点での理解は不要）
ggplot(data = my_results, mapping = aes(x = degree, y = AIC)) +
  stat_summary(geom = "line", fun.y = mean) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.2) +
  scale_x_continuous(breaks = 1:7) +
  labs(x = "degree")
```
