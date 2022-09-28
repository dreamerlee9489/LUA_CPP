
-------------------------------------------------------------------------------

-- create the GoHome state

-------------------------------------------------------------------------------
State_GoHome = {}


State_GoHome["Enter"] = function(miner)

  print ("[Lua]: 在炎热的沙漠中走回家。")

end


State_GoHome["Execute"] = function(miner)

  print ("[Lua]: 回到小屋。")

  if miner:Fatigued() then

    miner:GetFSM():ChangeState(State_Sleep)

  else

    miner:GetFSM():ChangeState(State_GoToMine)

  end

end

  
State_GoHome["Exit"] = function(miner)

  print ("[Lua]: 穿上靴子，准备在矿井待上一天。")

end



-------------------------------------------------------------------------------

-- create the Sleep state

-------------------------------------------------------------------------------

State_Sleep = {}


State_Sleep["Enter"] = function(miner)

  print ("[Lua]: 矿工 "..miner:Name().." 打瞌睡了。")

end


State_Sleep["Execute"] = function(miner)

  if miner:Fatigued() then

    print ("[Lua]: ZZZZZZ... ")

    miner:DecreaseFatigue()

  else

    miner:GetFSM():ChangeState(State_GoToMine)

  end

end

State_Sleep["Exit"] = function(miner)

  print ("[Lua]: 矿工 "..miner:Name().." 感觉神清气爽！")

end


-------------------------------------------------------------------------------

-- create the GoToMine state

-------------------------------------------------------------------------------


State_GoToMine = {}


State_GoToMine["Enter"] = function(miner)

  print ("[Lua]: 矿工 "..miner:Name().." 进入金矿。")

end


State_GoToMine["Execute"] = function(miner)

  miner:IncreaseFatigue()

  miner:AddToGoldCarried(2)

  print ("[Lua]: 矿工 "..miner:Name().." 获得了 "..miner:GoldCarried().." 块金条。")


  if miner:GoldCarried() > 4 then
  
    print ("[Lua]: 矿工 "..miner:Name().." 决定回家，口袋里装满了金块。")

    miner:GetFSM():ChangeState(State_GoHome)

  end

end


State_GoToMine["Exit"] = function(miner)

  print ("[Lua]: 矿工 "..miner:Name().." 离开了金矿。")

  end




 