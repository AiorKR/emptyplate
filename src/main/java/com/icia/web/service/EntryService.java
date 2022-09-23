package com.icia.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.EntryDao;
import com.icia.web.model.Entry;

@Service("entryService")
public class EntryService 
{
	private static Logger logger = LoggerFactory.getLogger(EntryService.class);
	
	@Autowired
	private EntryDao entryDao;
	
	//입점문의등록	
	
	public int entryInsert(Entry entry)
	{
		
		int count = entryDao.entryInsert(entry);
										
		return count;
	}
	
	//입점문의조회
	public Entry entrySelect(String userPhone) 
	{
		Entry entry = null;
		
		try
		{
			entry = entryDao.entrySelect(userPhone);
		}
		catch(Exception e)
		{
			logger.error("[EntryService] entrySelect Exception", e);
		}
		
		return entry;
	}
	
	//입점문의수정	
	public int entryUpdate(Entry entry)
	{
		int count = 0;
		
		if(count > 0)
		{
			count = entryDao.entryUpdate(entry);
		}
		return count;
	}
	
}
