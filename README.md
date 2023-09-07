モデル名：Task string :title, string :content, (外部キーは後からつける)

herokuへのデプロイ手順
1.heroku loginを行う
2.heroku createを行う
3.以下のgemを追加する gem 'net-smtp',  gem 'net-imap', gem 'net-pop'
4.git add .とgit commit -mを行う
5.以下3つのHeroku buildpackを追加する
 heroku buildpacks:set heroku/ruby heroku buildpacks:add --index 1 heroku/nodejs heroku addons:create heroku-postgresql
6.git push heroku step2:masterでデプロイする
8.heroku run rails db:migrateでデータベースを移行する