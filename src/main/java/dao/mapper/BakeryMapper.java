package dao.mapper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.NotEmpty;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.multipart.MultipartFile;

import logic.Bakery;
import logic.BakeryMenu;
import logic.BakeryReview;
import logic.LikeBakery;

public interface BakeryMapper {
	
	@Select("select * from bakery where userid=#{userid}")
	Bakery selectOne(String userid);

	@Select("select * from Bakery where userid=#{userid}")
	Bakery bakerySelectOne(String userid);

	@Update("update bakery set opentime=#{opentime}, closetime=#{closetime}, dayoff=#{dayoff} where userid=#{userid}")
	void update(Bakery bakery);

	//0603추가
	@Select("select * from Bakery where bakeryid=#{bakeryid}")
	Bakery bakerySelectbakeryid(String bakeryid);

	@Insert("insert into bakery (bakeryid, bname, bakeryinfo, fileurl, location, opentime, closetime, dayoff, bakerytel, regdate, userid, adminchk, likeno, pageid) "
			+ "values(#{bakery.bakeryid},#{bakery.bname}, #{bakery.bakeryinfo}, #{bakery.fileurl}, #{bakery.location}, #{bakery.opentime}, #{bakery.closetime}, #{bakery.dayoff}, #{bakery.bakerytel}, sysdate, #{userid}, 0, 0, 1)")
	void insert(@Param("bakery") Bakery bakery, @Param("userid") String userid);

	@Select("select * from bakery where adminchk = 0")
	List<Bakery> bakerylist();

	@Update("update bakery set adminchk = 1 where bakeryid=#{bakeryid}")
	void adminbakeryupdate(String bakeryid);

	
	@Insert("insert into bakerymenu (bakeryid, no, menuid, menuname, menufileurl, menuinfo) "
			+ " values (#{bakeryid}, #{no}, #{menuid}, #{menuid},  #{menufileurl},  #{menuinfo})")
	void bakeryMenuInsert(Map<String, Object> param);

	@Select("select nvl(max(no),0) from bakerymenu")
	int maxNum();
	
	@Select("select nvl(max(menuid),0) from bakerymenu where bakeryid=#{bakeryid}")
	int maxmenuNum(String bakeryid);

	@Select("select * from bakerymenu where bakeryid=#{bakeryid}")
	List<BakeryMenu> bakerymenuSelect(String bakeryid);
	
	//--------------------------김수희-------------------------------
	@Select("select count(*) from bakery order by likeno")
	int count();
	
	@Select("select count(*) from bakeryreview where bakeryid=#{bakeryid}")
	int rcount(String bakeryid);
	
	@Select("select * from "
			+ " (select rownum rnum, pageid, userid, bakeryid, adminchk, bname, location, likeno, viewno from"
			+ " (select * from bakery where pageid=#{pageid} order by likeno desc))"
			+ " where rnum >= #{startrow} and rnum <= #{endrow}")
	List<Bakery> list(Map<String, Object> param);

	@Select("select * from bakery where bakeryid=#{bakeryid}")
	Bakery bakeryinfo(String bakeryid);

	@Update("update bakery set viewno = viewno+1 where bakeryid=#{bakeryid}")
	void readcntadd(Integer viewno);
	
	@Select("select nvl(max(no),0) from bakeryreview")
	int review_maxNum();

	@Insert("insert into bakeryreview "
			+ " (no, userid, subject, content, file1, regdate, readcnt,"
			+ " grp,grplevel, grpstep, bakeryid) "
			+ " values (#{no}, #{userid}, #{subject}, #{content}, #{fileurl}, sysdate, "
			+ " 0, #{grp}, #{grplevel}, #{grpstep}, #{bakeryid})")
	void reviewinsert(BakeryReview bakeryreview);
	
	@Select("select * from "
			+ " (select rownum rnum, bakeryid, no, userid, subject, content, regdate,"
			+ " file1 fileurl, grp, grplevel, grpstep from "
			+ " (select * from bakeryreview where bakeryid=#{bakeryid} order by grp desc, grpstep asc))"
			+ " where rnum >= #{startrow} and rnum <= #{endrow}")
	List<BakeryReview> review_list(Map<String, Object> param);

	@Select("select * from "
			+ " (select bakeryid, no, menuid, menuname, menuimg, menuinfo from"
			+ " (select * from bakerymenu where bakeryid=#{bakeryid} order by no desc))")
	List<BakeryMenu> bakerymenu(Map<String, Object> param);
	
	@Select("select no, bakeryid, userid, subject, content, file1, fileurl, regdate, "
			+ " grp, grplevel, grpstep, readcnt from bakeryreview where no=#{no}")
	BakeryReview SelectOne2(Integer no);

	@Select("select userid from bakery where userid=#{userid}")
	Bakery SelectOne3(String userid);

	@Select("select * from likebakery where bakeryid=#{bakeryid} and userid=#{userid}")
	LikeBakery likeBakery(@Param("bakeryid") String bakeryid, @Param("userid") String userid);

	
}
