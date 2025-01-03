FROM ruby:3.2.5

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libsqlite3-dev \
  imagemagick \
  nodejs \
  yarn

# 作業ディレクトリの設定
WORKDIR /home/environment

# 必要なGemfileをコピー
COPY Gemfile ./

# Bundle install
RUN gem install bundler && bundle install

# スクリプトをコピー
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# ポートを開放
EXPOSE 3000

# デフォルトのエントリーポイント
ENTRYPOINT ["entrypoint.sh"]

# デフォルトのコマンド（デタッチ時はこのコマンドが実行される）
CMD ["rails", "server", "-b", "0.0.0.0"]
