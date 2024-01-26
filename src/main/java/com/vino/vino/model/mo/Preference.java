package com.vino.vino.model.mo;

public class Preference {

    private Long preference_id;

    /* M:N */
    private User[] users;

    private Long user_id;
    private String category;
    private Long times;
    private boolean deleted;

    public Long getPreferenceId() { return preference_id; }

    public void setPreferenceId(Long preference_id) { this.preference_id = preference_id; }

    public Long getUserId() { return user_id; }

    public void setUserId(Long user_id) { this.user_id = user_id; }

    public String getCategory() {return category; }

    public void setCategory(String category) { this.category = category; }

    public Long getTimes() { return times; }

    public void setTimes(Long times) { this.times = times; }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
}

