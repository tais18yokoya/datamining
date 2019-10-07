# 02 R入門

## よく使うパッケージ

### インストール

```r
# 一度だけ実行すればよい。（RStudioの警告に付随する「Install」を使ってもよい。）
install.packages('tidyverse')
install.packages('caret')
install.packages('psych')
```

### 読み込み

```r
# 毎回実行する
library(tidyverse)
library(caret)
```

## データの表現

### 数値

```r
a <- 2
b <- 3
a + b # 計算
```

```r
c <- a + b # 計算結果の割り当て
c          # 結果の表示
```

次のように全体を丸括弧で囲むと，上の2行が1行で済むようになるが，この資料ではこの記法は使わない。

```r
(c <- a + b)
```

### 文字列

部分文字列（その2）は略記法。この資料では，引数が一つの場合や，順番が重要でない場合のみ用いる。

```r
s <- "abcde" # 'abcde'でもよい。

substr(x = s, start = 2, stop = 3) # 部分文字列（その1）
substr(s, 2, 3)                    # 部分文字列（その2）
s %>% substr(start = 2, stop = 3)  # 部分文字列（その3）
```

```r
t <- "fgh"
paste(s, t, sep = ':') # 文字列の連結
```

### ベクトル

```r
vec1 <- c(1, 1, 2, 3, 5)
```

```r
length(vec1) # 要素数
```

```r
vec1[3] # 特定の要素
```

```r
vec1 + 10 # ベクトルに数を足す。
```

```r
vec1 * 10 # ベクトルに数を掛ける。
```

```r
vec1 <- c(1,  1,   2,    3,     5)
vec2 <- c(1, 10, 100, 1000, 10000)
vec1 + vec2 # ベクトル同士の足し算。
```

```r
vec1 * vec2 # ベクトル同士の掛け算。（内積ではない）
```

```r
vec1 %*% vec2 # ベクトルの内積
```

#### 等間隔の数からなるベクトル

```r
1:10
```

（Pythonのrange(1, 10)の結果は1以上9以下の整数だった。）

```r
seq(from = 0, to = 1, by = 0.1)
```

```r
seq(from = 0, to = 1, length.out = 10)
```

#### 基本統計量

```r
vec1 <- c(1, 1, 2, 3, 5)

mean(vec1)   # 平均
var(vec1)    # （不偏）分散
sd(vec1)     # 標準偏差
median(vec1) # 中央値
```

```r
psych::describe(vec1) # まとめて計算する。
```

### 因子

違いを確認する。

```r
scores <- c("グー","チョキ","パー","チョキ")
scores
```

```r
scores <- factor(c("グー","チョキ","パー","チョキ"))
scores
```

### データフレーム

#### 生成（Create）

```r
# 毎回実行する
library(tidyverse)
library(caret)
```

```r
# 方法1
people <- tribble(
  ~name, ~height, ~weight,
  "A",   180,     60,
  "B",   160,     70,
  "C",   170,     80
)
people
```

```r
# 方法2
people <- data.frame(
  name = c("A", "B", "C"),
  height = c(180, 160, 170),
  weight = c(60, 70, 80))
people
```

#### 読み込み（Read）

```r
people[2,]       # 1行（結果はデータフレーム）

people[c(2, 3),] # 複数行（結果はデータフレーム）

people$name               # 1列（結果はベクトル！）

people %>% select("name") # 1列（結果はデータフレーム）

people[, c(1, 2)]                     # 複数列（その1）

people %>% select("height", "weight") # 複数列（その2）
```

##### 検索（絞り込み）

```r
people %>% filter(name == "A")

people %>% filter(height > 160 & weight > 70)   # 論理積（「かつ」）

people %>% filter(height > 160 | weight > 70)   # 論理和（「または」）

people %>% filter(height == max(people$height)) # 最大値
```

##### 並べ替え

```r
people %>% arrange(height)

people %>% arrange(-height)

people # データが更新されるわけではない。
```

**練習：体重が最も軽い人を表示する。**

#### 更新（Update）

##### 既存の行・列の更新

