local function isprime(n)
	for i = 2, n - 1 do
		if n % i == 0 then
			return false
		end
	end
	return true
end
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
	local result = { isprime = true }
	for i = 2, n, 1 do
		if n % i == 0 then
			if i < n then
				result.isprime = false
			end
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
		if factors.isprime then
			state = {
				{ type = "number", value = (term.upper % 4 == 1 or term.lower % 4 == 1) and 1 or -1 },
				{ type = "legendre", upper = term.lower, lower = term.upper },
			}
			return state
		end
		for k, v in pairs(factors) do
			if type(v) == "number" then
				if v % 2 == 1 then
					state[#state + 1] = { type = "legendre", upper = k, lower = term.lower }
				end
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
		-- print(term.value)
		str = tostring(term.value)
	end
	return str
end
local function state2str(state)
	local str = ""
	local number = 1
	for k, v in ipairs(state) do
		if v.type == "legendre" then
			str = str .. term2str(v)
		end
		if v.type == "number" then
			number = number * v.value
		end
	end
	if str == "" then
		str = tostring(number)
	elseif number == -1 then
		str = "-" .. str
	end
	return str
end
local function statenext(oldstate)
	local newstate = { { type = "number", value = 1 } }
	local number = 1
	for _, v in ipairs(oldstate) do
		local tempstate = termnext(v)
		for _, y in ipairs(tempstate) do
			if y.type == "legendre" then
				newstate[#newstate + 1] = y
			elseif y.type == "number" then
				number = number * y.value
			end
		end
	end
	newstate[1]["value"] = number
	return newstate
end
local function legendre_with_calculation(p, q)
	if p % q == 0 then
		return 0
	end
	if q == 0 then
		error("the second argument of legendre should be non-zero!")
	end
	if q < 0 then
		q = -q
	end
	local state = { { type = "legendre", upper = p, lower = q } }
	local calculation = "\\[\n" .. state2str(state)
	while #state > 1 or state[1].type == "legendre" do
		state = statenext(state)
		calculation = calculation .. "\\\\\n=" .. state2str(state)
	end
	calculation = calculation .. "\n\\]"
	return calculation
end
for i = 1, 100, 1 do
	local p = math.random(1, 1000)
	local q = math.random(1001, 10000)
	while not isprime(q) do
		q = math.random(1001, 10000)
	end
	print(legendre_with_calculation(p, q))
end
