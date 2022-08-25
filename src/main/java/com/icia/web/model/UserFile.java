package com.icia.web.model;

import java.io.Serializable;

public class UserFile implements Serializable
{
   private static final long serialVersionUID = 1l;
   
   private String userUID;
   private String fileName;
   private String fileExt;
   private long fileSize;
   private String regDate;
   
   public UserFile()
   {
	   userUID = "";
	   fileName = "";
	   fileExt = "";
	   fileSize = 0;
	   regDate = "";
   }

public String getUserUID() {
	return userUID;
}

public void setUserUID(String userUID) {
	this.userUID = userUID;
}

public String getFileName() {
	return fileName;
}

public void setFileName(String fileName) {
	this.fileName = fileName;
}

public String getFileExt() {
	return fileExt;
}

public void setFileExt(String fileExt) {
	this.fileExt = fileExt;
}

public long getFileSize() {
	return fileSize;
}

public void setFileSize(long fileSize) {
	this.fileSize = fileSize;
}

public String getRegDate() {
	return regDate;
}

public void setRegDate(String regDate) {
	this.regDate = regDate;
}
}
