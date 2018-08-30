local pointfree_array = {}
pointfree_array._VERSION = 0.1

--[=====[
  A collection of functional style (haskell in particular) high order functions operate on table array
--]=====]


function pointfree_array.map(arr, f)
  local newarr = pointfree_array.Pointfree({})
  for i, v in ipairs(arr) do
    table.insert(newarr, f(v))
  end
  return newarr
end


function pointfree_array.apply(arr, f)
  for i, v in ipairs(arr) do
    f(v)
  end
end


function pointfree_array.flatten(arr)
  local newarr = pointfree_array.Pointfree({})
  for _, v in ipairs(arr) do
    for _, inner_v in ipairs(v) do
      table.insert(newarr, inner_v)
    end
  end
  return newarr
end


function pointfree_array.filter(arr, f)
  local newarr = pointfree_array.Pointfree({})
  for _, v in ipairs(arr) do
    if p(v) then
      table.insert(newarr, v)
    end
  end
  return newarr
end


function pointfree_array.shuffle(arr)
  local size = #arr
  for i = size, 1, -1 do
    local rand = math.random(size)
    arr[i], arr[rand] = arr[rand], arr[i]
  end
  return pointfree_array.Pointfree(arr)
end


function pointfree_array.tail(arr)
  local newarr = pointfree_array.Pointfree({})
  for k, v in ipairs(arr) do
    if k ~= 1 then
      table.insert(newarr, v)
    end
  end
  return newarr
end

function pointfree_array.init(arr)
  local newarr = pointfree_array.Pointfree({})
  local arr_len = #arr
  for k, v in ipairs(arr) do
    if k ~= arr_len then
      table.insert(newarr, v)
    end
  end
  return newarr
end


function pointfree_array.take(arr, num)
  local count = 0
  local newarr = pointfree_array.Pointfree({})
  for _, v in ipairs(arr) do
    table.insert(newarr, v)
    count = count + 1
    if (count == num) then
      break
    end
  end
  return newarr
end


function pointfree_array.takeWhile(arr, p)
  -- Takes longest prefix of elements of 'list' that satisfy 'predicate'.
  local newarr = pointfree_array.Pointfree({})
  for _, v in ipairs(arr) do
    if p(v)  then
      table.insert(newarr, v)
    else
      return newarr
    end
  end
  return newarr
end


function pointfree_array.drop(arr, num)
  local count = 0
  local newarr = pointfree_array.Pointfree({})
  for _, v in ipairs(arr) do
    count = count + 1
    if (count > num) then
      table.insert(newarr, v)
    end
  end
  return newarr
end


function pointfree_array.dropWhile(arr, p)
  local newarr = pointfree_array.Pointfree({})
  local b_finish = false
  for _, v in ipairs(arr) do
    if not b_finish then
      if not p(v) then
        b_finish = true
      end
    end
    if b_finish then
      table.insert(newarr, v)
    end
  end
  return newarr
end


-- for array of bool values
local function _and(arr)
  for _, v in ipairs(arr) do
    if not v then
      return false
    end
  end
  return true
end

local function _or(arr)
  for _, v in ipairs(arr) do
    if v then
      return true
    end
  end
  return false
end


function pointfree_array.reverse(arr)
  local newarr = pointfree_array.Pointfree({})
  local length = table.maxn(arr)
  for i = length, 1, -1 do
    table.insert(newarr, arr[i])
  end
  return newarr
end


-- hereafter, not return pointfree style array
function pointfree_array.elem(arr, val)
  for _, value in ipairs(arr) do
    if value == val then
      return true
    end
  end
  return false
end


function pointfree_array.any(arr, p)
  return _or (pointfree_array.map(arr, p))
end


function pointfree_array.all(arr, p)
  return _and(pointfree_array.map(arr, p))
end


function pointfree_array.un_pointfree(arr)
  setmetatable(arr, nil)
  return arr
end

local Pointfree  = {
  -- return functional table
  map = pointfree_array.map,
  filter = pointfree_array.filter,
  flatten = pointfree_array.flatten,
  shuffle = pointfree_array.shuffle,
  tail = pointfree_array.tail,
  init = pointfree_array.init,
  take = pointfree_array.take,
  drop = pointfree_array.drop,
  takeWhile = pointfree_array.takeWhile,
  dropWhile = pointfree_array.dropWhile,
  reverse = pointfree_array.reverse,
  -- return other types or non-pointfree style of array.
  -- if use pointfree style composition, those should be at the last
  elem = pointfree_array.elem,
  any = pointfree_array.any,
  all = pointfree_array.all,
  apply = pointfree_array.apply,
  un_pointfree = pointfree_array.un_pointfree
}


function pointfree_array.Pointfree(arr)
  setmetatable(arr, {__index = Pointfree})
  return arr
end

----
return pointfree_array
