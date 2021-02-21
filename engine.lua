-- 脚本运行引擎
require("DautoPlanLib")
function run()
     for i=1,#scriptMain,1 do
        
        if doThing[scriptMain[i].type] 
        then
            mSleep(scriptBreathTime)
            local fn = doThing[scriptMain[i].type]
            fn(scriptMain[i])
            else
                Dlog('动作参数错误：动作 '..scriptMain[i].title.." 不存在")
        end
        
     end
    Dlog('执行结束')
    luaExit()
end






