-- 动作库
VARS = {}
-- 调试
function DEBUG(mainObj)
	Dlog(mainObj.title)
end

-- 定时器
function TIMER(mainObj)
    if (not(mainObj.data) or not(mainObj.data.time) or not(type(mainObj.data.time)=='number'))
    then
            Dlog('TIMER 参数错误')
        else
           mSleep(mainObj.data.time) 
    end
end

-- 快速点击
function TOUCH(mainObj)
    if (not(mainObj.data) or not(mainObj.data.x) or not(type(mainObj.data.x)=='number'))
    then
            Dlog('TOUCH 参数错误')
        else
            touchDown(0,mainObj.data.x,mainObj.data.y)
            mSleep(DEFAULT_HIT_TIME)
            touchMove(0,mainObj.data.x,mainObj.data.y)
            mSleep(DEFAULT_HIT_TIME)
            touchUp(0,mainObj.data.x,mainObj.data.y)
    end
end

-- 拖动
function TOUCH_MOVE(mainObj)
    if (not(mainObj.data) or not(mainObj.data.x1) or not(type(mainObj.data.x1)=='number'))
    then
            Dlog('TOUCH_MOVE 参数错误')
        else
            touchDown(0,mainObj.data.x1,mainObj.data.y1)
            mSleep(DEFAULT_HIT_TIME)
            touchMove(0,mainObj.data.x2,mainObj.data.y2)
            touchUp(0,mainObj.data.x2,mainObj.data.x2)
    end
end

-- 回退一步
function BACK(mainObj)
    os.execute("input keyevent KEYCODE_BACK")
end

-- REPEAT循环控制器
function REPEAT_CONTROLLER(mainObj)
    if (not(mainObj.data) or not(mainObj.data.until_var) or not(mainObj.data.main))
    then
            Dlog('REPEAT_CONTROLLER 参数错误')
        else
        --准备停止变量
        VARS[mainObj.data.until_var] = false;
        
        --准备main
        local sub_main = mainObj.data.main;

        repeat
        --开启循环体
        
             for i=1,#sub_main,1 do
                
                if doThing[sub_main[i].type] 
                then
                    mSleep(scriptBreathTime)
                    local fn = doThing[sub_main[i].type]
                    fn(sub_main[i])
                    else
                        Dlog('动作参数错误：动作 '..sub_main[i].title.." 不存在")
                end
                
             end
             
        --结束循环体
        until true==VARS[mainObj.data.until_var]
         
    end
end
-- WHILE循环控制器
function WHILE_CONTROLLER(mainObj)
    if (not(mainObj.data) or not(mainObj.data.until_var) or not(mainObj.data.main))
    then
            Dlog('WHILE_CONTROLLER 参数错误')
        else
        --准备停止变量
        VARS[mainObj.data.until_var] = false;
        
        --准备main
        local sub_main = mainObj.data.main;

        while false==VARS[mainObj.data.until_var] do
        --开启循环体
        
             for i=1,#sub_main,1 do
                
                if doThing[sub_main[i].type] 
                then
                    mSleep(scriptBreathTime)
                    local fn = doThing[sub_main[i].type]
                    fn(sub_main[i])
                    else
                        Dlog('动作参数错误：动作 '..sub_main[i].title.." 不存在")
                end
                
             end
             
        --结束循环体
        end
         
    end
end


-- 时间判断
function IF_TIME(mainObj)
    if (not(mainObj.data) 
        or not(mainObj.data.input_var) 
        or not(mainObj.data.year)
        or not(mainObj.data.month) 
        or not(mainObj.data.day) 
        or not(mainObj.data.hour) 
        or not(mainObj.data.min) 
        or not(mainObj.data.sec) 
        or not(type(mainObj.data.year)=='number'))
    then
            Dlog('IF_TIME 参数错误')
        else
            local setedtime = os.time({
                year=mainObj.data.year,
                month=mainObj.data.month,
                day=mainObj.data.day,
                hour=mainObj.data.hour,
                min=mainObj.data.min,
                sec=mainObj.data.sec})
            if (setedtime == os.time()) 
            then
                 VARS[mainObj.data.input_var]=true
            end
    end
end

