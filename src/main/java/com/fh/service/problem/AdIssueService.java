package com.fh.service.problem;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service("adIssueService")
public class AdIssueService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("AdIssueMapper.save", pd);
	}
	
	/*
	* 保存用户
	*/
	public void saveU(PageData pd)throws Exception{
		dao.save("AdIssueMapper.saveUser", pd);
	}
	
	/*
	* 导入excel到数据库用户
	*/
	public void saveUser(PageData pd)throws Exception{
		dao.save("AdIssueMapper.saveUser", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("AdIssueMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("AdIssueMapper.edit", pd);
	}
	/*
	* 新增图片和广告关联
	*/
	public void addAdIssueImage(PageData pd)throws Exception{
		dao.save("AdIssueMapper.addAdIssueImage", pd);
	}
	
	/*
	*广告列表
	*/
	public List<PageData> adList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("AdIssueMapper.adlistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AdIssueMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("AdIssueMapper.findById", pd);
	}

	/*
	* 查询最新问题ID
	*/
	public PageData findAdIssueId()throws Exception{
		return (PageData)dao.findForObject("AdIssueMapper.findAdIssueId", null);
	}
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("AdIssueMapper.deleteAll", ArrayDATA_IDS);
	}

	/*
	 *通过广告id删除广告图片关联关系
	 */
	public void deleteAdIssueImage(PageData pd)throws Exception {
		dao.delete("AdIssueMapper.deleteAdIssueImage",pd);
	}

	/*
	 *批量删除广告图片关联关系
	 */
	public void deleteAllAdIssueImage(String[] ArrayDATA_IDS)throws Exception {
		dao.delete("AdIssueMapper.deleteAllAdIssueImage", ArrayDATA_IDS);
	}

	/*
	 *软删除
	 */
	public void editIsDelete(PageData pd)throws Exception  {
		dao.update("AdIssueMapper.editIsDelete",pd);
	}

	/*
	 *批量软删除
	 */
	public void editIsDeleteByList(String[] ArrayDATA_IDS)throws Exception  {
		dao.update("AdIssueMapper.editIsDeleteByList",ArrayDATA_IDS);
	}

	///*
	//*通过广告id删除广告图片关联关系
	// */
	//public void deleteAdIssueReply(PageData pd) {
	//}
}

