#!/bin/bash

set -e

# 初回セットアップ
if [ ! -f /home/environment/bin/rails ]; then
  mv Gemfile Gemfile.custom || true
  rails new . --skip-bundle --database=sqlite3
  bundle install
fi

# デタッチ時のみサーバー起動
if [[ "$1" == "rails" && "$2" == "server" ]]; then
  exec "$@"
else
  exec bash
fi
