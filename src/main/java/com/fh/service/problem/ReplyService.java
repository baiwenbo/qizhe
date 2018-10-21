package com.fh.service.problem;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("replyService")
public class ReplyService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("ReplyMapper.save", pd);
	}
	
	/*
	* h5问题回复新增
	*/
	public void addReply(PageData pd)throws Exception{
		dao.save("ReplyMapper.addReply", pd);
	}
	
	/*
	* 保存问题回复
	*/
	public void saveU(PageData pd)throws Exception{
		dao.save("ReplyMapper.saveU", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("ReplyMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("ReplyMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ReplyMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ReplyMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ReplyMapper.findById", pd);
	}
	
	/*
	* 通过问题ID获取回复列表数据
	*/
	public List<PageData> findByReplyList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ReplyMapper.findByReplyList", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ReplyMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

