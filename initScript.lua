
-- 根据JSON脚本文件读取文件并解析
function readJson(jsonPath)
local tab = readFile(userPath().."/res/"..jsonPath) 
local res = ""
    if tab then 
      for i=1,#tab,1 do
        res = res..tab[i]
      end
    else
      Dlog("JSON脚本文件 "..jsonPath.." 不存在")
      luaExit()
    end
local json = ts.json--使用 JSON 模块前必须插入这一句
--把 json 字符串转换成 table
return json.decode(res)
end

-- 验证脚本文件
function checkScriptValid(script_json)
    -- check scripName
    local script_scripName = script_json.scripName
    if( script_scripName == nil or #script_scripName == 0  )
    then
        Dlog("脚本名称无效")
        return false
    else
        return true
    end
    
    -- check plan
    local script_main = script_json.main
    if( not(isArrayT(script_main)) or #script_main == 0  )
    then
        Dlog("脚本计划无效  "..script_json.scripName)
        return false
    else
        return true
    end
end

-- 初始化脚本数据
function initScriptData(script_json)
    scripName = script_json.scripName
    scriptMain = script_json.main
    
    if(not(script_json.breathTime == nil) and type(script_json.breathTime) == 'number')
    then
        scriptBreathTime = script_json.breathTime
    else
        scriptBreathTime = DEFAULT_BREATH_TIME
    end
    
    if(not(script_json.initScreen == nil) and type(script_json.initScreen) == 'number')
    then
        init(script_json.initScreen)
    else
        init(DEFAULT_INITSCREEN)
    end
end
