package event.dto;

public class SectionImageDTO {
    private long sectionImageId;
    private long sectionId;
    private String imageUrl;
    private String altText;
    private String linkUrl;
    private Integer sortOrder;

    // getter/setter
    public long getSectionImageId() { return sectionImageId; }
    public void setSectionImageId(long sectionImageId) { this.sectionImageId = sectionImageId; }
    public long getSectionId() { return sectionId; }
    public void setSectionId(long sectionId) { this.sectionId = sectionId; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public String getAltText() { return altText; }
    public void setAltText(String altText) { this.altText = altText; }
    public String getLinkUrl() { return linkUrl; }
    public void setLinkUrl(String linkUrl) { this.linkUrl = linkUrl; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
}
