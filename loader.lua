-- 库加载器

-- 加载第三方库
require "TSLib"
ts = require("ts")

-- 加载属性库
require("properties")

-- 加载前置函数库
require('Dlog')-- 日志
require('utils')--  无依赖工具库



-- 加载框架函数库
require('initScript')-- 初始化脚本文件
require('engine')-- 脚本运行引擎
