package dao.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import logic.Reservation;

public interface ReservationMapper {
		
		//����� ���� ���� ����Ʈ
		@Select("select r.userid, r.no, r.prenum, r.predate, r.bakeryid, b.bname from reservation r inner join bakery b on r.bakeryid = b.bakeryid where r.userid=#{userid}")
		List<Reservation> reservationlist(String userid);

		//���� ���� ����Ʈ
		@Select("select r.userid, u.name, r.predate, b.bakeryid from reservation r inner join bakery b on r.bakeryid = b.bakeryid inner join useraccount u on r.userid = u.userid where b.userid = (select userid from bakery where userid = #{userid} and TO_CHAR(predate, 'YYYY-MM-DD') = (SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL))")
		List<Reservation> reservationBakery(String userid);

		//���� ���� ����
		@Select("select b.bname from reservation r inner join bakery b on r.bakeryid = b.bakeryid where r.userid=#{userid} and r.bakeryid=#{bakeryid}")
		Reservation reservationselectOne(@Param("userid") String userid, @Param("bakeryid") String bakeryid);

		//���� ���� ����
		@Delete("delete from reservation where userid=#{userid} and bakeryid=#{bakeryid}")
		void deleteReservation(@Param("userid") String userid, @Param("bakeryid") String bakeryid);

}
