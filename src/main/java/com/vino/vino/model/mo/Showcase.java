package com.vino.vino.model.mo;

public class Showcase {

    private Long showcase_id;
    private Long wine_id;
    private boolean deleted;

    public Long getShowcaseId() {
        return showcase_id;
    }

    public void setShowcaseId(Long showcase_id) { this.showcase_id = showcase_id; }

    public Long getWineId() {
        return wine_id;
    }

    public void setWineId(Long wine_id) { this.wine_id = wine_id; }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
}
