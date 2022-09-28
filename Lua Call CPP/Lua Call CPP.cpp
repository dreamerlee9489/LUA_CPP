#include "OpenLua.h"
#include "LuaHelper.h"
#include "RockPaperScissors.h"
#include <iostream>
#include <string>
using namespace std;

int main()
{
	//create a lua state
	lua_State* pL = lua_open();

	//open the lua libaries - new in lua5.1
	luaL_openlibs(pL);

	//register the functions with lua
	lua_register(pL, "GetAIMoveWrapper", GetAIMoveWrapper);
	lua_register(pL, "EvaluateTheGuessesWrapper", EvaluateTheGuessesWrapper);

	//run the script
	RunLuaScript(pL, "lua_using_cpp.lua");

	//tidy up
	lua_close(pL);

	cout << "\n\n\n";

	return 0;
}