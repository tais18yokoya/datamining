# 02 R入門

## よく使うパッケージ

### インストール

```r
# 一度だけ実行する。（RStudioの警告に付随する「Install」を使ってもよい。）
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
# この資料では，見やすさのために「->」，「+」，「=」などの前後，「,」の後に空白を入れる。
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
paste(s, t, sep = ',') # 文字列の連結
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
# この資料では，見やすさのために余分な空白を入れて水平方向の位置を揃えることがある。
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
# Pythonのrange(1, 10)の結果は1以上9以下の整数だった。
```

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

## データフレーム

```r
# 毎回実行する
library(tidyverse)
library(caret)
```

### 生成（Create）

```r
# 方法1
people <- tribble(
  ~name, ~height, ~weight, ~score, ~class,
  "A",       160,      60,     70, "p",
  "B",       170,      90,     80, "q",
  "C",       180,      70,     90, "p",
  "D",       190,      90,    100, "q",
  "E",       200,     100,     60, "p")
people
```

```r
# 方法2
people <- data.frame(
  name   = c("A", "B", "C", "D", "E"),
  height = c(160, 170, 180, 190, 200),
  weight = c( 60,  90,  70,  90, 100),
  score  = c( 70,  80,  90, 100,  60),
  class  = c("p", "q", "p", "q", "p"),
  stringsAsFactors = FALSE # 文字列を因子にしないためのオプション
)
people
```

#### 新しい行・列の追加

```r
# 行の追加
tmp <- data.frame(name = "F", height = 172, weight = 60,
                  score = "50", class = "p",
                  stringsAsFactors = FALSE) # 新しい行
people %>% rbind(tmp)                       # 行の追加

# 列の追加
tmp <- c("P", "Q", "R", "S", "T") # 新しい列
people %>% mutate(name2 = tmp)    # 列の追加
# もとのデータフレームを更新する場合は，頭に「people <- 」を付ける。
```

### 読み込み（Read）

```r
head(people) # 最初の数件

people[2, 3] # 2行3列

people[2, ]       # 1行
people[c(2, 3), ] # 複数行

people$name       # 1列（結果はベクトル）
people[, 2]       # 1列（結果はベクトル）
people[, c(2, 3)] # 複数列

people %>% select("name")             # 1列
people %>% select("height", "weight") # 複数列
```

#### 検索（絞り込み）

```r
people %>% filter(name == "A")

people %>% filter(height > 160 & weight > 70)   # 論理積（「かつ」）

people %>% filter(height > 160 | weight > 70)   # 論理和（「または」）

people %>% filter(height == max(people$height)) # 最大値
```

#### 並べ替え

```r
people %>% arrange(score)

people %>% arrange(-score)

people # データが更新されるわけではない。
```

**練習：体重が最も軽い人を表示する。**

### 更新（Update）

```r
# 行の更新
tmp <- data.frame(name = "A", height = 161, weight = 61,
                  score = 70, class = "p",
                  stringsAsFactors = FALSE) # 新しい行
people[1,] <- tmp                           # 行の更新（この記法で追加も可）
people
```

```r
# 列の更新
tmp <- c(161, 171, 181, 191,201) # 新しい列
people$height = tmp              # 列の更新（実は追加も可）
people
```

### 削除（Delete）

```r
# いずれも，新しいデータフレームができる。
people[-2,]       # 1行削除
people[-c(2, 3),] # 複数行削除

people[-(people$name == "B"), ] # 条件を満たす行の削除

people[, -1]          # 1列削除
people[, -c(1, 2)]    # 複数列削除（1列しか残らない場合，結果はベクトル）

people[, colnames(people) != "height"]                   # 列名を指定して1列削除
people[, !(colnames(people) %in% c("height", "weight"))] # 列名を指定して複数列削除
```

**練習：`select`を使って`people[, colnames(people) != "height"]`と同じ結果を得る。**

### 基本統計量

```r
mean(people$height)     # 列ごとに計算

psych::describe(people) # まとめて計算
```

**練習：heightの標準偏差を求める。**

#### グループごとの集計

```r
people <- tribble(
  ~name, ~height, ~weight, ~score, ~class,
  "A",       160,      60,     70, "p",
  "B",       170,      90,     80, "q",
  "C",       180,      70,     90, "p",
  "D",       190,      90,    100, "q",
  "E",       200,     100,     60, "p")

people %>% group_by(class) %>% summarize(avg_height = mean(height)) # グループごとの平均

people %>% group_by(class) %>% filter(n() > 2) # 2件以上あるグループ
```

**練習：Rに入っているirisというデータのSepal.Lengthの全体の平均，Speciesごとの平均を求める。ヒント：最初にデータを`View(iris）`で確認する。**

## 可視化

```r
# 毎回実行する
library(tidyverse)
library(caret)
```

### 1次元データの可視化

```r
tmp <- c(7, 5, 4, 0, 6, 1, 3, 9, 0, 5, 5, 0, 6, 9, 5, 3, 7, 10, 8, 7)

plot(tmp, type = "l") # 折れ線（時系列）

hist(tmp)             # ヒストグラム
```

### データフレームの可視化

```r
people <- tribble(
  ~name, ~height, ~weight, ~score, ~class,
  "A",       160,      60,     70, "p",
  "B",       170,      90,     80, "q",
  "C",       180,      70,     90, "p",
  "D",       190,      90,    100, "q",
  "E",       200,     100,     60, "p")
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

**練習：Rに入っているirisというデータのSepal.Lengthをx座標，Sepal.widthをy座標として散布図を描く。Speciesごとに色を分けること。**

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
