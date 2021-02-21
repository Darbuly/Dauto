-- 动作库

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
            mSleep(scriptBreathTime)
            touchUp(0,mainObj.data.x2,mainObj.data.x2)
    end
end
 
doThing = {
	DEBUG = DEBUG,
	TIMER = TIMER,
	TOUCH = TOUCH,
	TOUCH_MOVE = TOUCH_MOVE
}
 
