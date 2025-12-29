package wishlist;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WishlistDTO {
	
	private int wishlist_id;		// 위시리스트 PK
	private String product_id;		// 상품 ID
	private String name;			// 상품명
	private int price;				// 가격(원가)
	private int discount_rate;		// 할인율
	private String image_url;		// 썸네일 이미지
	private Date created_at;		// 담은 날짜
	private String color_options;	// 색상 옵션 정보
}