```r
# 行の更新
tmp <- data.frame(name = "A", height = 179, weight = 59) # 新しい行
people[1,] <- tmp                                        # 行の更新（実は追加も可）
people
```

```r
# 列の更新
tmp <- c(161, 171, 181) # 新しい列
people$height = tmp     # 列の更新（実は追加も可）
people
```

##### 新しい行・列の追加

```r
# 行の追加（新しいデータフレーム）
tmp <- data.frame(name = "D", height = 190, weight = 90) # 新しい行
people %>% rbind(tmp)                                    # 行の追加
# もとのデータフレームを更新する場合は，頭に「people <- 」を付ける。
```

```r
# 列の追加（新しいデータフレーム）
tmp <- c(70, 80, 90)           # 新しい列
people %>% mutate(socre = tmp) # 列の追加
# もとのデータフレームを更新する場合は，頭に「people <- 」を付ける。
```

#### 削除（Delete）

```r
# いずれも，新しいデータフレームができる。
people[-2,]       # 1行削除

people[-c(2, 3),] # 複数行削除

people[-(people$name == "B"), ] # 条件を満たす行の削除

people[, -1] # 1列削除

people[, -c(1, 2)]    # 複数列削除（1列しか残らない場合，結果はデータフレーム）

people[, -c(1, 2, 3)] # 複数列削除（1列しか残らない場合，結果はベクトル！）

people[, colnames(people) != "height"]                   # 列名を指定して1列削除

people[, !(colnames(people) %in% c("height", "weight"))] # 列名を指定して複数列削除
```

**練習：`select`を使って最後の結果を得る。**

#### 基本統計量

```r
mean(people$height)     # 列ごとに計算

psych::describe(people) # まとめて計算
```

グループごとの集計

```r
people <- tribble(
  ~name, ~height, ~weight, ~score, ~class,
  "A",   161,      61,      70,     "p",
  "B",   171,      71,      80,     "q",
  "C",   181,      81,      90,     "q",
  "D",   190,      90,      100,    "q"
)

people %>% group_by(class) %>% summarize(avg_height = mean(height)) # グループごとの平均

people %>% group_by(class) %>% filter(n() > 2) # 2件以上あるグループ
```

**練習：Rに入っているirisというデータのSepal.Lengthの全体の平均，Speciesごとの平均を求める。**

```r
psych::describe(iris)
```

# 可視化

### データフレームの可視化

```r
people <- tribble(
  ~name, ~height, ~weight, ~score, ~class,
  "A",   161,      61,      70,     "p",
  "B",   171,      71,      80,     "q",
  "C",   181,      81,      90,     "q",
  "D",   190,      90,      100,    "q"
)
```

#### 基本

```r
plot(people[, c(2, 3)])
```

#### 応用

```r
ggplot(data = people,                           # 対象データ
       mapping = aes(x = height, y = weight)) + # x座標とy座標の指定
  geom_point()                                  # 散布図
```

```r
ggplot(data = people,                                          # 対象データ
       mapping = aes(x = height, y = weight, color = class)) + # classで色分け
  geom_point()                                                 # 散布図
```

**練習：heightとscoreの関係を描く**

**練習：Rに入っているirisというデータのSepal.Lengthをx座標，Sepal>widthをy座標として散布図を描く。Speciesごとに色を分けること。**

### 関数（1変数）の描画

```r
f <- function(x) { 2 * x + 3 }
```

#### 基本

```r
plot(f, from = -3, to = 3)
```

#### 応用

```r
my_data <- data.frame(X = seq(from = -3, to = 3, length.out = 10))
my_data$Y <- f(my_data$X)
head(my_data)
```

```r
ggplot(data = my_data,                # 対象データ
       mapping = aes(x = X, y = Y)) + # x座標とy座標の指定
  geom_point()                        # 散布図
```

```r
ggplot(data = my_data,                # 対象データ
       mapping = aes(x = X, y = Y)) + # x座標とy座標の指定
  geom_point() +                      # 散布図
  geom_line()                         # 折れ線グラフ
```

**練習：上のグラフの「点の描画」を止める。**

**練習：y = sin(x)（-5 <= x <= 5）のグラフを描く。**
