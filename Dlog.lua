-- 日志文件封装
function Dlog(msg)
    local exampletime = os.time();
    local _msg = msg;
    if(not(type(msg)=='string'))
    then
        local json = ts.json--使用 JSON 模块前必须插入这一句
        _msg = json.encode(msg)
    end
    nLog("["..os.date("%c",exampletime).."]:".._msg)    
end

