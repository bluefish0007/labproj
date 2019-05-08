package com.mwyq.model;

public class EntityTopicRelation {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column entity_topic_relation.id
     *
     * @mbggenerated
     */
    private Integer id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column entity_topic_relation.entity_id
     *
     * @mbggenerated
     */
    private Integer entity_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column entity_topic_relation.entity_type
     *
     * @mbggenerated
     */
    private String entity_type;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column entity_topic_relation.topic_id
     *
     * @mbggenerated
     */
    private String topic_id;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column entity_topic_relation.relation
     *
     * @mbggenerated
     */
    private Double relation;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column entity_topic_relation.id
     *
     * @return the value of entity_topic_relation.id
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column entity_topic_relation.id
     *
     * @param id the value for entity_topic_relation.id
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column entity_topic_relation.entity_id
     *
     * @return the value of entity_topic_relation.entity_id
     *
     * @mbggenerated
     */
    public Integer getEntity_id() {
        return entity_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column entity_topic_relation.entity_id
     *
     * @param entity_id the value for entity_topic_relation.entity_id
     *
     * @mbggenerated
     */
    public void setEntity_id(Integer entity_id) {
        this.entity_id = entity_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column entity_topic_relation.entity_type
     *
     * @return the value of entity_topic_relation.entity_type
     *
     * @mbggenerated
     */
    public String getEntity_type() {
        return entity_type;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column entity_topic_relation.entity_type
     *
     * @param entity_type the value for entity_topic_relation.entity_type
     *
     * @mbggenerated
     */
    public void setEntity_type(String entity_type) {
        this.entity_type = entity_type == null ? null : entity_type.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column entity_topic_relation.topic_id
     *
     * @return the value of entity_topic_relation.topic_id
     *
     * @mbggenerated
     */
    public String getTopic_id() {
        return topic_id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column entity_topic_relation.topic_id
     *
     * @param topic_id the value for entity_topic_relation.topic_id
     *
     * @mbggenerated
     */
    public void setTopic_id(String topic_id) {
        this.topic_id = topic_id == null ? null : topic_id.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column entity_topic_relation.relation
     *
     * @return the value of entity_topic_relation.relation
     *
     * @mbggenerated
     */
    public Double getRelation() {
        return relation;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column entity_topic_relation.relation
     *
     * @param relation the value for entity_topic_relation.relation
     *
     * @mbggenerated
     */
    public void setRelation(Double relation) {
        this.relation = relation;
    }
}