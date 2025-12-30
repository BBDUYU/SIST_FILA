package admin.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CreateproductDTO {
	private String product_id;    
	private int category_id;       
	private String name;           
	private String description;     
	private int price;             
	private int view_count;         
	private Date created_at;        
	private Date updated_at;        
	private String status;          
	private int discount_rate;      

	private int product_image_id;
	private String image_url;
	private String image_type;
	private int is_main;
	private int sort_order;
	
	private int rel_id;
	
	
	private String[] category_ids; 
    private String sport_option;    
    private String[] size_options;
	
}
