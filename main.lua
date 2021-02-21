
-- 运行加载器
require("loader")

Dlog("Daotu start version v"..DAOTU_VERSION)

script_json = readJson('myscript2.json')

if(checkScriptValid(script_json))
then
    Dlog("准备启动脚本  "..script_json.scripName)
    
    initScriptData(script_json)
    Dlog("呼吸时间  "..scriptBreathTime)
    run()
    else
        luaExit()
end



