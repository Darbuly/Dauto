-- 日志文件封装
function Dlog(msg)
local exampletime = os.time();
    nLog("["..os.date("%c",exampletime).."]:"..msg)    
end

