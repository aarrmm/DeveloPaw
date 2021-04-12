package ga.bowwow.service.store;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Order {
	private int order_id;		// 주문 번호
	private int p_id;				// 주문한 상품 번호
	private int member_serial;		// 회원 번호
	private int amount;				// 주문한 상품 수량
	private int totalSum;			// 총 구매 가격
	private String memo;			// 배송 관련 메모
	private String order_date;		// 주문 날짜
	private String order_status;	// 주문 진행 상황
	private String address;			// 기본 주소
	private String address_detail;	// 상세 주소
	private String zip;				// 우편번호
	private int order_point;		// 적립 포인트
	private String phone;			// 주문자 핸드폰 번호
	private String s_image;			// 상품 이미지
	private String p_type;			// 상품 타입
	private String p_name;			// 상품 이름
	private int sum;				// 상품 한개의 총 금액

	private int price;
	private String realname;		// 실명

}
