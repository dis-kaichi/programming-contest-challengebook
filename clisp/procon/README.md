# Quicklispによるライブラリ利用

- 使い方 : [参考](https://qiita.com/tamurashingo@github/items/0284c086c51e12e29240)
  1. 各ファイルをQuicklipのローカルプロジェクトディレクトリに配置する
         ql:*quicklisp-home*
         で表示されるパスのlcoal-projectsディレクトリに置く
     - 以下の様にする
            .
            ├── asserts.asd
            ├── package.lisp
            ├── procon
            │   └── lib
            │       ├── asserts.lisp
            │       ├── queue.lisp
            │       └── search.lisp
            ├── queue.asd
            └── search.asd

  2. ローカルプロジェクトを登録する
         (ql:register-local-projects)
         を実行する
