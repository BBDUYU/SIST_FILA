package products;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class productsDTO {
	
	// 1. PRODUCTS 테이블 컬럼
    private String product_id;      // 상품 ID (PK)
    private int category_id;        // 카테고리 ID (FK)
    private String name;            // 상품명
    private String description;     // 상품 설명
    private int price;              // 정가
    private int view_count;         // 조회수
    private Date created_at;        // 등록일
    private Date updated_at;		// 수정일
    private String status;          // 상태 (SALE, SOLDOUT 등)
    private int discount_rate;      // 할인율
    
    // 2. PRODUCT_IMAGE 테이블 컬럼 (조인해서 가져올 대표 이미지)
    private String image_url;       // 대표 이미지 URL
    
    
}
