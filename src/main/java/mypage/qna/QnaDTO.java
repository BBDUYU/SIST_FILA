package mypage.qna;

import java.sql.Timestamp;

public class QnaDTO {

    private long inquiryId;
    private long userNumber;

    private int categoryId;        // ⭐ 추가
    private String categoryName;

    private String title;
    private String content;
    private String status;

    private String replyContent;
    private Timestamp replyAt;
    private Timestamp createdAt;

    public long getInquiryId() {
        return inquiryId;
    }
    public void setInquiryId(long inquiryId) {
        this.inquiryId = inquiryId;
    }

    public long getUserNumber() {
        return userNumber;
    }
    public void setUserNumber(long userNumber) {
        this.userNumber = userNumber;
    }

    public int getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getReplyContent() {
        return replyContent;
    }
    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public Timestamp getReplyAt() {
        return replyAt;
    }
    public void setReplyAt(Timestamp replyAt) {
        this.replyAt = replyAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
