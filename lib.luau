-- source credit to https://github.com/lukadev-0/util.luau/blob/main/packages/threadpool/init.luau

local freeThreads: { thread } = {}

local function run<A...>(f: (A...) -> (), thread: thread, ...)
	f(...)
	table.insert(freeThreads, thread)
end

local function yielder()
	while true do
		run(coroutine.yield())
	end
end

--[=[
	Executes the given function in a separate thread, threads are pooled and reused.

	별도의 스레드에서 지정된 함수를 실행하며 스레드는 풀링되어 재사용됩니다.

	```lua
	local t: thread = threadpool(function()
		task.wait(2)
		print("Hello Caveful Games!")
	end)
	```
]=]
return function(f: (A...) -> (), ...: A...): thread
	local thread
	if #freeThreads > 0 then
		thread = freeThreads[#freeThreads]
		freeThreads[#freeThreads] = nil
	else
		thread = coroutine.create(yielder)
		coroutine.resume(thread)
	end

	return task.spawn(thread, f, thread, ...)
end
