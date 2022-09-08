package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import dao.mapper.UserMapper;
import logic.Bakery;
import logic.Reservation;
import logic.Wish;
import logic.User;

@Repository
public class UserDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<UserMapper> cls = UserMapper.class;
	
	public void insert(User user) {
		template.getMapper(cls).insert(user);
		
	}
	public User selectOne(String userid) {
		return template.getMapper(cls).selectOne(userid);

	}
	public void update(User user) {
		template.getMapper(cls).update(user);
	}
	public void passwordupdate(String userid, String chgpass) {
		param.clear();
		param.put("userid", userid);
		param.put("pass", chgpass);
		template.getMapper(cls).passwordupdate(param);
	}
	public void delete(String userid) {
		template.getMapper(cls).delete(userid);
	}


	public List<User> userlistSelect() {
		return template.getMapper(cls).userlist();
	}
	
	public String search(User user, String url) {
		param.clear();
		param.put("email", user.getEmail());
		param.put("tel", user.getTel());
		if(url.equals("id")) {// 아이디 찾기
			param.put("col","userid");
		}
		else if (url.equals("pw")) { // 비밀번호 찾기
			param.put("userid", user.getUserid());
			param.put("col","'**'||substr(pass,3,length(pass)-2)"); // || => OR 아님
		}
		return template.getMapper(cls).search(param);
	}
	
	
	
	
	
	
	
}
