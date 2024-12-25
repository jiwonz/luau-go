# English

## threadpool
Executes the given function in a separate thread, threads are pooled and reused.

### Features
- Very small and simple module, useful for optimizing `task.spawn` by reusing threads.
- Original: [util.luau/threadpool](https://github.com/lukadev-0/util.luau/blob/main/packages/threadpool/init.luau)
- Removed `pure luau`, `lune` support from the original. It has been simplified by not needing a separate module (std.task).
- Supports executing functions in separate threads and reusing threads

### Installation
#### From pesde
```sh
pesde add caveful_games/threadpool
```

# Example Usage
```luau
threadpool(function()
	...
end)
```
