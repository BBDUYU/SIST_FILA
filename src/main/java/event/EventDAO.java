package event;

import event.dto.*;
import products.productsDTO;

import java.sql.*;
import java.util.*;

public class EventDAO {

    public EventDetailDTO selectEventDetail(Connection con, long eventId) throws SQLException {
        EventDTO event = selectEvent(con, eventId);
        if (event == null) return null;

        List<SectionDTO> sections = selectSections(con, eventId);
        Map<Long, SectionDTO> sectionMap = new LinkedHashMap<>();
        for (SectionDTO s : sections) {
            // 섹션 제목 컬럼이 없다면 임시로 이렇게라도
            s.setTitle("SECTION " + s.getSectionId());
            sectionMap.put(s.getSectionId(), s);
        }

        if (!sectionMap.isEmpty()) {
            attachSectionImages(con, sectionMap);
            attachSectionProducts(con, sectionMap);
        }

        EventDetailDTO detail = new EventDetailDTO();
        detail.setEvent(event);
        detail.setSections(new ArrayList<>(sectionMap.values()));
        return detail;
    }

    private EventDTO selectEvent(Connection con, long eventId) throws SQLException {
        String sql = "SELECT EVENT_ID, EVENT_NAME, EVENT_CATEGORY, URL, DESCRIPTION, START_AT, END_AT, IS_ACTIVE " +
                     "FROM EVENT WHERE EVENT_ID = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                EventDTO e = new EventDTO();
                e.setEventId(rs.getLong("EVENT_ID"));
                e.setEventName(rs.getString("EVENT_NAME"));
                e.setEventCategory(rs.getString("EVENT_CATEGORY"));
                e.setUrl(rs.getString("URL"));
                e.setDescription(rs.getString("DESCRIPTION"));
                e.setStartAt(rs.getDate("START_AT"));
                e.setEndAt(rs.getDate("END_AT"));
                e.setIsActive(rs.getString("IS_ACTIVE"));
                return e;
            }
        }
    }

    private List<SectionDTO> selectSections(Connection con, long eventId) throws SQLException {
        String sql = "SELECT SECTION_ID, EVENT_ID, SORT_ORDER " +
                     "FROM EVENT_SECTION WHERE EVENT_ID = ? ORDER BY SORT_ORDER";
        List<SectionDTO> list = new ArrayList<>();
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setLong(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                	SectionDTO s = new SectionDTO();
                    s.setSectionId(rs.getLong("SECTION_ID"));
                    s.setEventId(rs.getLong("EVENT_ID"));
                    s.setSortOrder((Integer) rs.getObject("SORT_ORDER"));
                    list.add(s);
                }
            }
        }
        return list;
    }

    private void attachSectionImages(Connection con, Map<Long, SectionImageDTO> sectionMap) throws SQLException {
        String sql = "SELECT SECTION_IMAGE_ID, SECTION_ID, IMAGE_URL, ALT_TEXT, LINK_URL, SORT_ORDER " +
                     "FROM EVENT_SECTION_IMAGE " +
                     "WHERE SECTION_ID = ? ORDER BY SORT_ORDER";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (Long sectionId : sectionMap.keySet()) {
                ps.setLong(1, sectionId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        SectionImageDTO img = new SectionImageDTO();
                        img.setSectionImageId(rs.getLong("SECTION_IMAGE_ID"));
                        img.setSectionId(rs.getLong("SECTION_ID"));
                        img.setImageUrl(rs.getString("IMAGE_URL"));
                        img.setAltText(rs.getString("ALT_TEXT"));
                        img.setLinkUrl(rs.getString("LINK_URL"));
                        img.setSortOrder((Integer) rs.getObject("SORT_ORDER"));

                        sectionMap.get(sectionId).getImages().add(img);
                    }
                }
            }
        }
    }

    private void attachSectionProducts(Connection con, Map<Long, SectionDTO> sectionMap) throws SQLException {
        String sql =
            "SELECT ep.SECTION_ID, p.PRODUCT_ID, p.NAME, p.PRICE, p.VIEW_COUNT, p.STATUS, p.DISCOUNT_RATE " +
            "FROM EVENT_PRODUCT ep " +
            "JOIN PRODUCTS p ON p.PRODUCT_ID = ep.PRODUCT_ID " +
            "WHERE ep.SECTION_ID = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            for (Long sectionId : sectionMap.keySet()) {
                ps.setLong(1, sectionId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        productsDTO p = new productsDTO();
                        p.setProductId(rs.getString("PRODUCT_ID"));
                        p.setName(rs.getString("NAME"));
                        p.setPrice(rs.getLong("PRICE"));
                        p.setViewCount((Long) rs.getObject("VIEW_COUNT"));
                        p.setStatus(rs.getString("STATUS"));
                        p.setDiscountRate((Integer) rs.getObject("DISCOUNT_RATE"));

                        sectionMap.get(sectionId).getProducts().add(p);
                    }
                }
            }
        }
    }
}
