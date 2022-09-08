package dao;

import org.springframework.stereotype.Repository;

import dao.mapper.WishMapper;
import logic.Wish;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;


@Repository
public class WishDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<WishMapper> cls = WishMapper.class;
	
	public List<Wish> wishlistSelect(String id) {
		return template.getMapper(cls).wishlist(id);
	}
	public Wish wishSelectOne(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {
		return template.getMapper(cls).wishSelectOne(userid, bakeryid);
	}
	public void deleteWish(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {
		template.getMapper(cls).deleteWish(userid, bakeryid);
	}
	
	

}
