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

class fbstransfer:public eosio::contract
{
public:
	explicit fbstransfer(action_name self) : contract(self){}

	//@abi action
	void transfer(string from, string frompub, string to, string topub, asset quantity, string memo)
	{
		//新增加的数据
		datatable_index datatables(_self, _self);  //(code, scope)
		datatables.emplace(_self, [&](auto & o){
			o.id = datatables.available_primary_key();
			o.from = from;
			o.frompub = frompub;
			o.to = to;
			o.topub = topub;
			o.quantity =quantity;
		});
	}

private:
	/// @abi table datatable i64
	struct datatable
	{
		uint64_t id = 0;
		string from;
		string frompub;
		string to;
		string topub;
		asset quantity;


		auto primary_key() const {return id;};
		EOSLIB_SERIALIZE(datatable, (id)(from)(frompub)(to)(topub)(quantity));
	};
	typedef eosio::multi_index<N(datatable), datatable> datatable_index;
};

EOSIO_ABI( fbstransfer, (transfer) )

