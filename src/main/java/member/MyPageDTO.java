package member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MyPageDTO {
    private int couponCount;    // 사용 가능한 쿠폰 수
    private int pointBalance;   // 현재 포인트 잔액
    private int wishlistCount;  // 위시리스트 담은 수
    private int orderCount;     // 총 주문 내역 수
    
    public MyPageDTO() {}

    public int getCouponCount() { return couponCount; }
    public void setCouponCount(int couponCount) { this.couponCount = couponCount; }

    public int getPointBalance() { return pointBalance; }
    public void setPointBalance(int pointBalance) { this.pointBalance = pointBalance; }

    public int getWishlistCount() { return wishlistCount; }
    public void setWishlistCount(int wishlistCount) { this.wishlistCount = wishlistCount; }

    public int getOrderCount() { return orderCount; }
    public void setOrderCount(int orderCount) { this.orderCount = orderCount; }
}