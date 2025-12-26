package event;

public class EventDTO {				// DTO 또는 VO
    private int productNo;
    private String name;
    private int price;
    private String imageUrl;
    private String linkUrl;
    private String category; // 예: "공용"
    private String tag;      // 예: "테니스"

    public EventDTO(int productNo, String name, int price, String imageUrl, String linkUrl,
                        String category, String tag) {
        this.productNo = productNo;
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.linkUrl = linkUrl;
        this.category = category;
        this.tag = tag;
    }

    public int getProductNo() { return productNo; }
    public String getName() { return name; }
    public int getPrice() { return price; }
    public String getImageUrl() { return imageUrl; }
    public String getLinkUrl() { return linkUrl; }
    public String getCategory() { return category; }
    public String getTag() { return tag; }
}
