# メモ
## 実行環境
- SBCL + SLIMV

## 注意
- libフォルダの各ファイルをSBCL起動時に読み込んでおく必要あり
  - ~/.sbclrc に記述する
  - TODO : ファイルを直に指定する処理になっていて余り良くないのでどうにかする
  - サンプル
        ;; ユーザフォルダがベースになっているので、そこからの相対パスにする
        (let* ((procon-base "workspace/github/programming-contest-challengebook/clisp")
              (myassert "lib/asserts.lisp")
              (mylib-init (merge-pathnames (format nil "~a/~a" procon-base myassert)
                                            (user-homedir-pathname))))
          (when (probe-file mylib-init)
            (load mylib-init)))

