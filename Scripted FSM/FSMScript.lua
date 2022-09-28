
-------------------------------------------------------------------------------

-- create the GoHome state

-------------------------------------------------------------------------------
State_GoHome = {}


State_GoHome["Enter"] = function(miner)

  print ("[Lua]: �����ȵ�ɳĮ���߻ؼҡ�")

end


State_GoHome["Execute"] = function(miner)

  print ("[Lua]: �ص�С�ݡ�")

  if miner:Fatigued() then

    miner:GetFSM():ChangeState(State_Sleep)

  else

    miner:GetFSM():ChangeState(State_GoToMine)

  end

end

  
State_GoHome["Exit"] = function(miner)

  print ("[Lua]: ����ѥ�ӣ�׼���ڿ󾮴���һ�졣")

end



-------------------------------------------------------------------------------

-- create the Sleep state

-------------------------------------------------------------------------------

State_Sleep = {}


State_Sleep["Enter"] = function(miner)

  print ("[Lua]: �� "..miner:Name().." ���˯�ˡ�")

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

  print ("[Lua]: �� "..miner:Name().." �о�������ˬ��")

end


-------------------------------------------------------------------------------

-- create the GoToMine state

-------------------------------------------------------------------------------


State_GoToMine = {}


State_GoToMine["Enter"] = function(miner)

  print ("[Lua]: �� "..miner:Name().." ������")

end


State_GoToMine["Execute"] = function(miner)

  miner:IncreaseFatigue()

  miner:AddToGoldCarried(2)

  print ("[Lua]: �� "..miner:Name().." ����� "..miner:GoldCarried().." �������")


  if miner:GoldCarried() > 4 then
  
    print ("[Lua]: �� "..miner:Name().." �����ؼң��ڴ���װ���˽�顣")

    miner:GetFSM():ChangeState(State_GoHome)

  end

end


State_GoToMine["Exit"] = function(miner)

  print ("[Lua]: �� "..miner:Name().." �뿪�˽��")

  end




 