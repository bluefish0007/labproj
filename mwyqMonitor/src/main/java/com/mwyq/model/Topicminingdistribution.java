package com.mwyq.model;

public class Topicminingdistribution {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topicminingdistribution.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topicminingdistribution.topic_id
     *
     * @mbggenerated
     */
    private String topic_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topicminingdistribution.entity_id
     *
     * @mbggenerated
     */
    private Integer entity_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column topicminingdistribution.distribution
     *
     * @mbggenerated
     */
    private Double distribution;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topicminingdistribution.id
     *
     * @return the value of topicminingdistribution.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topicminingdistribution.id
     *
     * @param id the value for topicminingdistribution.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topicminingdistribution.topic_id
     *
     * @return the value of topicminingdistribution.topic_id
     *
     * @mbggenerated
     */
    public String getTopic_id() {
        return topic_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topicminingdistribution.topic_id
     *
     * @param topic_id the value for topicminingdistribution.topic_id
     *
     * @mbggenerated
     */
    public void setTopic_id(String topic_id) {
        this.topic_id = topic_id == null ? null : topic_id.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topicminingdistribution.entity_id
     *
     * @return the value of topicminingdistribution.entity_id
     *
     * @mbggenerated
     */
    public Integer getEntity_id() {
        return entity_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topicminingdistribution.entity_id
     *
     * @param entity_id the value for topicminingdistribution.entity_id
     *
     * @mbggenerated
     */
    public void setEntity_id(Integer entity_id) {
        this.entity_id = entity_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column topicminingdistribution.distribution
     *
     * @return the value of topicminingdistribution.distribution
     *
     * @mbggenerated
     */
    public Double getDistribution() {
        return distribution;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column topicminingdistribution.distribution
     *
     * @param distribution the value for topicminingdistribution.distribution
     *
     * @mbggenerated
     */
    public void setDistribution(Double distribution) {
        this.distribution = distribution;
    }
}