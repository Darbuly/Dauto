local exampletime = os.time();
dialog("转换后的时间戳:"..exampletime)
nlog('cdcdcd')
dialog(os.date("%c",exampletime))
local exampletime = os.time({year=2020,month=12,day=25,hour=8,min=0,sec=0})
dialog("转换后的时间戳:"..exampletime)
dialog(os.date("%c",exampletime))