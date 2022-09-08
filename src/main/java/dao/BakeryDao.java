package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BakeryMapper;
import logic.Bakery;
import logic.BakeryMenu;
import logic.BakeryReview;
import logic.LikeBakery;

@Repository
public class BakeryDao {
	@Autowired
	private SqlSessionTemplate template; 
	private Map<String, Object> param = new HashMap<String, Object>();
	private Class<BakeryMapper> cls = BakeryMapper.class;
	
	public Bakery bakerySelectOne(String userid) {
		return template.getMapper(cls).bakerySelectOne(userid);
	}

	public void update(Bakery bakery) {
		template.getMapper(cls).update(bakery);
	}

	//0603추가
	public Bakery bakerySelectbakeryid(String bakeryid) {
		return template.getMapper(cls).bakerySelectbakeryid(bakeryid);
	}

	public void insert(@Valid Bakery bakery, String userid) {
		
		template.getMapper(cls).insert(bakery, userid);
	}
//	public void bakeryMenuInsert(Bakery bakery, String[] menuname) {
//		int num = maxNum() + 1; //db에 등록된 num컬럼 중 최대값 + 1
//		bakery.setNo(num);
//		int menunum = maxmenuNum(bakery.getBakeryid()) + 1;
//		bakery.setMenuid(menunum);
//		param.clear();
//		param.put("menuname", bakert.get);
//		template.getMapper(cls).bakeryMenuInsert(bakery, param);
//		
//	}
	private int maxNum() {
		return template.getMapper(cls).maxNum();
	}
	private int maxmenuNum(String bakeryid) {
		return template.getMapper(cls).maxmenuNum(bakeryid);
	}
	public List<Bakery> bakerylistSelect() {
		return template.getMapper(cls).bakerylist();
	}

	public void adminbakeryupdate(String bakeryid) {
		template.getMapper(cls).adminbakeryupdate(bakeryid);
		
	}

	public void bakeryMenuInsert(String bakeryid, String menufileurl, String menuinfo, String menuname) {
		 int no = maxNum() + 1; //db에 등록된 num컬럼 중 최대값 + 1 
		 int menuid = maxmenuNum(bakeryid) + 1; 
		 param.clear();
		 param.put("bakeryid", bakeryid);
		 param.put("no", no);
		 param.put("menuid", menuid);
		 param.put("menufileurl", menufileurl);
		 param.put("menuinfo", menuinfo);
		 param.put("menuname", menuname);
		 template.getMapper(cls).bakeryMenuInsert(param);
	}

	public List<BakeryMenu> bakerymenuSelect(String bakeryid) {
		return template.getMapper(cls).bakerymenuSelect(bakeryid);
	}
	
// ------------------------------김수희---------------------------------	
	public int count() {
		return template.getMapper(cls).count();
	}
	public int rcount(String bakeryid) {
		return template.getMapper(cls).rcount(bakeryid);
	}
	public List<Bakery> list(Integer pageNum, int limit, String pageid) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		param.put("pageid", pageid);
		return template.getMapper(cls).list(param);
	}
	
	public Bakery bakeryinfo(String bakeryid) {
		return template.getMapper(cls).bakeryinfo(bakeryid);
	}

	public void readcntadd(Integer viewno) {
		template.getMapper(cls).readcntadd(viewno);
	}

	private int review_maxNum() {
		return template.getMapper(cls).review_maxNum();
	}

	public void review_write(BakeryReview bakeryreview) {
		int no = review_maxNum()+1;
		bakeryreview.setNo(no);
		bakeryreview.setGrp(no);
		template.getMapper(cls).reviewinsert(bakeryreview);
		
	}

	public List<BakeryReview> review_list(Integer pageNum, int limit, String bakeryid) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		param.put("bakeryid", bakeryid);
		return template.getMapper(cls).review_list(param); 
	}

	public List<BakeryMenu> bakerymenu(String bakeryid,Integer no, Integer menuid) {
		param.clear();
		param.put("bakeryid", bakeryid);
		param.put("no", no);
		param.put("menuid", menuid);
		return template.getMapper(cls).bakerymenuSelect(bakeryid); 
	}

	public BakeryReview selectOne2(Integer no) {
		return template.getMapper(cls).SelectOne2(no);
	}

	public Bakery selectOne3(String userid) {
		return template.getMapper(cls).SelectOne3(userid);
	}

	public LikeBakery likeBakery(String bakeryid, String userid) {
		return template.getMapper(cls).likeBakery(bakeryid,userid);
	}

	
	
}
