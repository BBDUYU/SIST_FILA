package products;

import java.util.Date;

public class ProductsDTO {
    
    // 1. PRODUCTS 테이블 컬럼
    private String product_id;      // 상품 ID (PK)
    private int category_id;        // 카테고리 ID (FK)
    private String name;            // 상품명
    private String description;     // 상품 설명
    private int price;              // 정가
    private int view_count;         // 조회수
    private Date created_at;        // 등록일
    private Date updated_at;        // 수정일
    private String status;          // 상태 (SALE, SOLDOUT 등)
    private int discount_rate;      // 할인율
    
    // 2. PRODUCT_IMAGE 테이블 컬럼 (조인해서 가져올 대표 이미지)
    private String image_url;       // 대표 이미지 URL
    
    // 기본 생성자
    public ProductsDTO() {}

    // ★ 모든 Getter & Setter 직접 생성 (롬복 없이 안전하게!)
    public String getProduct_id() { return product_id; }
    public void setProduct_id(String product_id) { this.product_id = product_id; }

    public int getCategory_id() { return category_id; }
    public void setCategory_id(int category_id) { this.category_id = category_id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public int getView_count() { return view_count; }
    public void setView_count(int view_count) { this.view_count = view_count; }

    public Date getCreated_at() { return created_at; }
    public void setCreated_at(Date created_at) { this.created_at = created_at; }

    public Date getUpdated_at() { return updated_at; }
    public void setUpdated_at(Date updated_at) { this.updated_at = updated_at; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getDiscount_rate() { return discount_rate; }
    public void setDiscount_rate(int discount_rate) { this.discount_rate = discount_rate; }

    public String getImage_url() {
        // 값이 없으면 빈 문자열 리턴
        if (this.image_url == null || this.image_url.isEmpty()) return "";
     
        // 역슬래시를 슬래시로 바꾸고 서블릿 경로 붙여서 리턴
        String webPath = this.image_url.replace("\\", "/");
        return "/SIST_FILA/displayImage.do?path=" + webPath;
    }
    
    public void setImage_url(String image_url) { 
        this.image_url = image_url; 
    }
}