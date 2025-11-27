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
            pstmt.setString(10, project.getDepartment());
            
            return pstmt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt);
        }
        return 0;
    }

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
                dto.setDepartment(rs.getString("department"));
                dto.setProjectDescription(rs.getString("projectDescription"));
                
                projectList.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return projectList;
    }

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
                dto.setDepartment(rs.getString("department"));
                dto.setCreateDate(rs.getString("createDate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return dto;
    }
    
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
                app.setProjectTitle(rs.getString("projectTitle"));
                
                list.add(app);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBManager.close(conn, pstmt, rs);
        }
        return list;
    }

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
                   + "department = ? "
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
            
            pstmt.setString(9, project.getDepartment());

            pstmt.setInt(10, project.getProjectID());

            return pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
           DBManager.close(conn, pstmt);
        }
        return -1;
    }

    public int delete(int projectId) {
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
    
    public List<StatsDTO> countProjectsNearDeadline() {
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

    public List<StatsDTO> countProjectsByDept() {
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