-- 条件控制器
function IF_CONTROLLER(mainObj)
    if (not(mainObj.data) 
        or not(mainObj.data.ifnot) 
        or not(mainObj.data.input_var)
        or not(mainObj.data.main)  )
    then
            Dlog('IF_CONTROLLER 参数错误')
        else
            if (mainObj.data.ifnot==false and VARS[mainObj.data.input_var]==true)
            or (mainObj.data.ifnot==true and not(VARS[mainObj.data.input_var]==true))
            then
                --准备main
                local sub_main = mainObj.data.main;
                 for i=1,#sub_main,1 do
                    if doThing[sub_main[i].type] 
                    then
                        mSleep(scriptBreathTime)
                        local fn = doThing[sub_main[i].type]
                        fn(sub_main[i])
                        else
                            Dlog('动作参数错误：动作 '..sub_main[i].title.." 不存在")
                    end
                 end
            end
    end
end

-- 区域单点找色点击
function IF_ONECOLOR_HIT(mainObj)
    if (not(mainObj.data) 
        or not(mainObj.data.color) 
        or not(mainObj.data.x1)
        or not(mainObj.data.y1) 
        or not(mainObj.data.x2) 
        or not(mainObj.data.y2) )
    then
            Dlog('IF_ONECOLOR_HIT 参数错误')
        else
            
            local x,y = findColorInRegionFuzzy(
                mainObj.data.color,
                DEFAULT_COLOR_DEGREE,
                mainObj.data.x1,
                mainObj.data.y1,
                mainObj.data.x2,
                mainObj.data.y2)
            Dlog('点击判断结束')
            if x >-1 or y > -1 then
                Dlog(mainObj.title..': ('..x..','..y..')')
                touchDown(0,x,y)
                mSleep(DEFAULT_HIT_TIME)
                touchUp(0,x,y)
            end
           
    end
end

--区域多点找色点击
function IF_MORECOLOR_HIT(mainObj)
    if (not(mainObj.data) 
        or not(mainObj.data.color) 
        or not(mainObj.data.others) 
        or not(mainObj.data.x1)
        or not(mainObj.data.y1) 
        or not(mainObj.data.x2) 
        or not(mainObj.data.y2) )
    then
            Dlog('IF_MORECOLOR_HIT 参数错误')
        else
            local x,y = findMultiColorInRegionFuzzy( 
                mainObj.data.color, 
                mainObj.data.others, 
                DEFAULT_COLOR_DEGREE,
                mainObj.data.x1,
                mainObj.data.y1,
                mainObj.data.x2,
                mainObj.data.y2)

            if x >-1 or y > -1 then
                Dlog(mainObj.title..': ('..x..','..y..')')
                touchDown(0,x,y)
                mSleep(DEFAULT_HIT_TIME)
                touchUp(0,x,y)
            end
           
    end
end
--区域单点找色执行
function IF_ONECOLOR_DO(mainObj)
    if (not(mainObj.data) 
        or not(mainObj.data.main) 
        or not(mainObj.data.color) 
        or not(mainObj.data.x1)
        or not(mainObj.data.y1) 
        or not(mainObj.data.x2) 
        or not(mainObj.data.y2) )
    then
            Dlog('IF_ONECOLOR_DO 参数错误')
        else
            local x,y = findColorInRegionFuzzy(
                mainObj.data.color,
                DEFAULT_COLOR_DEGREE,
                mainObj.data.x1,
                mainObj.data.y1,
                mainObj.data.x2,
                mainObj.data.y2)
            if x >-1 or y > -1 then
                --准备main
                local sub_main = mainObj.data.main;
                 for i=1,#sub_main,1 do
                    if doThing[sub_main[i].type] 
                    then
                        mSleep(scriptBreathTime)
                        local fn = doThing[sub_main[i].type]
                        fn(sub_main[i])
                        else
                            Dlog('动作参数错误：动作 '..sub_main[i].title.." 不存在")
                    end
                 end

            end
           
    end
end

