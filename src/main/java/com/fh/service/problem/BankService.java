package com.fh.service.problem;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.Bank;
import com.fh.util.PageData;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import java.util.List;


@Service("bankService")
public class BankService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(Bank bank)throws Exception{
		dao.save("BankMapper.save", bank);
	}
	

}

