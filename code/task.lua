--[[
  TimerMode specifies the kind of timer to use.
  DELAYED will execute the task after a certain amount of frames has passed, while
  REPEATED executes the task repeatedly at the specified rate.
]]--
TimerMode = { 
  DELAYED   = 0,
  REPEATING = 1,
}

Timer = {}
local tasks = {}

--[[
  Creates and registers a new task which runs the provided function.
]]--
function Timer.Task(mode, frames, func)
  o = {}
  o.mode = mode
  o.frames = frames
  o.func = func
  table.insert(tasks, o)
end

local frameCounter = 0
function tick()
  frameCounter = frameCounter + 1
  removeQueue = {}
  for i,task in pairs(tasks) do
    if (task.mode == TimerMode.DELAYED and frameCounter >= task.frames) 
    or (task.mode == TimerMode.REPEATING and frameCounter % task.frames == 0) then
      task["func"](frameCounter)
      if task.mode == TimerMode.DELAYED then
        table.insert(removeQueue, task)
      end
    end
  end
  for i,taskToRemove in pairs(removeQueue) do
    table.remove(tasks, taskToRemove)
  end
end

Cringebirth:AddCallback(ModCallbacks.MC_POST_RENDER, tick)
-- I hate this language