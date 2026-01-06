package admin.domain;

import lombok.Data;

@Data
public class StyleProductDTO {
    private String product_id; 
    private int style_id;     
    private int sort_order;   
    
    private String product_name; 
    private String product_image;
    private int price;
}
