#!/usr/bin/env hy

(import os)
(import sys)

(def path (.dirname (. os path) (.abspath (. os path) --file--)))
(.append (. sys path) path)


;; __pycache___対策
(def parent (.dirname (. os path) (.abspath (. os path) (.join (. os path) --file-- ".."))))
(.append (. sys path) parent)
