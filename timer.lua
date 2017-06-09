if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then error(e, 2) end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _temp = (function()
	return {
		['slice'] = function(xs, start, finish)
			if not finish then finish = xs.n end
			if not finish then finish = #xs end
			local len = finish - start + 1
			if len < 0 then len = 0 end
			return { tag = "list", n = len, table.unpack(xs, start, finish) }
		end,
	}
end)()
for k, v in pairs(_temp) do _libs["lua/basic-0/".. k] = v end
local _3d_1, _2f3d_1, _3c3d_1, _3e_1, _3e3d_1, _2b_1, _2d_1, _2a_1, _2f_1, _2e2e_1, len_23_1, error1, print1, getIdx1, setIdx_21_1, type_23_1, n1, format1, rep1, sub1, unpack1, list1, type1, floor1, pushCdr_21_1, append1, call1, setCursorPos1, blit1, getSize1, genLv1, setPixel1, drawCircle1, drawBuff1, genBuffer1, screenBuffer1, pullEvent1, width1, height1, draw1, update1
_3d_1 = function(v1, v2) return (v1 == v2) end
_2f3d_1 = function(v1, v2) return (v1 ~= v2) end
_3c3d_1 = function(v1, v2) return (v1 <= v2) end
_3e_1 = function(v1, v2) return (v1 > v2) end
_3e3d_1 = function(v1, v2) return (v1 >= v2) end
_2b_1 = function(v1, v2, ...) local t = (v1 + v2) for i = 1, _select('#', ...) do t = (t + _select(i, ...)) end return t end
_2d_1 = function(v1, v2, ...) local t = (v1 - v2) for i = 1, _select('#', ...) do t = (t - _select(i, ...)) end return t end
_2a_1 = function(v1, v2, ...) local t = (v1 * v2) for i = 1, _select('#', ...) do t = (t * _select(i, ...)) end return t end
_2f_1 = function(v1, v2, ...) local t = (v1 / v2) for i = 1, _select('#', ...) do t = (t / _select(i, ...)) end return t end
_2e2e_1 = function(v1, v2, ...) local t = (v1 .. v2) for i = _select('#', ...), 1, -1 do t = (_select(i, ...) .. t) end return t end
len_23_1 = function(v1) return #(v1) end
error1 = error
print1 = print
getIdx1 = function(v1, v2) return v1[v2] end
setIdx_21_1 = function(v1, v2, v3) v1[v2] = v3 end
type_23_1 = type
n1 = (function(x)
	if (type_23_1(x) == "table") then
		return x["n"]
	else
		return #(x)
	end
end)
format1 = string.format
rep1 = string.rep
sub1 = string.sub
unpack1 = table.unpack
list1 = (function(...)
	local xs = _pack(...) xs.tag = "list"
	return xs
end)
type1 = (function(val)
	local ty = type_23_1(val)
	if (ty == "table") then
		return (val["tag"] or "table")
	else
		return ty
	end
end)
floor1 = math.floor
pushCdr_21_1 = (function(xs, val)
	local temp = type1(xs)
	if (temp ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", temp), 2)
	end
	local len = (n1(xs) + 1)
	xs["n"] = len
	xs[len] = val
	return xs
end)
append1 = (function(xs, ys)
	local _offset, _result, _temp = 0, {tag="list",n=0}
	_temp = xs
	for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_temp = ys
	for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_result.n = _offset + 0
	return _result
end)
call1 = (function(x, key, ...)
	local args = _pack(...) args.tag = "list"
	return x[key](unpack1(args, 1, n1(args)))
end)
setCursorPos1 = term.setCursorPos
blit1 = term.blit
getSize1 = term.getSize
genLv1 = (function(val, size)
	local out = ({tag = "list", n = 0})
	if (type1(val) == "list") then
		local temp = nil
		local temp1 = 1
		while (temp1 <= size) do
			pushCdr_21_1(out, append1(({tag = "list", n = 0}), val))
			temp1 = (temp1 + 1)
		end
	else
		local temp = nil
		local temp1 = 1
		while (temp1 <= size) do
			pushCdr_21_1(out, val)
			temp1 = (temp1 + 1)
		end
	end
	return out
end)
setPixel1 = (function(buff, x, y, d, b, f)
	x = floor1(x)
	y = floor1(y)
	if ((x > 0) and ((x <= buff["width"]) and ((y > 0) and (y <= buff["height"])))) then
		if not (type_23_1(d) == "nil") then
			buff["cur-rep"][y][1] = (function(temp)
				return (sub1(temp, 1, (x - 1)) .. (d .. sub1(temp, (x + 1))))
			end)(buff["cur-rep"][y][1])
		end
		if not (type_23_1(b) == "nil") then
			buff["cur-rep"][y][2] = (function(temp)
				return (sub1(temp, 1, (x - 1)) .. (b .. sub1(temp, (x + 1))))
			end)(buff["cur-rep"][y][2])
		end
		if not (type_23_1(f) == "nil") then
			buff["cur-rep"][y][3] = (function(temp)
				return (sub1(temp, 1, (x - 1)) .. (f .. sub1(temp, (x + 1))))
			end)(buff["cur-rep"][y][3])
		end
		buff["old-rep"][y] = true
		return nil
	else
		return nil
	end
end)
drawCircle1 = (function(x0, y0, radius, b, d, c)
	local x = radius
	local y = 0
	local err = 0
	local temp = nil
	while (x >= y) do
		setPixel1(screenBuffer1, (x0 + x), (y0 + y), d, b, c)
		setPixel1(screenBuffer1, (x0 + y), (y0 + x), d, b, c)
		setPixel1(screenBuffer1, (x0 - y), (y0 + x), d, b, c)
		setPixel1(screenBuffer1, (x0 - x), (y0 + y), d, b, c)
		setPixel1(screenBuffer1, (x0 - x), (y0 - y), d, b, c)
		setPixel1(screenBuffer1, (x0 - y), (y0 - x), d, b, c)
		setPixel1(screenBuffer1, (x0 + y), (y0 - x), d, b, c)
		setPixel1(screenBuffer1, (x0 + x), (y0 - y), d, b, c)
		y = (y + 1)
		if (err <= 0) then
			err = ((err + (y * 2)) + 1)
		elseif (err > 0) then
			x = (x - 1)
			err = ((err - (y * 2)) - 1)
		else
			_error("unmatched item")
		end
	end
	return nil
end)
drawBuff1 = (function(buff)
	local temp = buff["height"]
	local temp1 = nil
	local temp2 = 1
	while (temp2 <= temp) do
		local crep = buff["cur-rep"][temp2]
		if buff["old-rep"][temp2] then
			setCursorPos1(1, temp2)
			local xs = list1(crep[1], crep[3], crep[2])
			blit1(unpack1(xs, 1, n1(xs)))
			buff["old-rep"][temp2] = false
		end
		temp2 = (temp2 + 1)
	end
	return nil
end)
genBuffer1 = (function(w, h)
	local temp = type1(w)
	if (temp ~= "number") then
		error1(format1("bad argument %s (expected %s, got %s)", "w", "number", temp), 2)
	end
	local temp = type1(h)
	if (temp ~= "number") then
		error1(format1("bad argument %s (expected %s, got %s)", "h", "number", temp), 2)
	end
	local newBuff = ({})
	newBuff["old-rep"] = genLv1(true, h)
	newBuff["cur-rep"] = genLv1(genLv1(rep1("0", w), 3), h)
	newBuff["width"] = w
	newBuff["height"] = h
	return newBuff
end)
screenBuffer1 = genBuffer1(getSize1())
print1("Buffer loaded!")
pullEvent1 = os.pullEvent
width1 = getSize1()
height1 = list1(getSize1())[2]
draw1 = (function()
	drawCircle1((width1 / 2), ((height1 / 2) + 1), 8, "7", " ", "0")
	return drawBuff1(screenBuffer1)
end)
update1 = (function()
	return pullEvent1()
end)
local states = ({["timer"]=(function()
	return ({["update"]=update1,["draw"]=draw1})
end)()})
local stateIdx = states["timer"]
local temp = nil
while true do
	call1(stateIdx, "update")
	call1(stateIdx, "draw")
end
