#!/usr/bin/env hy

(import os)
(import sys)

(def path (.dirname (. os path) (.abspath (. os path) --file--)))
(.append (. sys path) path)
