-- 自定义函数工具类

-- 判断是否为数组
function isArrayT(t)
    if type(t) ~= "table" then
        return false
    end
 
    local n = #t
    for i,v in pairs(t) do
        if type(i) ~= "number" then
            return false
        end
        
        if i > n then
            return false
        end 
    end
 
    return true 
end