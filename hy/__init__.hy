#!/usr/bin/env hy

(import os)
(import sys)

(def path (.join (. os path) (.abspath (. os path) --file--) "lib"))
(.append (. sys path) path)
