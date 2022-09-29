package com.icia.web.model;

import java.io.Serializable;

public class UserFile implements Serializable
{
   private static final long serialVersionUID = 1l;
   
   private String userUID;
   private short fileSeq;      //파일 번호
   private String fileOrgName;   //원본 파일명
   private String fileName;   //파일명
   private String fileExt;      //파일 확장자
   private long fileSize;      //파일크기(byte)
   private String regDate;      //등록일
   
   public UserFile()
   {
      userUID = "";
      fileSeq = 0;
      fileName = "";
      fileOrgName = "";
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

public short getFileSeq() {
   return fileSeq;
}

public void setFileSeq(short fileSeq) {
   this.fileSeq = fileSeq;
}

public String getFileOrgName() {
   return fileOrgName;
}

public void setFileOrgName(String fileOrgName) {
   this.fileOrgName = fileOrgName;
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