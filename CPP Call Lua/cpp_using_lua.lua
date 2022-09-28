-- lua script to demonstrate global variables

--global string and number types

name   = "蜘蛛侠";
age    = 29;


--global table creation

simple_table = {name="钢铁侠", age=20};


--a simple function to add two numbers

function add(a,b)
    
    return (a+b);

end;

 
print("[Lua]: \"cpp_using_lua.lua\" 脚本运行完成！");