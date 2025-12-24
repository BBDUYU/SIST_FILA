package products;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductsOptionDTO {
    private String groupName; // 옵션 종류 (예: "색상", "사이즈")
    private List<String> values = new ArrayList<>(); // 옵션 값 목록

    public ProductsOptionDTO() {}
    public ProductsOptionDTO(String groupName) {
        this.groupName = groupName;
    }

    public void addValue(String value) {
        this.values.add(value);
    }

    // Getter & Setter
    public String getGroupName() { return groupName; }
    public void setGroupName(String groupName) { this.groupName = groupName; }
    public List<String> getValues() { return values; }
    public void setValues(List<String> values) { this.values = values; }
}