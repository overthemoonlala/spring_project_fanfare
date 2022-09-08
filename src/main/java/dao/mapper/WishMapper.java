package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import logic.Wish;

public interface WishMapper {

	//사용자 위시리스트
	@Select("select w.userid, w.bakeryid, w.wishdate, b.bname from wish w inner join bakery b on w.bakeryid = b.bakeryid where w.userid=#{userid}")
	List<Wish> wishlist(String userid);


	
	@Select("select b.bname from wish w inner join bakery b on w.bakeryid = b.bakeryid where w.userid=#{userid} and w.bakeryid = #{bakeryid}")
	Wish wishSelectOne(@Param("userid") String userid, @Param("bakeryid") String bakeryid);


	@Delete("delete from wish where userid=#{userid} and bakeryid=#{bakeryid}")
	void deleteWish(@Param("userid") String userid, @Param("bakeryid") String bakeryid);
	

}
