package com.fh.entity;

public class Image {

	private int id;
	  private String name;
	  private String type;
	  private int userId;
	  private String aliasName;
	  private String url;
	  private String createTime;
	  
	  public int getId()
	  {
	    return this.id;
	  }
	  
	  public void setId(int id)
	  {
	    this.id = id;
	  }
	  
	  public String getName()
	  {
	    return this.name;
	  }
	  
	  public void setName(String name)
	  {
	    this.name = name;
	  }
	  
	  public String getType()
	  {
	    return this.type;
	  }
	  
	  public void setType(String type)
	  {
	    this.type = type;
	  }
	  
	  public int getUserId()
	  {
	    return this.userId;
	  }
	  
	  public void setUserId(int userId)
	  {
	    this.userId = userId;
	  }
	  
	  public String getAliasName()
	  {
	    return this.aliasName;
	  }
	  
	  public void setAliasName(String aliasName)
	  {
	    this.aliasName = aliasName;
	  }
	  
	  public String getUrl()
	  {
	    return this.url;
	  }
	  
	  public void setUrl(String url)
	  {
	    this.url = url;
	  }
	  
	  public String getCreateTime()
	  {
	    return this.createTime;
	  }
	  
	  public void setCreateTime(String createTime)
	  {
	    this.createTime = createTime;
	  }
}
