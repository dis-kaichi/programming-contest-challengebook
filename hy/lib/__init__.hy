#!/usr/bin/env hy

(import os)
(import sys)

(setv path (.dirname (. os path) (.abspath (. os path) --file--)))
(.append (. sys path) path)


;; __pycache___対策
(setv parent (.dirname (. os path) (.abspath (. os path) (.join (. os path) --file-- ".."))))
(.append (. sys path) parent)
