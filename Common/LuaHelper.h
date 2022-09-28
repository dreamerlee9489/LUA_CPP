#ifndef LUA_HELPER_H
#define LUA_HELPER_H

#include "OpenLua.h"
#include <string>
#include <stdexcept>

struct LuaExceptionGuard
{
	lua_State* pLua;

	LuaExceptionGuard(lua_State* L) :pLua(L) {}

	~LuaExceptionGuard()
	{
		lua_close(pLua);
	}
};

//打开 lua 库
inline void OpenLuaLibraries(lua_State* pLua)
{
	luaopen_base(pLua);
	luaopen_string(pLua);
	luaopen_table(pLua);
	luaopen_math(pLua);
	luaopen_io(pLua);
}

//------------------------------- RunScript -----------------------------------
//
//  运行脚本文件
//-----------------------------------------------------------------------------
inline void RunLuaScript(lua_State* L, const char* script_name)
{
	if (int error = luaL_dofile(L, script_name) != 0)
	{
		throw std::runtime_error("ERROR(" + std::to_string(error) + "): Problem with lua script file " + script_name);
	}
}

//----------------------------- PopLuaNumber-----------------------------------
//
// 从 lua 堆栈中检索数字的函数模板
//-----------------------------------------------------------------------------
template <class T>
inline T PopLuaNumber(lua_State* pL, const char* name)
{
	lua_settop(pL, 0);

	lua_getglobal(pL, name);

	//检查变量是否是正确的类型。 如果不抛出异常
	if (!lua_isnumber(pL, 1))
	{
		std::string err("<PopLuaNumber> Cannot retrieve: ");

		throw std::runtime_error(err + name);
	}

	//获取值，转换为正确的类型并返回
	T val = (T)lua_tonumber(pL, 1);

	//从堆栈中删除值
	lua_pop(pL, 1);

	return val;
}

//--------------------------- PopLuaString ------------------------------------
//-----------------------------------------------------------------------------
inline std::string PopLuaString(lua_State* pL, const char* name)
{
	lua_settop(pL, 0);

	lua_getglobal(pL, name);

	//检查变量是否是正确的类型。 如果不抛出异常
	if (!lua_isstring(pL, 1))
	{
		std::string err("<PopLuaString> Cannot retrieve: ");

		throw std::runtime_error(err + name);
	}

	//获取值，转换为正确的类型并返回
	std::string s = lua_tostring(pL, 1);

	//从堆栈中删除值
	lua_pop(pL, 1);

	return s;
}

//--------------------------- PopLuaBool ------------------------------------
//-----------------------------------------------------------------------------
inline bool PopLuaBool(lua_State* pL, const char* name)
{
	lua_settop(pL, 0);

	lua_getglobal(pL, name);

	//检查变量是否是正确的类型。 如果不抛出异常
	if (!lua_isstring(pL, 1))
	{
		std::string err("<PopLuaBool> Cannot retrieve: ");

		throw std::runtime_error(err + name);
	}

	//获取值，转换为正确的类型并返回
	bool b = lua_toboolean(pL, 1);

	//从堆栈中删除值
	lua_pop(pL, 1);

	return b;
}

//------------------------- LuaPopStringFieldFromTable ------------------------
//-----------------------------------------------------------------------------
inline std::string LuaPopStringFieldFromTable(lua_State* L, const char* key)
{

	//将key推入堆栈
	lua_pushstring(L, key);

	//表现在位于-2（键位于-1）。 lua_gettable 现在将键从堆栈中弹出，然后将在键位置找到的数据放入堆栈
	lua_gettable(L, -2);

	//检查变量是否是正确的类型。 如果不抛出异常
	if (!lua_isstring(L, -1))
	{
		std::string err("<LuaPopStringFieldFromTable> Cannot retrieve: ");

		throw std::runtime_error(err + key);
	}

	//抓取数据
	std::string s = lua_tostring(L, -1);

	lua_pop(L, 1);

	return s;
}

//----------------------------- LuaPopNumberFieldFromTable --------------------
//-----------------------------------------------------------------------------
template <class T>
inline T LuaPopNumberFieldFromTable(lua_State* L, const char* key)
{
	//将key推入堆栈
	lua_pushstring(L, key);

	//表现在位于-2（键位于-1）。lua_gettable 现在将键从堆栈中弹出，然后将在键位置找到的数据放入堆栈
	lua_gettable(L, -2);

	//检查变量是否是正确的类型。 如果不抛出异常
	if (!lua_isnumber(L, -1))
	{
		std::string err("<LuaPopNumberFieldFromTable> Cannot retrieve: ");

		throw std::runtime_error(err + key);
	}

	//抓取数据
	T val = (T)lua_tonumber(L, -1);

	lua_pop(L, 1);

	return val;
}

#endif