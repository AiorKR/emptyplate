package com.icia.web.dao;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Entry;


@Repository("EntryDao")
public interface EntryDao 
{	
	
	
	//입점문의등록
	public int entryInsert(Entry entry);
	
	//입점문의조회
	public Entry entrySelect(long entrySeq);
	   
	//입점문의수정
	public int entryUpdate(Entry entry);
}
