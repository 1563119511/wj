/**
 * @author: created by wwbweibo
 * @version: 1.0
 * @date: 2019/4/26
 */

package se.model.Mapper;

import org.apache.ibatis.annotations.Param;
import se.model.Grade;

import java.util.List;

public interface GradeMapper {
    // 查询成绩
    List<Grade> TeacherQueryGrade(String userId);

    // 根据学生ID查询成绩
    List<Grade> StudentGrade(String userId);

    int UpdateStudentGrade(List<Grade> gradeList);

    int Grade_selfjudge(@Param(value = "grade") float greade,
                        @Param(value = "userId") String userId);

    int CalcGradeNormal();
}
