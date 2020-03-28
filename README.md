# LogLog

![LogLogロゴ](https://github.com/wawawatataru/loglog/blob/master/app/assets/images/android-chrome-256x256.png?raw=true,"LogLogロゴ")

[![CircleCI](https://circleci.com/gh/wawawatataru/loglog.svg?style=svg)](https://circleci.com/gh/wawawatataru/loglog)

実際のサービスは[こちら](https://loglogme.herokuapp.com/)から確認できます。

## LogLogとは
日常のちょっとしたできごとや日々の移り変わりを記録できるWebサービスです。

### 特徴
LogLogでは**グラフの種類や色を選択するだけですぐに**ログが作れ、

日にちと値を入力するだけで記録として残すことができます。

![LogLog_log_edit](https://github.com/wawawatataru/portfolio/blob/master/docs/img/portfolio/loglog/log_edit.png?raw=true,"LogLog_log_edit")

![LogLog_log_show](https://github.com/wawawatataru/portfolio/blob/master/docs/img/portfolio/loglog/log_show.png?raw=true,"LogLog_log_show")

気になったユーザーやログをフォローすることで**最新情報を知る**ことができます。

![LogLog_feeds](https://github.com/wawawatataru/portfolio/blob/master/docs/img/portfolio/loglog/feeds.png?raw=true,"LogLog_feeds")

ログを検索することもで、**共通の趣向を持った人を探す**ことができます。

![LogLog_search](https://github.com/wawawatataru/portfolio/blob/master/docs/img/portfolio/loglog/search.png?raw=true,"LogLog_search")


## Lint&Test

下記の lint とテストが実装されます。

```
$ ./bin/lintest
```

## Lint

rubocop と slim-lint が実行されます。

```
$ ./bin/lint
```

## Test

RSpec のテストが実行されます。

```
$ ./bin/test
```
