local function legendre(p, q)
	if p % q == 0 then
		return 0
	end
	if q == 0 then
		error("the second argument of legendre should be non-zero!")
	end
	if q < 0 then
		q = -q
	end
	for i = 1, q - 1, 1 do
		if (i * i - p) % q == 0 then
			return 1
		end
	end
	return -1
end
local function defactor(n)
	local result = {}
	for i = 2, n, 1 do
		if n % i == 0 then
			result[i] = 0
			while n % i == 0 do
				result[i] = result[i] + 1
				n = n / i
			end
		end
	end
	return result
end
local function termnext(term)
	local state = {}
	if term.type == "legendre" then
		if term.upper > term.lower then
			state = { { type = "legendre", upper = term.upper % term.lower, lower = term.lower } }
			return state
		end
		if term.upper == 1 then
			return { { type = "number", value = 1 } }
		end
		if term.upper == 2 then
			return { { type = "number", value = (term.lower * term.lower - 1) % 16 == 0 and 1 or -1 } }
		end
		local factors = defactor(term.upper)
		if #factors == 1 then
			state = {
				{ type = "number", value = (term.upper % 4 == 1 or term.lower % 4 == 1) and 1 or -1 },
				{ type = "legendre", upper = term.lower, lower = term.upper },
			}
			return state
		end
		for k, v in pairs(factors) do
			print(k .. "," .. v)
			if v % 2 == 1 then
				state[#state + 1] = { type = legendre, upper = k, lower = term.lower }
			end
		end
		return state
	end
	if term.type == "number" then
		return { term }
	end
end
local function term2str(term)
	local str = ""
	if term.type == "legendre" then
		str = [[\legendre{]] .. term.upper .. [[}{]] .. term.lower .. [[}]]
	end
	if term.type == "number" then
		print(term.value)
		str = tostring(term.value)
	end
	return str
end
local function state2str(state)
	local str = ""
	for k, v in ipairs(state) do
		str = str .. term2str(v)
	end
	return str
end
print(state2str(termnext({ type = "legendre", upper = 6, lower = 13 })))
