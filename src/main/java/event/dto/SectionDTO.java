package event.dto;

import java.util.ArrayList;
import java.util.List;

import products.productsDTO;

public class SectionDTO {
    private long sectionId;
    private long eventId;
    private Integer sortOrder;

    private String title; // (추천) 섹션 제목 컬럼이 없으면 임시로 sectionId로 표시하거나, 컬럼 추가 추천
    private List<SectionImageDTO> images = new ArrayList<>();
    private List<productsDTO> products = new ArrayList<>();

    // getter/setter
    public long getSectionId() { return sectionId; }
    public void setSectionId(long sectionId) { this.sectionId = sectionId; }
    public long getEventId() { return eventId; }
    public void setEventId(long eventId) { this.eventId = eventId; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public List<SectionImageDTO> getImages() { return images; }
    public List<productsDTO> getProducts() { return products; }
}
