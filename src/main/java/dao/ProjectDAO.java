package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.ApplicationDTO;
import dto.ProjectDTO;
import dto.StatsDTO;
import util.DBManager;

public class ProjectDAO {

    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

    /**
     * 1. 프로젝트 생성 (학과 정보 포함)
     */
    public int createProject(ProjectDTO project) {
        String sql = "INSERT INTO PROJECT (projectTitle, projectType, projectDuration, techStacks, "
                   + "requiredRoles, projectDescription, deadline, totalMembers, leaderID, status, createDate, department) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, '모집 중', NOW(), ?)";
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, project.getProjectTitle());
            pstmt.setString(2, project.getProjectType());
            pstmt.setString(3, project.getProjectDuration());
            pstmt.setString(4, project.getTechStacks());
            pstmt.setString(5, project.getRequiredRoles());
            pstmt.setString(6, project.getProjectDescription());
            pstmt.setString(7, project.getDeadline());
            pstmt.setInt(8, project.getTotalMembers());
            pstmt.setString(9, project.getLeaderID()); 
            pstmt.setString(10, project.getDepartment()); // [중요] 학과 추가
            
            return pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt);
        }
        return 0;
    }

    /**
     * 2. 모집 중인 전체 프로젝트 목록 조회
     */
    public List<ProjectDTO> getAllProjects() {
        List<ProjectDTO> projectList = new ArrayList<>();
        String sql = "SELECT * FROM PROJECT WHERE status = '모집 중' ORDER BY createDate DESC";
        
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ProjectDTO dto = new ProjectDTO();
                dto.setProjectID(rs.getInt("projectID"));
                dto.setProjectTitle(rs.getString("projectTitle"));
                dto.setProjectType(rs.getString("projectType"));
                dto.setTechStacks(rs.getString("techStacks"));
                dto.setDeadline(rs.getString("deadline"));
                dto.setTotalMembers(rs.getInt("totalMembers"));
                dto.setCurrentMembers(rs.getInt("currentMembers"));
                dto.setLeaderID(rs.getString("leaderID")); 
                dto.setDepartment(rs.getString("department")); // [중요] 학과 추가
                dto.setProjectDescription(rs.getString("projectDescription")); // 목록 표시에 필요할 수 있음
                
                projectList.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return projectList;
    }

    /**
     * 3. 특정 프로젝트 상세 조회
     */
    public ProjectDTO getProjectById(String projectID) {
        ProjectDTO dto = null;
        String sql = "SELECT * FROM PROJECT WHERE projectID = ?";
        
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(projectID));
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                dto = new ProjectDTO();
                dto.setProjectID(rs.getInt("projectID"));
                dto.setProjectTitle(rs.getString("projectTitle"));
                dto.setProjectType(rs.getString("projectType"));
                dto.setProjectDuration(rs.getString("projectDuration"));
                dto.setTechStacks(rs.getString("techStacks"));
                dto.setRequiredRoles(rs.getString("requiredRoles"));
                dto.setProjectDescription(rs.getString("projectDescription"));
                dto.setDeadline(rs.getString("deadline"));
                dto.setTotalMembers(rs.getInt("totalMembers"));
                dto.setCurrentMembers(rs.getInt("currentMembers"));
                dto.setStatus(rs.getString("status"));
                dto.setLeaderID(rs.getString("leaderID"));
                dto.setDepartment(rs.getString("department")); // [중요] 학과 추가
                dto.setCreateDate(rs.getString("createDate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return dto;
    }
    
    /**
     * 4. 내가 팀장인 프로젝트 목록 조회 (마이페이지)
     */
    public List<ProjectDTO> getProjectsByLeader(String leaderID) {
        List<ProjectDTO> projectList = new ArrayList<>();
        String sql = "SELECT * FROM PROJECT WHERE leaderID = ? ORDER BY createDate DESC";
        
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, leaderID);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ProjectDTO dto = new ProjectDTO();
                dto.setProjectID(rs.getInt("projectID"));
                dto.setProjectTitle(rs.getString("projectTitle"));
                dto.setTotalMembers(rs.getInt("totalMembers"));
                dto.setCurrentMembers(rs.getInt("currentMembers"));
                dto.setStatus(rs.getString("status"));
                dto.setDepartment(rs.getString("department"));
                
                projectList.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return projectList;
    }

    /**
     * 5. 내가 지원한 프로젝트 목록 조회 (마이페이지 - JOIN 사용)
     * 반환 타입: List<ApplicationDTO>
     */
    public List<ApplicationDTO> getAppliedProjects(String userId) {
        List<ApplicationDTO> list = new ArrayList<>();
        
        String sql = "SELECT A.appID, A.projectID, A.status, P.projectTitle "
                   + "FROM APPLICATION A "
                   + "JOIN PROJECT P ON A.projectID = P.projectID "
                   + "WHERE A.userID = ? "
                   + "ORDER BY A.appID DESC";
        
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ApplicationDTO app = new ApplicationDTO();
                app.setAppId(rs.getInt("appID"));
                app.setProjectId(rs.getInt("projectID"));
                app.setStatus(rs.getString("status"));
                app.setProjectTitle(rs.getString("projectTitle")); // 제목 담기
                
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return list;
    }

    /**
     * 6. 프로젝트 정보 수정 (학과 포함)
     */
    public int updateProject(ProjectDTO project) {
        String sql = "UPDATE PROJECT SET "
                   + "projectTitle = ?, "
                   + "projectType = ?, "
                   + "deadline = ?, "
                   + "projectDuration = ?, "
                   + "totalMembers = ?, "
                   + "techStacks = ?, "
                   + "requiredRoles = ?, "
                   + "projectDescription = ?, "
                   + "department = ? " // [중요] 학과 수정 추가
                   + "WHERE projectID = ?";

        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, project.getProjectTitle());
            pstmt.setString(2, project.getProjectType());
            pstmt.setString(3, project.getDeadline());
            pstmt.setString(4, project.getProjectDuration());
            pstmt.setInt(5, project.getTotalMembers());
            pstmt.setString(6, project.getTechStacks());
            pstmt.setString(7, project.getRequiredRoles());
            pstmt.setString(8, project.getProjectDescription());
            
            // [중요] 9번째 파라미터: 학과
            pstmt.setString(9, project.getDepartment());

            // [중요] 10번째 파라미터: ID (int형)
            pstmt.setInt(10, project.getProjectID());

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
           DBManager.close(conn, pstmt);
        }
        return -1;
    }

    /**
     * 7. 프로젝트 삭제
     */
    public int delete(int projectId) {
        // [주의] DB 컬럼명이 projectID인지 확인
        String sql = "DELETE FROM PROJECT WHERE projectID = ?";
        
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, projectId);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt);
        }
        return -1;
    }
    
    /**
     * 8. [통계] 마감 임박 프로젝트 (학과별 개수)
     */
    public List<StatsDTO> countProjectsNearDeadline() {
        // [수정 완료] FROM PROJECT 추가, 띄어쓰기 수정
        String sql = "SELECT department, count(department) as cnt "
                   + "FROM PROJECT "
                   + "WHERE DATEDIFF(deadline, CURDATE()) BETWEEN 0 AND 3 "
                   + "GROUP BY department "
                   + "ORDER BY cnt DESC";

        List<StatsDTO> list = new ArrayList<>();
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StatsDTO stats = new StatsDTO();
                stats.setDepartment(rs.getString("department"));
                stats.setNumber(rs.getInt("cnt"));
                list.add(stats);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return list;
    }

    /**
     * 9. [통계] 전체 프로젝트 (학과별 개수)
     */
    public List<StatsDTO> countProjectsByDept() {
        // [수정 완료] FROM PROJECT 추가, 띄어쓰기 수정
        String sql = "SELECT department, count(department) as cnt "
                   + "FROM PROJECT "
                   + "GROUP BY department";
                   
        List<StatsDTO> list = new ArrayList<>();
        try {
            conn = DBManager.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                StatsDTO stats = new StatsDTO();
                stats.setDepartment(rs.getString("department"));
                stats.setNumber(rs.getInt("cnt"));
                list.add(stats);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return list;
    }
}