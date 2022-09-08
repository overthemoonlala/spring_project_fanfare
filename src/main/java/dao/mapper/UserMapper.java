package dao.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Reservation;
import logic.Wish;
import logic.User;

public interface UserMapper {
	
	@Insert("insert into useraccount (userid, pass, name, tel, email, type) "
			+ "values(#{userid},#{pass}, #{name}, #{tel}, #{email}, #{type})")
	void insert(User user);
	
	
	@Select("select * from useraccount where userid=#{userid}")
	User selectOne(String userid);

	
	@Update("update useraccount set name=#{name}, email=#{email} where userid=#{userid}")
	void update(User user);

	@Update("update useraccount set pass=#{pass} where userid=#{userid}")
	void passwordupdate(Map<String, Object> param);

	@Delete("delete from useraccount where userid=#{userid}")
	void delete(String userid);

	@Select("select * from useraccount")
	List<User> userlist();

	@Select({"<script>",
		 "select ${col} from useraccount",
		"<trim prefix='where' prefixOverrides='AND||OR'>"
		+"<if test='userid != null'> and userid =#{userid}</if>"
		+ "and email=#{email} and tel=#{tel}</trim>",
		"</script>"})
	String search(Map<String, Object> param);
	
	
}
