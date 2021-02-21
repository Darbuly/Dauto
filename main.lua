local ts = require("ts")--使用扩展库前必须插入这一句
local json = ts.json--使用 JSON 模块前必须插入这一句
local str = [[{"meme":[1,0,0,4,6,9,5,1,0,0],"我":"五毛","爱":"六块"}]]
--把 json 字符串转换成 table
local tmp = json.decode(str)
nLog(tmp.meme[5]);
luaExit();        --否则退出脚本

-- 运行加载器
require("loader")

Dlog("Daotu start version v"..DAOTU_VERSION)



