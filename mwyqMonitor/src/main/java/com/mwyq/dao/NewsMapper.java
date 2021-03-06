package com.mwyq.dao;

import com.mwyq.model.News;
import com.mwyq.model.NewsExample;
import com.mwyq.model.newsNumStatic;
import com.mwyq.model.sensitiveTendency;
import com.mwyq.model.typeCategory;
import com.mwyq.model.typeQuery;
import com.mwyq.model.typeSensitive;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface NewsMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    int countByExample(NewsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    int deleteByExample(NewsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer news_id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    int insert(News record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    int insertSelective(News record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    List<News> selectByExample(NewsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    News selectByPrimaryKey(Integer news_id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") News record, @Param("example") NewsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") News record, @Param("example") NewsExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(News record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table news
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(News record);
    
    
    
 //   List<News> getTopTimeNew();
    List<News> getLastestNews(@Param("lang") String lang);
    
    List<News> getSensitiveNews(@Param("lang") String lang);
    
    News getLastestOneNews(@Param("lang") String lang);
    
    News getLastestSensitiveNews(@Param("lang") String lang);
    
    int getChineseCount();
    
    int getMengCount();
    
    int getWeiCount();
    
    int getZangCount();
    
    int getLastestNewsCount();
    
    int getCountByTime(@Param("time") String time,@Param("lang") String lang);
    
    int getMonthSensitive1Count(@Param("lang") String lang,@Param("begin") String begin,@Param("end") String end);
    
    int getMonthSensitive2Count(@Param("lang") String lang,@Param("begin") String begin,@Param("end") String end);
    
    int getSourseCount(@Param("name") String name);
    
    int getNewsCountByData(@Param("date") String date,@Param("lang") String lang);
    
    List<String> getSourse();
    
    Date getTimeByID(@Param("clickId") String clickId);
    
    Date getSensitiveLastestTime(@Param("lang") String lang);
    
    Date getNewsTimeByLang(@Param("lang") String lang);
   // int getSensitiveNewsCount(@Param("lang") String lang);
    
    List<typeQuery> getSourseAndCount(@Param("lang") String lang);

    List<typeSensitive> getSebsitiveTrend();
    
    List<sensitiveTendency> getSensitiveTrency(@Param("lang") String lang);
    
    List<newsNumStatic> getAllNewsCount();
    
    List<typeCategory> getNewsCategory(@Param("lang") String lang);
}