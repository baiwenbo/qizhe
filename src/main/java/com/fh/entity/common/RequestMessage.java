package com.fh.entity.common;

import java.io.Serializable;

public class RequestMessage implements Serializable {

	private static final long serialVersionUID = 1L;

	private String title;
	
	private String content;
	
	private String tags;
	
	private String id;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
