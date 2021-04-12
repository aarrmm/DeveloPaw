package ga.bowwow.service.user.VO;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@NoArgsConstructor @AllArgsConstructor
@ToString

public class UserDTO extends UserAccount {
	int member_serial;
	String id;
	String email;
	String citizen_id;
	String phone;
	String status;
	String password;
	long point;
	String coupons;
	String image_source;
	String nickname;
	String realname;
	Date reg_date;
	Date birthday;
	String gender;
//	ArrayList<UserAddress> user_address;
//	ArrayList<UserWallet> userWallet;
	
}
