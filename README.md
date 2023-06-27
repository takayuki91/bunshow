# BunShow！

## BunShow!の由来
- bun「優れた（ルーマニア語）」
- show「見せる、ショー（英語）」
- 洗練されたBunShow（"文章"、とりわけ教員の方は"板書"）が共有されるサービスであってほしい


# サイト概要

## サイトテーマ
##### 指導法✖️コミュニティサイト
- 多種多様な指導者（教員やコーチ）が集まるコミュニティサイト
- コミュニティ選択によって、よりニーズにマッチした投稿が閲覧可能
- 同じコミュニティ仲間からのフィードバックが受けられる
- 指導技術共有、相互称賛、モチベーションアップが目的
##### "手軽"な実践共有サービス
- 投稿は100文字以内
- 科学的に10秒程度で読むことができる分量
- 「通勤電車で」「指導法研究の息抜きに」手軽な利用シーンを想定
- シンプルでわかりやすい付加機能

## テーマ設定の理由
　指導者が手軽に指導方法を共有できるサービスを提供し、さらなる指導力アップと働き方改革の一助となることを目指します。なぜなら、手軽であることは多忙な指導者にとってニーズが高く、[教員勤務実態調査](https://www.mext.go.jp/b_menu/houdou/mext_01232.html)（文部科学省 HP）のデータ等ともマッチしていると考えたからです。<br>　例えば、私自身、移動中や通勤電車の中で「明日の指導に活かせる何かいいアイデアは？」「もうひと工夫ないか？」と感じたことがあります。しかし、1からじっくりと研究する時間を確保しにくいことが多いです。そんな時、おもむろに開いたスマートフォンから先人の知恵を借りることができたなら、後は自分の色を付けて指導に活かすのみです。つまり、手軽なサービスであることが本サービスの目指すところです。<br>　さらに、付加価値として、手軽であることは指導法を公開する側のハードルも下げます。共有を活性化させ、コミュニティ内で相互にモチベーションを高め合うことができるようにすることで、間接的に指導力アップにも寄与するものと考えました。

## ターゲットユーザー
- 教員（約100万人） 参考:[文部科学省 HP](https://www.mext.go.jp/b_menu/shingi/chukyo/chukyo0/toushin/attach/1337051.htm)
- ビジネスコーチ
- スポーツコーチ（約60万人） 参考:[JSPO HP](https://www.japan-sports.or.jp/coach/tabid248.html)
- 全ての指導者と言われる職業の方々

## 主な利用シーン
##### 帰宅中の電車で手軽に
- 指導方法の情報収集
- 人気投稿（指導方法）のチェック
##### 指導法研究の合間に
- 指導方法の共有
- 相互フィードバック（称賛や質問）


# 設計書

## 開発環境
- OS：Linux
- フレームワーク：Ruby on Rails(6.1.7)
- 言語：HTML,CSS,Ruby(3.1.2),JavaScript,SQL
- JSライブラリ：jQuery,Lightbox2
- IDE：cloud9

## Gem
- devise
- kaminari
- bootstrap4-kaminari-views
- ancestry
- dotenv-rails

## 使用素材
- [ヒューマンピクトグラム2.0](https://pictogram2.com/)
- [Google Fonts](https://fonts.google.com/?subset=japanese&noto.script=Jpan)
- [FontAwesome](https://fontawesome.com/)
- [Webサイトの利用規約 kiyaku.jp](https://kiyaku.jp/index.html)
- [イラストや](https://www.irasutoya.com/)

## ER図
![2 2_ER図](https://github.com/takayuki91/bunshow/assets/129576342/7d6b234f-e6ad-40a3-8e56-fd68ebd8ca42)

## テスト仕様書
下記リンクのテスト仕様書に沿って、機能の確認とエラーがないことの確認をいたしました。（2023/06/27時点）
https://docs.google.com/spreadsheets/d/18qLnSFrZaviJKZ0AAL_8JSCug-5OvtfZcXfF74j4xLU/edit?usp=sharing


# 実装機能



## 用語の定義
- 【BunShow】本サイト名、および本サイトにおける投稿。「ぶんしょう」と読むが、教員の方には是非「ばんしょ（板書）」という愛称で読んでいただきたい。
- 【指導者】本サイトに登録しているユーザー
- 【ニックネーム】ユーザーの本サイトでの名前
- 【BunShowログ】ユーザーのマイページ
- 【コミュニティ】投稿一覧を絞り込むためのカテゴリー
- 【ラボ】ユーザーが自由に作成し、交流するためのグループ
- 【いいね】ユーザーが投稿に対して付けることができる簡易的な称賛
- 【ブックマーク】ユーザーが投稿に対して付けることで、マイページにストックされるもの
- 【閲覧数】投稿の詳細画面を閲覧することで自動カウントされる記録
- 【フィードバック】ユーザーが投稿に対して行うコメント
- 【管理者】本サイトの管理者
- 【ステータス】管理画面で、ユーザーが有効状態か論理削除状態かを表すもの

## 主な機能

### エンドユーザー

##### ユーザー関連
1. 新規会員登録、ログイン、ログアウト、退会（論理削除）
1. ユーザー情報（アイコン、名前、アドレス）の編集
1. 自分の情報のマイページ（ユーザー関連、投稿関連）
1. ユーザーのフォロー、アンフォロー
1. フォロー、フォロワーの一覧

##### 投稿関連
1. 新規投稿（「画像」「説明文（100文字まで）」）
1. 投稿の編集、削除
1. 投稿の一覧表示、詳細表示による閲覧
1. 投稿画像のポップアップ表示
1. 投稿へのコメント（100文字まで）
1. 投稿への「いいね」「ブックマーク」
1. 投稿詳細閲覧の有無の可視化
1. 「いいね」「ブックマーク」「閲覧」「コメント」のカウント機能
1. 「いいね」「閲覧」の数が多い投稿のランキング表示
1. 「ブックマーク」した投稿のストック表示
1. 外部SNSへの共有（自分の投稿のみ）

##### コミュニティ関連
1. 任意のコミュニティへの所属、変更、所属解除
1. コミュニティ所属に伴う投稿一覧に表示される投稿の絞り込み
1. コミュニティの階層構造による選択の柔軟性
1. グループ作成、削除
1. グループへの参加、退会
1. 参加グループの投稿一覧、ユーザー一覧
1. 自分の参加グループの一覧

##### その他
1. 気になる「投稿」「ユーザー」「グループ」のキーワード検索
1. 投稿文字数制限があるフォームでの文字カウント
1. 一定数データごとのページ無限スクロール
1. ページトップリンク
1. フラッシュメッセージやエラーメッセージの可視化
1. トップページで本日の投稿数の可視化

### 管理者

1. 管理者ログイン、ログアウト
1. ユーザー情報の一覧表示
1. ユーザー情報編集（画像、名前、アドレス）
1. ユーザーの利用停止（論理削除）、エンドユーザー側での非表示
1. ユーザーの全データ一括削除（物理削除）
1. ユーザーの投稿詳細確認、削除
1. ユーザーのコメント削除
1. グループの詳細確認
1. ユーザーがオーナーであるグループの削除
1. ユーザーが所属するグループの削除
1. ユーザー、投稿、コメントの検索機能（全文一致、前方一致、後方一致、部分一致に対応）


# 製作者
Takayuki Nakatsuji