-- Palette conformance: no raw hex outside lua/lain/ramp.lua, every token bound to a ramp step.
local fail = 0

local function repo_root()
  local src = debug.getinfo(1, "S").source
  src = src:gsub("^@", "")
  return vim.fn.fnamemodify(vim.fn.fnamemodify(src, ":p:h"), ":h")
end

local root = repo_root()
vim.cmd("cd " .. vim.fn.fnameescape(root))
package.path = root .. "/lua/?.lua;" .. root .. "/lua/?/init.lua;" .. package.path

local HEX = "\"#[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]\""

local function sorted_keys(t)
  local ks = {}
  for k in pairs(t) do
    ks[#ks + 1] = k
  end
  table.sort(ks)
  return ks
end

print("-- no raw hex outside lua/lain/ramp.lua")
local files = {}
local out = vim.fn.system({ "git", "ls-files", "*.lua" })
if vim.v.shell_error == 0 then
  for line in out:gmatch("[^\n]+") do
    files[#files + 1] = line
  end
end
if #files == 0 then
  for _, f in
    ipairs(vim.fs.find(function(name)
      return name:match("%.lua$") ~= nil
    end, { path = root, limit = math.huge, type = "file" }))
  do
    if not f:find("/.git/", 1, true) and not f:find("/.omo/", 1, true) then
      files[#files + 1] = f:sub(#root + 2)
    end
  end
end
table.sort(files)
for _, file in ipairs(files) do
  if file ~= "lua/lain/ramp.lua" then
    local fh = io.open(file, "r")
    if fh then
      local dirty = false
      local line_no = 0
      for line in fh:lines() do
        line_no = line_no + 1
        local pos = 1
        while true do
          local s, e = line:find(HEX, pos)
          if not s then
            break
          end
          print(("FAIL  %s:%d %s"):format(file, line_no, line:sub(s, e)))
          dirty = true
          fail = fail + 1
          pos = e + 1
        end
      end
      fh:close()
      if not dirty then
        print("ok    " .. file)
      end
    else
      print(("FAIL  cannot read %s"):format(file))
      fail = fail + 1
    end
  end
end

print("")
print("-- every token binds to a ramp step")
local steps = {}
package.preload["lain.ramp"] = function()
  return setmetatable({}, {
    __index = function(_, key)
      return "@@" .. key
    end,
  })
end
package.loaded["lain.ramp"] = nil
package.loaded["lain.palette"] = nil
local pok, palette = pcall(require, "lain.palette")
if not pok then
  print("FAIL  could not require lain.palette: " .. tostring(palette))
  fail = fail + 1
else
  local tokens = 0
  local function walk(t, path)
    for _, k in ipairs(sorted_keys(t)) do
      local p = path .. "." .. tostring(k)
      local v = t[k]
      if type(v) == "table" then
        walk(v, p)
      elseif type(v) == "string" then
        tokens = tokens + 1
        if v:match("^@@") then
          print(("ok    %s -> %s"):format(p, v))
          steps[v:sub(3)] = true
        elseif v == "NONE" then
          print(("ok    %s -> NONE"):format(p))
        else
          print(("FAIL  %s is a literal"):format(p))
          fail = fail + 1
        end
      elseif type(v) == "boolean" then
        tokens = tokens + 1
        print(("ok    %s -> %s"):format(p, tostring(v)))
      else
        tokens = tokens + 1
        print(("FAIL  %s is a literal"):format(p))
        fail = fail + 1
      end
    end
  end
  for _, section in ipairs({ "ui", "syn", "diag", "diff" }) do
    if type(palette[section]) ~= "table" then
      print(("FAIL  palette.%s is not a table"):format(section))
      fail = fail + 1
    else
      walk(palette[section], section)
    end
  end
  print(("      %d tokens checked"):format(tokens))

  print("-- referenced steps exist in the real ramp")
  package.preload["lain.ramp"] = nil
  package.loaded["lain.ramp"] = nil
  package.loaded["lain.palette"] = nil
  local rok, ramp = pcall(require, "lain.ramp")
  if not rok then
    print("FAIL  could not require lain.ramp: " .. tostring(ramp))
    fail = fail + 1
  else
    local missing = 0
    for _, step in ipairs(sorted_keys(steps)) do
      if ramp[step] == nil then
        print(("FAIL  ramp step %s is missing"):format(step))
        missing = missing + 1
        fail = fail + 1
      end
    end
    if missing == 0 then
      print("ok    every referenced step exists in lain.ramp")
    end
  end
end

print("")
print("-- ramp integrity")
local fh = io.open("lua/lain/ramp.lua", "r")
if not fh then
  print("FAIL  cannot read lua/lain/ramp.lua")
  fail = fail + 1
else
  local step_count = 0
  local missing_index = 0
  local line_no = 0
  for line in fh:lines() do
    line_no = line_no + 1
    local s, e = line:find(HEX)
    if s and not line:sub(e + 1):match("%d") then
      print(("FAIL  lua/lain/ramp.lua:%d hex line lacks an xterm index"):format(line_no))
      missing_index = missing_index + 1
      fail = fail + 1
    end
    local key = line:match("^%s*([%w_]+)%s*=")
    if key then
      local prefix, num = key:match("^([a-z]+)_(%d+)$")
      if num and (prefix == "back" or prefix == "fore" or prefix == "high") then
        step_count = step_count + 1
      end
    end
  end
  fh:close()
  if missing_index == 0 then
    print("ok    every ramp step carries its xterm index")
  end
  if step_count == 36 then
    print("ok    36 ramp steps counted")
  else
    print(("FAIL  %d ramp steps, want 36"):format(step_count))
    fail = fail + 1
  end
end

io.stdout:flush()
if fail > 0 then
  print("")
  print("palette conformance failed")
  io.stdout:flush()
  vim.cmd("cquit!")
else
  print("")
  print("palette conformance passed")
  io.stdout:flush()
end
