package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ReservationMapper;
import logic.Reservation;


@Repository
public class ReservationDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String, Object> param = new HashMap<>();
	private Class<ReservationMapper> cls = ReservationMapper.class;
	
	public List<Reservation> reservationlist(String id) {
		return template.getMapper(cls).reservationlist(id);
	}
	public List<Reservation> reservationBakery(String id) {
		return template.getMapper(cls).reservationBakery(id);
	}
	
	public Reservation reservationSelectOne(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {
		return template.getMapper(cls).reservationselectOne(userid, bakeryid);
	}
	public void deleteReservation(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {
		System.out.println("dao : " + userid + "," + bakeryid);
		template.getMapper(cls).deleteReservation(userid, bakeryid);
	}
}
