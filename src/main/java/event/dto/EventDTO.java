package event.dto;

import java.util.Date;

public class EventDTO {
    private long eventId;
    private String eventName;
    private String eventCategory;
    private String url;
    private String description;
    private Date startAt;
    private Date endAt;
    private String isActive;

    // getter/setter
    public long getEventId() { return eventId; }
    public void setEventId(long eventId) { this.eventId = eventId; }
    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }
    public String getEventCategory() { return eventCategory; }
    public void setEventCategory(String eventCategory) { this.eventCategory = eventCategory; }
    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Date getStartAt() { return startAt; }
    public void setStartAt(Date startAt) { this.startAt = startAt; }
    public Date getEndAt() { return endAt; }
    public void setEndAt(Date endAt) { this.endAt = endAt; }
    public String getIsActive() { return isActive; }
    public void setIsActive(String isActive) { this.isActive = isActive; }
}
