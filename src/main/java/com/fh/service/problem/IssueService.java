package com.fh.service.problem;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service("issueService")
public class IssueService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("IssueMapper.save", pd);
	}
	
	/*
	* H5新增
	*/
	public void addIssue(PageData pd)throws Exception{
		dao.save("IssueMapper.addIssue", pd);
	}
	
	/*
	* H5新增图片和问题关联表
	*/
	public void addIssueImage(PageData pd)throws Exception{
		dao.save("IssueMapper.addIssueImage", pd);
	}
	
	/*
	* 保存用户
	*/
	public void saveU(PageData pd)throws Exception{
		dao.save("IssueMapper.saveU", pd);
	}
	
	/*
	* 保存用户
	*/
	public void saveUser(PageData pd)throws Exception{
		dao.save("IssueMapper.saveUser", pd);
	}
	
	
	/*
	* 保存用户
	*/
	public void saveIssue(PageData pd)throws Exception{
		dao.save("IssueMapper.saveIssue", pd);
	}
	
	/*
	* 保存回复
	*/
	public void saveReply(PageData pd)throws Exception{
		dao.save("IssueMapper.saveReply", pd);
	}
	
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("IssueMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("IssueMapper.edit", pd);
	}
	
	/*
	*问题列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("IssueMapper.datalistPage", page);
	}
	
	/*
	*广告列表
	*/
	public List<PageData> adList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("IssueMapper.adlistPage", page);
	}
	
	/*
	*H5广告列表
	*/
	public List<PageData> adProblemList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("IssueMapper.adProblemlistPage", page);
	}
	
	/*
	*根据问题ID查询图片地址
	*/
	public List<PageData> urlList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("IssueMapper.urlList", pd);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("IssueMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("IssueMapper.findById", pd);
	}
	
	/*
	* 查询最新问题ID 
	*/
	public PageData findByIssueId()throws Exception{
		return (PageData)dao.findForObject("IssueMapper.findByIssueId", null);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("IssueMapper.deleteAll", ArrayDATA_IDS);
	}
	
}

