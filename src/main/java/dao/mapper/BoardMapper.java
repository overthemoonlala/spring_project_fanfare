package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;



public interface BoardMapper {

	@Select("select count(*) from board where boardid=#{boardid}")
	int count(String boardid);


	@Select( "select * from "
	         + "(select rownum rnum , num, writer,subject, content,file1 fileurl,regdate,"
			 + " grp,grplevel,grpstep, pass, readcnt from "
			 + "(select * from board where boardid =#{boardid} order by grp desc, grpstep asc))"
			 + " where rnum >=#{startrow} and rnum <=#{endrow}")
	List<Board> list(Map<String, Object> param);
	
	

	@Insert("insert into board "
			+ "(num,writer,pass,subject,content,file1,regdate,readcnt,"
			+ " grp,grplevel,grpstep,boardid,ip)"
			+ " values (#{num},#{writer},#{pass},#{subject},#{content},#{fileurl},sysdate,"
			+ " 0,#{grp},#{grplevel},#{grpstep},#{boardid},#{ip})")
	void write(Board board);

	
	
	@Select("select nvl(max(num),0) from board")
	int maxNum();
	


	@Select("select num, writer,subject, content,file1 fileurl,regdate,"
			+ " grp,grplevel,grpstep, pass, readcnt,boardid from board where num=#{num}")
	Board selectOne(Integer num);


	@Update("update board set readcnt = readcnt+1 where num =#{num}")
	void readcntadd(Integer num);
	
	
	
	@Update("update board set writer=#{writer}, subject=#{subject}, content=#{content},"
			+ "file1=#{fileurl} where num=#{num}")
	void update(Board board);


	@Update("update board set grpstep = grpstep+1 "
			+ " where grp =#{grp} and grpstep > #{grpstep}")
	
	void grpStepAdd(Board board);
	
	

	@Insert("insert into board "
			+ "(num,writer,pass,subject,content,file1,regdate,readcnt,"
			+ " grp,grplevel,grpstep,boardid,ip)"
			+ " values (#{num},#{writer},#{pass},#{subject},#{content},#{fileurl},sysdate,"
			+ "0,#{grp},#{grplevel},#{grpstep},#{boardid},#{ip})")
	void reply(Board board);

	
	
	@Delete("delete from board where num=#{num}")
	void delete(Integer num);
	
}
