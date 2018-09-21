/*
 * fbsredenvelope.cpp
 *
 *  Created on: 2018年8月25日
 *      Author: ubuntu
 */
/*
 * fbstransfer.cpp
 *
 *  Created on: 2018年8月25日
 *      Author: ubuntu
 *		说明   : 这个合约彩蛋游戏
 */

#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>
using namespace eosio;
#include <string>
using std::string;

class egggame: public eosio::contract
{
public:
	explicit egggame(action_name self) : contract(self){}

	//@abi action
	void create(uint32_t gameid, string creator, string category, string memo )
	{
		game_index games(_self,_self);
		games.emplace(_self, [&](auto & o){
			o.id = games.available_primary_key();
			o.gameid = gameid;
			o.creator = creator;
			o.category = category;
		});
	}

	//==========================================================================
	//用户下注，每个用户下注后调用
	//@abi action
	void bet(uint32_t gameid, string gamename, string username, string publickey, asset quantity, string memo)
	{
		betinfo_index betinfos(_self,_self);
		betinfos.emplace(_self, [&](auto & o){
			o.id = betinfos.available_primary_key();
			o.gameid = gameid;
			o.gamename = gamename;
			o.username = username;
			o.publickey = publickey;
			o.quantity = quantity;
		});

	}

	//@abi action
	void settlement(uint32_t gameid, string gamename, string username, string publickey, asset quantity, string memo )
	{
		settledata_index settledatas(_self,_self);
		settledatas.emplace(_self, [&](auto & o){
			o.id = settledatas.available_primary_key();
			o.gameid = gameid;
			o.gamename = gamename;
			o.username = username;
			o.publickey = publickey;
			o.quantity = quantity;
		});
	}

private:
	//@abi table game i64
	struct game
	{
		uint64_t id = 0;
		uint32_t gameid;
		string creator;
		string category;

		auto primary_key() const {return id;};

		EOSLIB_SERIALIZE(game, (id)(gameid)(creator)(category));
	};
	typedef eosio::multi_index<N(game), game> game_index;

	//@abi table betinfo i64
	struct betinfo
	{
		uint64_t id = 0;
		uint64_t gameid;
		string gamename;
		string username;
		string publickey;
		asset quantity;
		auto primary_key() const {return id;};

		EOSLIB_SERIALIZE(betinfo, (id)(gameid)(gamename)(username)(publickey)(quantity));
	};
	typedef eosio::multi_index<N(betinfo), betinfo> betinfo_index;

	//@abi table settledata i64
	struct settledata
	{
		uint64_t id = 0;
		uint32_t gameid;
		string gamename;
		string username;
		string publickey;
		asset quantity;

		auto primary_key() const {return id;};

		EOSLIB_SERIALIZE(settledata, (id)(gameid)(gamename)(username)(publickey)(quantity));
	};
	typedef eosio::multi_index<N(settledata), settledata> settledata_index;
};

EOSIO_ABI(egggame, (create)(bet)(settlement))





