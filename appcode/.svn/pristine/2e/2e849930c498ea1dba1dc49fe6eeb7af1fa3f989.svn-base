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
 *		说明   : 这个合约用来转账记录
 */

#include <eosiolib/eosio.hpp>
#include <eosiolib/asset.hpp>
using namespace eosio;
#include <string>
using std::string;

class redenvelope:public eosio::contract
{
public:
	explicit redenvelope(action_name self) : contract(self){}

	//@abi action
	void send(string from, string frompub, asset quantity, uint32_t num, string memo)
	{
		//新增加的数据
		datasend_index datatables(_self, _self);  //(code, scope)
		datatables.emplace(_self, [&](auto & o){
			o.id = datatables.available_primary_key();
			o.from = from;
			o.frompub = frompub;
			o.quantity = quantity;
			o.num = num;
		});
	}

	//@abi action
	void recv(string name, string publickey, asset quantity, string memo)
	{
		datarecv_index datatables(_self, _self);  //(code, scope)
		datatables.emplace(_self, [&](auto & o){
			o.id = datatables.available_primary_key();
			o.name = name;
			o.publickey = publickey;
			o.quantity = quantity;
		});
	}

private:
	// @abi table datasend i64
	struct datasend
	{
		uint64_t id = 0;
		string from;
		string frompub;
		asset quantity;
		uint32_t   num;

		auto primary_key() const {return id;};
		EOSLIB_SERIALIZE(datasend, (id)(from)(frompub)(quantity)(num));
	};
	typedef eosio::multi_index<N(datasend), datasend> datasend_index;

	// @abi table datarecv i64
	struct datarecv
	{
		uint64_t id = 0;
		string name;
		string publickey;
		asset quantity;

		auto primary_key() const {return id;};
		EOSLIB_SERIALIZE(datarecv, (id)(name)(publickey)(quantity));
	};
	typedef eosio::multi_index<N(datarecv), datarecv> datarecv_index;
};

EOSIO_ABI(redenvelope, (send)(recv))





