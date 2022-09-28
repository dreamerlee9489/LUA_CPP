
--Name:   rock_paper_scissors2.lua

--Author: Mat Buckland 2003

--Desc:   lua script to implement a rock paper scissors game

---------------------------------------------------------------
--[[ seed the random number generator ]]--

math.randomseed(os.time());

--[[these global variables will hold the scores of the player
  and the computer]]

user_score = 0;
comp_score = 0;



--[[    main game loop     ]]--

loop = true;
while loop == true do

    --let the user know the current score
    print("\n[Lua] 用户："..user_score.." 电脑："..comp_score)

    print("[Lua] 用户猜拳： 剪刀(s)/石头(r)/布(p)  [Q键退出]")

    --grab input from the user via the keyboard
    user_guess = io.stdin:read '*l';

    --create a table to convert user input into a play string
    local possible_moves = {s = "剪刀", r = "石头", p = "布"};
    
    if user_guess == "q" then

        loop = false;   --quit the game if user enters 'q'

    elseif (user_guess == "r") or (user_guess == "p") or (user_guess == "s") then 

        comp_guess = GetAIMoveWrapper();

        --get the updated scores from the C++ function EvaluateTheGuesses
        user_score, comp_score = EvaluateTheGuessesWrapper(possible_moves[user_guess],
                                                        comp_guess,
                                                        user_score,
                                                        comp_score);

    else

        print ("[Lua] 无效输入，请重试");

    end   
end;






