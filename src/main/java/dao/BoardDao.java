package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;
import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import logic.Board;

@Repository // 해당 클래스를 루트 컨테이너에 빈(Bean) 객체로 생성해주는 어노테이션
public class BoardDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<String,Object>();
	private Class<BoardMapper> cls = BoardMapper.class;

	//boardid 받아오기
	public int count(String boardid) {
		return template.getMapper(cls).count(boardid);
	}
		
	
	public List<Board> list(Integer pageNum, int limit, String boardid) {
		param.clear();
		int startrow = (pageNum - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		param.put("startrow", startrow);
		param.put("endrow", endrow);
		param.put("boardid", boardid);
		return template.getMapper(cls).list(param);
	}
	
	
	
	public void write(Board board) {
		int num = maxNum() + 1; //db에 등록된 num컬럼 중 최대값 + 1
		board.setNum(num); 
		board.setGrp(num); //원글 grp 값은 num 값과 같다. 
		template.getMapper(cls).write(board);
	}
	

	private int maxNum() {
		return template.getMapper(cls).maxNum();
	}
	
	
	public Board selectOne(Integer num) {
		param.clear();
		param.put("num", num);
		return template.getMapper(cls).selectOne(num);
	}
	
	
	public void readcntadd(Integer num) {
		param.clear();
		param.put("num",num);
		template.getMapper(cls).readcntadd(num);
	}
	
	
	public void update(Board board) {
		template.getMapper(cls).update(board);
	}
	
	
	public void grpStepAdd(Board board) {
		template.getMapper(cls).grpStepAdd(board);
	}
	
	
	public void reply(Board board) {
		board.setNum(maxNum() + 1); //답글의 num 저장
		board.setGrplevel(board.getGrplevel()+1);//답글의 grplevel로 저장 : 원글 level + 1
		board.setGrpstep(board.getGrpstep()+1);  //답글의 grpstep로 저장 : 원글 step + 1
		template.getMapper(cls).reply(board);
	}
	
	
	public void delete(Integer num) {
		param.clear();
		param.put("num", num);
		template.getMapper(cls).delete(num);
	}	
}