--区域多点找色执行
function IF_MORECOLOR_DO(mainObj)
    if (not(mainObj.data) 
        or not(mainObj.data.main) 
        or not(mainObj.data.others) 
        or not(mainObj.data.color) 
        or not(mainObj.data.x1)
        or not(mainObj.data.y1) 
        or not(mainObj.data.x2) 
        or not(mainObj.data.y2) )
    then
            Dlog('IF_MORECOLOR_DO 参数错误')
        else
            local x,y = findMultiColorInRegionFuzzy( 
                mainObj.data.color, 
                mainObj.data.others, 
                DEFAULT_COLOR_DEGREE,
                mainObj.data.x1,
                mainObj.data.y1,
                mainObj.data.x2,
                mainObj.data.y2)
            if x >-1 or y > -1 then
                --准备main
                local sub_main = mainObj.data.main;
                 for i=1,#sub_main,1 do
                    if doThing[sub_main[i].type] 
                    then
                        mSleep(scriptBreathTime)
                        local fn = doThing[sub_main[i].type]
                        fn(sub_main[i])
                        else
                            Dlog('动作参数错误：动作 '..sub_main[i].title.." 不存在")
                    end
                 end

            end
           
    end
end

-- 设置变量
function SETVAR(mainObj)
	if (not(mainObj.data) or not(mainObj.data.input_var) 
	    or not(type(mainObj.data.input_var)=='string'))
    then
            Dlog('SETVAR 参数错误')
        else
            if(  mainObj.data.ifnot == true ) then
                -- Dlog('设置为false '..mainObj.data.input_var)
                VARS[mainObj.data.input_var]=false
                else
                -- Dlog('设置为true '..mainObj.data.input_var)
                VARS[mainObj.data.input_var]=true
            end
    end
end

-- 打开APP
function RUNAPPPACKAGE(mainObj)
	if (not(mainObj.data) or not(mainObj.data.package_name) 
	    or not(type(mainObj.data.package_name)=='string'))
    then
            Dlog('RUNAPPPACKAGE 参数错误')
        else
            local r = runApp(mainObj.data.package_name)
            mSleep(1 * 1000);
            if not( r == 0) then
                Dlog('启动失败');
            end
    end
end


-- 每个多少时间就执行
function DO_EVERY(mainObj)
	if (not(mainObj.data) 
	    or not(mainObj.data.main)
	    or not(mainObj.data.timer)
	    or not(mainObj.data.name)
	    )
    then
            Dlog('DO_EVERY 参数错误')
        else
            -- 上次时间
            if not(type(VARS[mainObj.data.name]) =='number') then
                VARS[mainObj.data.name] = os.time();
            end
            local last_time = VARS[mainObj.data.name];
            local diff = os.time() - last_time;
            if (diff>mainObj.data.timer)then
                -- 达到时间了
                
                --准备main
                local sub_main = mainObj.data.main;
                 for i=1,#sub_main,1 do
                    if doThing[sub_main[i].type] 
                    then
                        mSleep(scriptBreathTime)
                        local fn = doThing[sub_main[i].type]
                        fn(sub_main[i])
                        else
                            Dlog('动作参数错误：动作 '..sub_main[i].title.." 不存在")
                    end
                 end
                 VARS[mainObj.data.name] = os.time();
                
                else
                --还没达到时间
                
            end
                
            
    end
end

-- 结束脚本
function DIE(mainObj)
    Dlog('脚本执行结束');
    luaExit();
end
 
doThing = {
	DEBUG = DEBUG,
	TIMER = TIMER,
	TOUCH = TOUCH,
	TOUCH_MOVE = TOUCH_MOVE,
	REPEAT_CONTROLLER = REPEAT_CONTROLLER,
	SETVAR = SETVAR,
	WHILE_CONTROLLER = WHILE_CONTROLLER,
	IF_CONTROLLER = IF_CONTROLLER,
	IF_TIME = IF_TIME,
	IF_ONECOLOR_HIT = IF_ONECOLOR_HIT,
	IF_MORECOLOR_HIT = IF_MORECOLOR_HIT,
	IF_ONECOLOR_DO = IF_ONECOLOR_DO,
	IF_MORECOLOR_DO = IF_MORECOLOR_DO,
	BACK = BACK,
	DO_EVERY = DO_EVERY,
	DIE = DIE,
	RUNAPPPACKAGE = RUNAPPPACKAGE
}
 
